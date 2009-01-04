#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright (C) 2003-2009 Gerard Vermeulen
#
# This file is part of PyQwt.
#
# PyQwt is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# PyQwt is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# In addition, as a special exception, Gerard Vermeulen gives permission
# to link PyQwt dynamically with non-free versions of Qt and PyQt,
# and to distribute PyQwt in this form, provided that equally powerful
# versions of Qt and PyQt have been released under the terms of the GNU
# General Public License.
#
# If PyQwt is dynamically linked with non-free versions of Qt and PyQt,
# PyQwt becomes a free plug-in for a non-free program.


"""
Provides a command line interpreter friendly layer over `QwtPlot`.
An example of its use is:

>>> import numpy as np
>>> from qt import *
>>> from Qwt5 import *
>>> from Qwt5.qplt import *
>>> application = QApplication([])
>>> x = np.arange(-2*np.pi, 2*np.pi, 0.01)
>>> p = Plot(
...  Curve(x, np.cos(x), Pen(Magenta, 2), 'cos(x)'),
...  Curve(x, np.exp(x), Pen(Red), 'exp(x)', Y2),
...  Axis(Y2, Log),
...  'PyQwt using Qwt-%s -- http://qwt.sf.net' % QWT_VERSION_STR)
>>> QPixmap.grabWidget(p).save('cli-plot-1.png', 'PNG')
True
>>> x = x[0:-1:10]
>>> p.plot(
...  Curve(x, np.cos(x-np.pi/4), Symbol(Circle, Yellow), 'circle'),
...  Curve(x, np.cos(x+np.pi/4), Pen(Blue), Symbol(Square, Cyan), 'square'))
>>> time.sleep(1)
>>> QPixmap.grabWidget(p).save('cli-plot-2.png', 'PNG')
True
"""


import sys
import time

from qt import *
from Qwt5 import *
from grace import GraceProcess


# QColor aliases
Black       = Qt.black
Blue        = Qt.blue
Cyan        = Qt.cyan
DarkBlue    = Qt.darkBlue
DarkCyan    = Qt.darkCyan
DarkGray    = Qt.darkGray
DarkGreen   = Qt.darkGreen
DarkMagenta = Qt.darkMagenta
DarkRed     = Qt.darkRed
DarkYellow  = Qt.darkYellow
Gray        = Qt.gray
Green       = Qt.green
LightGray   = Qt.lightGray
Magenta     = Qt.magenta
Red         = Qt.red
White       = Qt.white
Yellow      = Qt.yellow

# Qt.PenStyle aliases
NoLine         = Qt.NoPen 
SolidLine      = Qt.SolidLine
DashLine       = Qt.DashLine
DotLine        = Qt.DotLine
DashDotLine    = Qt.DashDotLine
DashDotDotLine = Qt.DashDotDotLine

# QwtPlot.Axis aliases
Y1 = Left   = QwtPlot.yLeft
Y2 = Right  = QwtPlot.yRight
X1 = Bottom = QwtPlot.xBottom
X2 = Top    = QwtPlot.xTop

# QwtScaleEngine aliases
Lin = QwtLinearScaleEngine
Log = QwtLog10ScaleEngine

# QwtScaleEngine.Attribute aliases
NoAttribute      = QwtScaleEngine.NoAttribute
IncludeReference = QwtScaleEngine.IncludeReference
Symmetric        = QwtScaleEngine.Symmetric
Floating         = QwtScaleEngine.Floating
Inverted         = QwtScaleEngine.Inverted

# QwtSymbol.Style aliases
NoSymbol = QwtSymbol.NoSymbol
Circle   = QwtSymbol.Ellipse
Square   = QwtSymbol.Rect
Diamond  = QwtSymbol.Diamond


# font
Font = QFont('Verdana')

class Tracker(QObject):
    def __init__(self, parent):
        QObject.__init__(self, parent)
        parent.setMouseTracking(True)
        parent.installEventFilter(self)

    # __init__()

    def eventFilter(self, _, event):
        if event.type() == QEvent.MouseMove:
            self.emit(PYSIGNAL("MouseMoveTracked"), (event.pos(),))
        return False

    # eventFilter()

# class Tracker


class Plot(QwtPlot):
    """A command line interpreter friendly layer over `QwtPlot`.

    The interpretation of the `*rest` parameters is type dependent:

    - `Axis`: enables the axis.
    - `Curve`: adds a curve.
    - `str` or `QString`: sets the title.
    - `int`: sets a set of mouse events to the zoomer actions.
    - (`int`, `int`): sets the size.
    - `QWidget`: sets the parent widget
    """

    def __init__(self, *rest):
        self.size = (600, 400)

        # get an optional parent widget
        parent = None
        for item in rest:
            if isinstance(item, QWidget):
                parent = item
                self.size = None
        QwtPlot.__init__(self, parent)

        # look
        self.setCanvasBackground(White)
        self.plotLayout().setAlignCanvasToScales(True)

        grid = QwtPlotGrid()
        grid.attach(self)
        grid.setPen(QPen(Black, 0, DotLine))
        
        legend = QwtLegend()
        legend.setItemMode(QwtLegend.ClickableItem)
        self.insertLegend(legend, QwtPlot.RightLegend)

        # zooming
        self.zoomers = []
        zoomer = QwtPlotZoomer(X1,
                               Y1,
                               QwtPicker.DragSelection,
                               QwtPicker.AlwaysOff,
                               self.canvas())
        zoomer.setRubberBandPen(QPen(Black))
        self.zoomers.append(zoomer)
        zoomer = QwtPlotZoomer(X2,
                               Y2,
                               QwtPicker.DragSelection,
                               QwtPicker.AlwaysOff,
                               self.canvas())
        zoomer.setRubberBand(QwtPicker.NoRubberBand)
        self.zoomers.append(zoomer)
        self.setZoomerMouseEventSet(0)

        # initialization
        for item in rest:
            if isinstance(item, Axis):
                self.plotAxis(item)
            elif isinstance(item, Curve):
                self.plotCurve(item)
            elif (isinstance(item, str) or isinstance(item, QString)):
                text = QwtText(item)
                font = QFont(Font)
                font.setPointSize(14)
                font.setBold(True)
                text.setFont(font)
                self.setTitle(text)
            elif isinstance(item, int):
                self.setZoomerMouseEventSet(item)
            elif (isinstance(item, tuple) and len(tuple) == 2
                  and isinstance(item[0], int) and isinstance(item[1], int)):
                self.size = item
            elif isinstance(item, QWidget): # accept a parent silently
                pass
            else:
                print "Plot() fails to accept %s." % item

        if self.size:
            apply(self.resize, self.size)

        # connections
        self.connect(self,
                     SIGNAL("legendClicked(QwtPlotItem*)"),
                     self.toggleVisibility)

        # finalize
        self.show()

    # __init__()

    def plot(self, *rest):
        """Plot additional curves and/or axes.

        The interpretation of the `*rest` parameters is type dependent:

        - `Axis`: enables the axis.
        - `Curve`: adds a curve.
        """
        for item in rest:
            if isinstance(item, Axis):
                self.plotAxis(item)
            elif isinstance(item, Curve):
                self.plotCurve(item)
            else:
                print "Plot.plot() fails to accept %s." % item

    # plot()

    def plotAxis(self, axis):
        self.enableAxis(axis.orientation)
        engine = axis.engine()
        engine.setAttributes(axis.attributes)
        self.setAxisScaleEngine(axis.orientation, engine)
        if isinstance(engine, QwtLog10ScaleEngine):
            self.setAxisMaxMinor(axis.orientation, 8)        
        self.setAxisTitle(axis.orientation, axis.title)
        self.clearZoomStack()

    # plotAxis()

    def plotCurve(self, curve):
        c = QwtPlotCurve(curve.name)
        c.setAxis(curve.xAxis, curve.yAxis)
        
        if curve.pen:
            c.setPen(curve.pen)
        else:
            c.setStyle(QwtPlotCurve.NoCurve)
        if curve.symbol:
            c.setSymbol(curve.symbol)
        c.setData(curve.x, curve.y)
        c.attach(self)
        self.clearZoomStack()

    # plotCurve()
    
    def clearZoomStack(self):
        """Force autoscaling and clear the zoom stack
        """
        self.setAxisAutoScale(QwtPlot.yLeft)
        self.setAxisAutoScale(QwtPlot.yRight)
        self.setAxisAutoScale(QwtPlot.xBottom)
        self.setAxisAutoScale(QwtPlot.xTop)
        self.replot()
        for zoomer in self.zoomers:
            zoomer.setZoomBase()

    # clearZoomStack()

    def setZoomerMouseEventSet(self, index):
        """Attach the QwtPlotZoomer actions to a set of mouse events.
        """
        if index == 0:
            pattern = [
                QwtEventPattern.MousePattern(Qt.LeftButton,
                                                 Qt.NoButton),
                QwtEventPattern.MousePattern(Qt.MidButton,
                                                 Qt.NoButton),
                QwtEventPattern.MousePattern(Qt.RightButton,
                                                 Qt.NoButton),
                QwtEventPattern.MousePattern(Qt.LeftButton,
                                                 Qt.ShiftButton),
                QwtEventPattern.MousePattern(Qt.MidButton,
                                                 Qt.ShiftButton),
                QwtEventPattern.MousePattern(Qt.RightButton,
                                                 Qt.ShiftButton),
                ]
            for zoomer in self.zoomers:
                zoomer.setMousePattern(pattern)
        elif index in (1, 2, 3):
            for zoomer in self.zoomers:
                zoomer.initMousePattern(index)
        else:
            raise ValueError, 'index must be in (0, 1, 2, 3)'
        self.__mouseEventSet = index

    # setZoomerMouseEventSet()

    def getZoomerMouseEventSet(self):
        return self.__mouseEventSet

    # getZoomerMouseEventSet()

    def formatCoordinates(self, x, y):
        """Format mouse coordinates as real world plot coordinates.
        """
        result = []
        todo = ((QwtPlot.xBottom, "x0=%+.6g", x),
                (QwtPlot.yLeft,   "y0=%+.6g", y),
                (QwtPlot.xTop,    "x1=%+.6g", x),
                (QwtPlot.yRight,  "y1=%+.6g", y))
        for axis, template, value in todo:
            if self.axisEnabled(axis):
                value = self.invTransform(axis, value)
                result.append(template % value)
        return result

    # formatCoordinates()

    def toggleVisibility(self, plotItem):
        """Toggle the visibility of a plot item
        """
        plotItem.setVisible(not plotItem.isVisible())
        self.replot()

    # toggleCurve()

    def gracePlot(self, saveall="", pause=0.2):
        """Clone the plot into Grace for very high quality hard copy output.

        Know bug: Grace does not scale the data correctly when Grace cannot
        cannot keep up with gracePlot.  This happens when it takes too long
        to load Grace in memory (exit the Grace process and try again) or
        when 'pause' is too short.
        """
        g = GraceProcess(debug = 0)
        g('subtitle "%s"' % self.title().text())
        index = 0
        for xAxis, yAxis, graph, xPlace, yPlace in (
            (X1, Y1, 'g0', 'normal', 'normal'),
            (X1, Y2, 'g1', 'normal', 'opposite'),
            (X2, Y1, 'g2', 'opposite', 'normal'),
            (X2, Y2, 'g3', 'opposite', 'opposite')
            ):
            if not (self.axisEnabled(xAxis) and self.axisEnabled(yAxis)):
                continue
            g('%s on; with %s' % (graph, graph))

            # x-axes
            xmin = self.axisScaleDiv(xAxis).lBound()
            xmax = self.axisScaleDiv(xAxis).hBound()
            #majStep = minStep = axisScale.majStep()
            #majStep *= 2
            g('world xmin %g; world xmax %g' % (xmin, xmax))
            g('xaxis label "%s"; xaxis label char size 1.5'
              % self.axisTitle(xAxis).text())
            g('xaxis label place %s' % xPlace)
            g('xaxis tick place %s' % xPlace)
            g('xaxis ticklabel place %s' % xPlace)
            time.sleep(pause)
            if isinstance(
                self.axisScaleEngine(xAxis), QwtLog10ScaleEngine
                ):
                g('xaxes scale Logarithmic')
                g('xaxis tick major 10')
                g('xaxis tick minor ticks 9')
            else:
                #print 'lin x-axis from %s to %s.' % (min, max)
                g('xaxes scale Normal')
                #g('xaxis tick major %12.6f; xaxis tick minor %12.6f'
                #  % (majStep, minStep))

            # y-axes
            ymin = self.axisScaleDiv(yAxis).lBound()
            ymax = self.axisScaleDiv(yAxis).hBound()
            #majStep = minStep = axisScale.majStep()
            #majStep *= 2
            g('world ymin %g; world ymax %g' % (ymin, ymax))
            g('yaxis label "%s"; yaxis label char size 1.5' %
              self.axisTitle(yAxis).text())
            g('yaxis label place %s' % yPlace)
            g('yaxis tick place %s' % yPlace)
            g('yaxis ticklabel place %s' % yPlace)
            time.sleep(pause)
            if isinstance(
                self.axisScaleEngine(yAxis), QwtLog10ScaleEngine
                ):
                #print 'log y-axis from %s to %s.' % (min, max)
                g('yaxes scale Logarithmic')
                g('yaxis tick major 10')
                g('yaxis tick minor ticks 9')
            else:
                #print 'lin y-axis from %s to %s.' % (min, max)
                g('yaxes scale Normal')
                #g('yaxis tick major %12.6f; yaxis tick minor %12.6f' %
                #  (majStep, minStep))

            # curves
            for curve in self.itemList():
                if not isinstance(curve, QwtPlotCurve):
                    continue
                if not curve.isVisible():
                    continue
                if not (xAxis == curve.xAxis() and yAxis == curve.yAxis()):
                    continue
                g('s%s legend "%s"' % (index, curve.title().text()))
                #print "curve.symbol().style()", curve.symbol().style()
                if curve.symbol().style() > QwtSymbol.NoSymbol:
                    g('s%s symbol 1;'
                      's%s symbol size 0.4;'
                      's%s symbol fill pattern 1'
                      % (index, index, index))
                #print "curve.style()", curve.style()
                if curve.style():
                    g('s%s line linestyle 1' % index)
                else:
                    g('s%s line linestyle 0' % index)
                for i in range(curve.dataSize()):
                    g('%s.s%s point %g, %g'
                      % (graph, index, curve.x(i), curve.y(i)))
                index += 1

        # finalize
        g('redraw')
        if saveall:
            time.sleep(pause)
            g('saveall "%s"' % saveall)
            time.sleep(pause)
            g.kill()
            
    # gracePlot()
        
# class Plot


class Curve:
    """A command line friendly layer over `QwtPlotCurve`.

    Parameters:

    - `x`: sequence of numbers
    - `y`: sequence of numbers

    The interpretation of the `*rest` parameters is type dependent:

    - `Axis`: attaches an axis to the curve.
    - `Pen`: sets the pen to connect the data points.
    - `Symbol`: sets the symbol to draw the data points.
    - `str`, `QString`, or `QwtText`: sets the curve title.
    """

    def __init__(self, x, y, *rest):
        self.x = x # must be sequence of floats, typecode()?
        self.y = y # must be sequence of floats
        self.name = ""
        self.xAxis = X1
        self.yAxis = Y1
        self.symbol = None
        self.pen = None

        for item in rest:
            if isinstance(item, QwtPlot.Axis):
                if item in (X1, X2):
                    self.xAxis = item
                elif item in (Y1, Y2):
                    self.yAxis = item
            elif isinstance(item, Pen):
                self.pen = item
            elif (isinstance(item, str) or isinstance(item, QString)):
                self.name = item
            elif isinstance(item, Symbol):
                self.symbol = item
            else:
                print "Curve fails to accept %s." % item

        if not self.symbol and not self.pen:
            self.pen = QPen()

    # __init__()

# class Curve()


class Axis:
    """A command line interpreter friendly class.

    The interpretation of the `*rest` parameters is type dependent:

    - `QwtPlot.Axis`: sets the orientation of the axis.
    - `QwtScaleEngine`: sets the axis type (Lin or Log).
    - `int` : sets the attributes of the axis.
    - `string` or `QString`: sets the title of the axis.
    """
    def __init__(self, *rest):
        self.attributes = NoAttribute
        self.engine = QwtLinearScaleEngine
        self.title = QwtText('')
        font = QFont(Font)
        font.setPointSize(12)
        font.setBold(True)
        self.title.setFont(font)

        for item in rest:
            if isinstance(item, QwtPlot.Axis):
                self.orientation = item
            elif item in [Lin, Log]:
                self.engine = item
            elif isinstance(item, int):
                self.attributes = item
            elif (isinstance(item, str) or isinstance(item, QString)):
                self.title.setText(item)
            else:
                print "Axis() fails to accept %s." % item

    # __init__()

# class Axis


class Symbol(QwtSymbol):
    """A command line friendly layer over `QwtSymbol`.

    The interpretation of the `*rest` parameters is type dependent:

    - `QColor`: sets the symbol fill color.
    - `QwtSymbol.Style`: sets symbol style.
    - `int`: sets the symbol size.
    """
    def __init__(self, *rest):
        QwtSymbol.__init__(self)
        self.setSize(5)
        for item in rest:
            if isinstance(item, QColor):
                brush = self.brush()
                brush.setColor(item)
                self.setBrush(brush)
            elif isinstance(item, QwtSymbol.Style):
                self.setStyle(item)
            elif isinstance(item, int):
                self.setSize(item)
            else:
                print "Symbol fails to accept %s." %  item

    # __init__()

# class Symbol


class Pen(QPen):
    """A command line friendly layer over `QPen`.

    The interpretation of the `*rest` parameters is type dependent:

    - `Qt.PenStyle`: sets the pen style.
    - `QColor` sets the pen color.
    - `int`: sets the pen width.
    """
    def __init__(self, *rest):
        QPen.__init__(self)
        for item in rest:
            if isinstance(item, Qt.PenStyle):
                self.setStyle(item.style)
            elif isinstance(item, QColor):
                self.setColor(item)
            elif isinstance(item, int):
                self.setWidth(item)
            else:
                print "Pen fails to accept %s." % item

    # __init__()

# class Pen


print_xpm = [
    '32 32 12 1',
    'a c #ffffff',
    'h c #ffff00',
    'c c #ffffff',
    'f c #dcdcdc',
    'b c #c0c0c0',
    'j c #a0a0a4',
    'e c #808080',
    'g c #808000',
    'd c #585858',
    'i c #00ff00',
    '# c #000000',
    '. c None',
    '................................',
    '................................',
    '...........###..................',
    '..........#abb###...............',
    '.........#aabbbbb###............',
    '.........#ddaaabbbbb###.........',
    '........#ddddddaaabbbbb###......',
    '.......#deffddddddaaabbbbb###...',
    '......#deaaabbbddddddaaabbbbb###',
    '.....#deaaaaaaabbbddddddaaabbbb#',
    '....#deaaabbbaaaa#ddedddfggaaad#',
    '...#deaaaaaaaaaa#ddeeeeafgggfdd#',
    '..#deaaabbbaaaa#ddeeeeabbbbgfdd#',
    '.#deeefaaaaaaa#ddeeeeabbhhbbadd#',
    '#aabbbeeefaaa#ddeeeeabbbbbbaddd#',
    '#bbaaabbbeee#ddeeeeabbiibbadddd#',
    '#bbbbbaaabbbeeeeeeabbbbbbaddddd#',
    '#bjbbbbbbaaabbbbeabbbbbbadddddd#',
    '#bjjjjbbbbbbaaaeabbbbbbaddddddd#',
    '#bjaaajjjbbbbbbaaabbbbadddddddd#',
    '#bbbbbaaajjjbbbbbbaaaaddddddddd#',
    '#bjbbbbbbaaajjjbbbbbbddddddddd#.',
    '#bjjjjbbbbbbaaajjjbbbdddddddd#..',
    '#bjaaajjjbbbbbbjaajjbddddddd#...',
    '#bbbbbaaajjjbbbjbbaabdddddd#....',
    '###bbbbbbaaajjjjbbbbbddddd#.....',
    '...###bbbbbbaaajbbbbbdddd#......',
    '......###bbbbbbjbbbbbddd#.......',
    '.........###bbbbbbbbbdd#........',
    '............###bbbbbbd#.........',
    '...............###bbb#..........',
    '..................###...........',
    ]

grace_xpm = [
    '48 39 6 1',
    '  c #000000000000',
    '. c #FFFFFFFFFFFF',
    'X c #BEFBBEFBBEFB',
    'o c #51445144FFFF',
    'O c #FFFF14514103',
    '+ c #0000AAAA1861',
    '                                                ',
    ' .............................................. ',
    ' .............................................. ',
    ' ...............                  ............. ',
    ' .............................................. ',
    ' .................              ............... ',
    ' .............................................. ',
    ' .......                                 ...... ',
    ' ....... XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ...... ',
    ' ....... XXXXXXXXXXXXXXXXXXXXXXXXXXoXXXX ...... ',
    ' ..... . XXoooXX      XXXXXXXXXXXoooXXXX ...... ',
    ' .. .... XXXXXXXXXXXXXXXXXXXXXXXXoXooOXX ...... ',
    ' .. .... XXOOOXX     XXXXXXXXXXXXoXOoXXX ...... ',
    ' .. .... XXXXXXXXXXXXXXXXXXXXXXXoOOXooXX ...... ',
    ' .. .... XX+++XX     XXXXooXXXXOoXXXXoXX ...... ',
    ' .. .. . XXXXXXXXXXXXXXXoXoXXXOoXXXXXXXX ...... ',
    ' .. .... XXXXXXXXXXXXXXXoXoXOOooXXXXXXXX ...... ',
    ' .. .... XXXXXXXXXXXXXXoXXooXXoXXXXXXXXX ...... ',
    ' .. .... XXXXXXXoXXXXXooXOOoXoXXXXXXXXXX ...... ',
    ' .. .... XXXXXXooXXXXXoOOXXooXXXXXXXXXXX ...... ',
    ' .. .. . XXXXXXoXoXXXoOXXXXXXXXXXXXXXXXX ...... ',
    ' .. .... XXXXXooXoXXOoXXXXXXXXXXXXXXXXXX ...... ',
    ' .. .... XXXXooXXooOooXXXXXXXXXXXXXXXXXX ...... ',
    ' .. .... XXXXoXXOOoXoXXXXXXXXXX+++++XXXX ...... ',
    ' .. .... XXXXoXOXXoXoXXXXXXXXXX+++++XXXX ...... ',
    ' .. .. . XXXooOXXXXoXXXX+++++XX+++++XXXX ...... ',
    ' .. .... XXOoXXXXXXXXXXX+++++XX+++++XXXX ...... ',
    ' .. .... XOoXXXXX+++++XX+++++XX+++++XXXX ...... ',
    ' .. .... XXoXXXXX+++++XX+++++XX+++++XXXX ...... ',
    ' ....... XooXXXXX+++++XX+++++XX+++++XXXX ...... ',
    ' ..... . XXXXXXXX+++++XX+++++XX+++++XXXX ...... ',
    ' .......                                 ...... ',
    ' .............................................. ',
    ' ........ .... .... .... .... .... .... ....... ',
    ' .............................................. ',
    ' ..............                    ............ ',
    ' .............................................. ',
    ' .............................................. ',
    '                                                ',
    ]


class IPlot(QMainWindow):
    """A QMainWindow widget with a Plot widget as central widget. It provides:

    #. a toolbar for printing and piping into Grace.
    #. a legend with control to toggle curves between hidden and shown.
    #. mouse tracking to display the coordinates in the status bar.
    #. an infinite stack of zoom regions.
    
    The interpretation of the `rest` parameters is type dependent:
    
    - `Axis`: enables the axis.
    - `Curve`: adds a curve.
    - `str` or `QString`: sets the title.
    - `int`: sets a set of mouse events to the zoomer actions.
    - (`int`, `int`): sets the size.
    """

    def __init__(self, *rest):
        QMainWindow.__init__(self)

        self.__plot = Plot(self, *rest)
        self.setCentralWidget(self.__plot)

        toolBar = QToolBar(self)

        printButton = QToolButton(toolBar)
        printButton.setText("Print")
        printButton.setPixmap(QPixmap(print_xpm))
        toolBar.addSeparator()

        graceButton = QToolButton(toolBar)
        graceButton.setText("Grace")
        graceButton.setPixmap(QPixmap(grace_xpm))
        toolBar.addSeparator()

        mouseComboBox = QComboBox(toolBar)
        for name in ('3 buttons (PyQwt)',
                     '1 button',
                     '2 buttons',
                     '3 buttons (Qwt)'):
            mouseComboBox.insertItem(name)
        mouseComboBox.setCurrentItem(self.__plot.getZoomerMouseEventSet())
        toolBar.addSeparator()

        self.connect(printButton,
                     SIGNAL('clicked()'),
                     self.printPlot)
        self.connect(graceButton,
                     SIGNAL('clicked()'),
                     self.__plot.gracePlot)
        self.connect(mouseComboBox,
                     SIGNAL('activated(int)'),
                     self.__plot.setZoomerMouseEventSet)
        self.connect(Tracker(self.__plot.canvas()),
                     PYSIGNAL("MouseMoveTracked"),
                     self.showCoordinates) 

        self.statusBar().message("Move the mouse within the plot canvas"
                                 " to show the cursor position.")

        QWhatsThis.add(
            printButton,
            'Print to a printer or an (E)PS file.'
            )

        QWhatsThis.add(
            graceButton,
            'Clone the plot into Grace.\n\n'
            'The hardcopy output of Grace is better for\n'
            'scientific journals and LaTeX documents.'
            )

        QWhatsThis.add(
            mouseComboBox,
            'Configure the mouse events for the QwtPlotZoomer.\n\n'
            '3 buttons (PyQwt style):\n'
            '- left-click & drag to zoom\n'
            '- middle-click to unzoom all\n'
            '- right-click to walk down the stack\n'
            '- shift-right-click to walk up the stack.\n'
            '1 button:\n'
            '- click & drag to zoom\n'
            '- control-click to unzoom all\n'
            '- alt-click to walk down the stack\n'
            '- shift-alt-click to walk up the stack.\n'
            '2 buttons:\n'
            '- left-click & drag to zoom\n'
            '- right-click to unzoom all\n'
            '- alt-left-click to walk down the stack\n'
            '- alt-shift-left-click to walk up the stack.\n'
            '3 buttons (Qwt style):\n'
            '- left-click & drag to zoom\n'
            '- right-click to unzoom all\n'
            '- middle-click to walk down the stack\n'
            '- shift-middle-click to walk up the stack.\n\n'
            'If some of those key combinations interfere with\n'
            'your Window manager, press the:\n'
            '- escape-key to unzoom all\n'
            '- minus-key to walk down the stack\n'
            '- plus-key to walk up the stack.'
            )

        QWhatsThis.add(
            self.__plot.legend(),
            'Clicking on a legend button toggles\n'
            'a curve between hidden and shown.'
            )

        QWhatsThis.add(
            self.__plot.canvas(),
            'Clicking on a legend button toggles a curve\n'
            'between hidden and shown.\n\n'
            'A QwtPlotZoomer lets you zoom infinitely deep\n'
            'by saving the zoom states on a stack. You can:\n'
            '- select a zoom region\n'
            '- unzoom all\n'
            '- walk down the stack\n'
            '- walk up the stack.\n\n'
            'The combo box in the toolbar lets you attach\n'
            'different sets of mouse events to those actions.'
            )

        self.resize(700, 500)
        self.show()

    # __init__()

    def plot(self, *rest):
        self.__plot.plot(*rest)

    # plot()
    
    def printPlot(self):
        printer = QPrinter(QPrinter.HighResolution)
        printer.setColorMode(QPrinter.Color)
        printer.setOutputToFile(True)
        if printer.setup():
            self.__plot.print_(printer)

    # printPlot()

    def showCoordinates(self, position):
        self.statusBar().message(' -- '.join(
            self.__plot.formatCoordinates(position.x(), position.y())))

    # showCoordinates()
        
    def __getattr__(self, attr):
        """Inherit everything from Plot
        """
        if hasattr(self.__plot, attr):
            return getattr(self.__plot, attr)
        else:
            raise AttributeError, ('%s has no attribute named %s'
                                   % (self.__class__.__name__, attr))

    # __getattr__()

# class IPlot
        
        
# Admire!
def testPlot():
    if 'np' not in dir():
        import anynumpy as np
    x = np.arange(-2*np.pi, 2*np.pi, 0.01)
    title = "PyQwt using Qt-%s and Qwt-%s" % (QT_VERSION_STR, QWT_VERSION_STR)
    p = Plot(Axis(Bottom, "linear x-axis"),
             Axis(Left, "linear y-axis"),
             Axis(Right, Log, "logarithmic y-axis"),             
             Curve(x, np.cos(x), Pen(Magenta, 2), "cos(x)"),
             Curve(x, np.exp(x), Pen(Red), "exp(x)", Right),
             title,
             )
    x = x[0:-1:10]
    p.plot(
        Curve(x, np.cos(x-np.pi/4), Symbol(Circle, Yellow), "circle"),
        Curve(x, np.cos(x+np.pi/4), Pen(Blue), Symbol(Square, Cyan), "square"),
        )
    return p

# testPlot()


def testIPlot():
    if 'np' not in dir():
        import anynumpy as np
    x = np.arange(-2*np.pi, 2*np.pi, 0.01)
    title = "PyQwt using Qt-%s and Qwt-%s" % (QT_VERSION_STR, QWT_VERSION_STR)
    p = IPlot(Axis(Bottom, "linear x-axis"),
              Axis(Left, "linear y-axis"),
              Axis(Right, Log, "logarithmic y-axis"),             
              Curve(x, np.cos(x), Pen(Magenta, 2), "cos(x)"),
              Curve(x, np.exp(x), Pen(Red), "exp(x)", Right),
              title,
              )
    x = x[0:-1:10]
    p.plot(
        Curve(x, np.cos(x-np.pi/4), Symbol(Circle, Yellow), "circle"),
        Curve(x, np.cos(x+np.pi/4), Pen(Blue), Symbol(Square, Cyan), "square"),
        )
    return p

# testIPlot()


def standard_map(x, y, kappa, n):
    if 'np' not in dir():
        import anynumpy as np
    xs = np.zeros(n, np.Float)
    ys = np.zeros(n, np.Float)
    for i in range(n):
        xs[i] = x
        ys[i] = y
        xn = y-kappa*np.sin(2.0*np.pi*x)
        yn = x+y
        if (xn > 1.0) or (xn < 0.0):
            x = xn-np.floor(xn)
        else:
            x = xn
        if (yn > 1.0) or (yn < 0.0):
            y = yn-np.floor(yn)
        else:
            y = yn
    return xs, ys

# standard_map()

        
def testStandardMap():
    import random
    x = random.random()
    y = random.random()
    kappa = random.random()
    print "x = %s, y = %s, kappa = %s" % (x, y, kappa)
    xs, ys = standard_map(x, y, kappa, 1 << 18)
    title = "PyQwt using Qt-%s and Qwt-%s" % (QT_VERSION_STR, QWT_VERSION_STR)
    p = IPlot(Curve(xs, ys, Symbol(Circle, Red), "standard_map"), title)
    return p

# testStandardMap()


if __name__ == '__main__':
    a = QApplication(sys.argv)
    p1, p2, p3 = testPlot(), testIPlot(), testStandardMap()
    a.setMainWidget(p1)
    a.exec_loop()

# Local Variables: ***
# mode: python ***
# End: ***
