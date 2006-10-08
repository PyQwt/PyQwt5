"""Qwt5.qplt

Provides a Command Line Interpreter friendly interface to QwtPlot.
"""
#
# Copyright (C) 2003-2006 Gerard Vermeulen
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


import sys
import time

import qt
import Qwt5 as Qwt
from anynumpy import *
from grace import GracePlotter


# colors
Black       = qt.QColor(qt.Qt.black)
Blue        = qt.QColor(qt.Qt.blue)
Cyan        = qt.QColor(qt.Qt.cyan)
DarkBlue    = qt.QColor(qt.Qt.darkBlue)
DarkCyan    = qt.QColor(qt.Qt.darkCyan)
DarkGray    = qt.QColor(qt.Qt.darkGray)
DarkGreen   = qt.QColor(qt.Qt.darkGreen)
DarkMagenta = qt.QColor(qt.Qt.darkMagenta)
DarkRed     = qt.QColor(qt.Qt.darkRed)
DarkYellow  = qt.QColor(qt.Qt.darkYellow)
Gray        = qt.QColor(qt.Qt.gray)
Green       = qt.QColor(qt.Qt.green)
LightGray   = qt.QColor(qt.Qt.lightGray)
Magenta     = qt.QColor(qt.Qt.magenta)
Red         = qt.QColor(qt.Qt.red)
White       = qt.QColor(qt.Qt.white)
Yellow      = qt.QColor(qt.Qt.yellow)


# font
Font = qt.QFont('Verdana')


class Plot(Qwt.QwtPlot):
    """Sugar coating.
    """
    def __init__(self, *args):
        """Constructor.

        Usage: plot = Plot(*args)
        
        Plot takes any number of optional arguments. The interpretation
        of each optional argument depend on its data type:
        (1) Axis -- enables the axis.
        (2) Curve -- plots a curve.
        (3) str or qt.QString -- sets the title.
        (4) integer -- attaches a set of mouse events to the zoomer actions
        (5) tuples of 2 integer -- sets the size.
        (6) qt.QWidget -- parent widget.
        """

        self.size = (600, 400)

        # get an optional parent widget
        parent = None
        for arg in args:
            if isinstance(arg, qt.QWidget):
                parent = arg
                self.size = None
        Qwt.QwtPlot.__init__(self, parent)

        # look
        self.setCanvasBackground(qt.Qt.white)
        self.plotLayout().setAlignCanvasToScales(True)

        grid = Qwt.QwtPlotGrid()
        grid.attach(self)
        grid.setPen(qt.QPen(qt.Qt.black, 0, qt.Qt.DotLine))
        
        legend = Qwt.QwtLegend()
        legend.setItemMode(Qwt.QwtLegend.ClickableItem)
        self.insertLegend(legend, Qwt.QwtPlot.RightLegend)

        # zooming
        self.zoomers = []
        zoomer = Qwt.QwtPlotZoomer(Qwt.QwtPlot.xBottom,
                                   Qwt.QwtPlot.yLeft,
                                   Qwt.QwtPicker.DragSelection,
                                   Qwt.QwtPicker.AlwaysOff,
                                   self.canvas())
        zoomer.setRubberBandPen(qt.QPen(Black))
        self.zoomers.append(zoomer)
        zoomer = Qwt.QwtPlotZoomer(Qwt.QwtPlot.xTop,
                                   Qwt.QwtPlot.yRight,
                                   Qwt.QwtPicker.DragSelection,
                                   Qwt.QwtPicker.AlwaysOff,
                                   self.canvas())
        zoomer.setRubberBand(Qwt.QwtPicker.NoRubberBand)
        self.zoomers.append(zoomer)
        self.setZoomerMouseEventSet(0)

        # initialization
        for arg in args:
            if isinstance(arg, Axis):
                self.plotAxis(arg)
            elif isinstance(arg, Curve):
                self.plotCurve(arg)
            elif (isinstance(arg, str) or isinstance(arg, qt.QString)):
                text = Qwt.QwtText(arg)
                font = qt.QFont(Font)
                font.setPointSize(14)
                font.setBold(True)
                text.setFont(font)
                self.setTitle(text)
            elif isinstance(arg, int):
                self.setZoomerMouseEventSet(arg)
            elif (isinstance(arg, tuple) and len(tuple) == 2
                  and isinstance(arg[0], int) and isinstance(arg[1], int)):
                self.size = arg
            elif isinstance(arg, qt.QWidget): # accept a parent silently
                pass
            else:
                print "Plot() fails to accept %s." % arg

        if self.size:
            apply(self.resize, self.size)

        # connections
        self.connect(self,
                     qt.SIGNAL("legendClicked(QwtPlotItem*)"),
                     self.toggleVisibility)

        # finalize
        self.show()

    # __init__()

    def __getattr__(self, attr):
        """Inherit everything from Qwt.QwtPlot.
        """
        if hasattr(Qwt.QwtPlot, attr):
            return getattr(self.sipThis, attr)
        else:
            raise AttributeError, ('%s has no attribute named %s'
                                   % (self.__class__.__name__, attr)
                                   )
    # __getattr__()
        
    def plot(self, *args):
        for arg in args:
            if isinstance(arg, Curve):
                self.plotCurve(arg)
            else:
                print "Plot.plot() fails to accept %s." % arg

    # plot()

    def plotAxis(self, axis):
        self.enableAxis(axis.orientation)
        engine = axis.engine()
        engine.setAttributes(axis.attributes)
        self.setAxisScaleEngine(axis.orientation, engine)
        if isinstance(engine, Qwt.QwtLog10ScaleEngine):
            self.setAxisMaxMinor(axis.orientation, 8)        
        self.setAxisTitle(axis.orientation, axis.title)
        self.clearZoomStack()

    # plotAxis()

    def plotCurve(self, curve):
        c = Qwt.QwtPlotCurve(curve.name)
        c.setAxis(curve.xAxis, curve.yAxis)
        
        if curve.pen:
            c.setPen(curve.pen)
        else:
            c.setStyle(Qwt.QwtPlotCurve.NoCurve)
        if curve.symbol:
            c.setSymbol(curve.symbol)
        c.setData(curve.x, curve.y)
        c.attach(self)
        self.clearZoomStack()

    # plotCurve()
    
    def clearZoomStack(self):
        """Force autoscaling and clear the zoom stack
        """
        self.setAxisAutoScale(Qwt.QwtPlot.yLeft)
        self.setAxisAutoScale(Qwt.QwtPlot.yRight)
        self.setAxisAutoScale(Qwt.QwtPlot.xBottom)
        self.setAxisAutoScale(Qwt.QwtPlot.xTop)
        self.replot()
        for zoomer in self.zoomers:
            zoomer.setZoomBase()

    # clearZoomStack()

    def setZoomerMouseEventSet(self, index):
        """Attach the Qwt.QwtPlotZoomer actions to a set of mouse events.
        """
        if index == 0:
            pattern = [
                Qwt.QwtEventPattern.MousePattern(qt.Qt.LeftButton,
                                                 qt.Qt.NoButton),
                Qwt.QwtEventPattern.MousePattern(qt.Qt.MidButton,
                                                 qt.Qt.NoButton),
                Qwt.QwtEventPattern.MousePattern(qt.Qt.RightButton,
                                                 qt.Qt.NoButton),
                Qwt.QwtEventPattern.MousePattern(qt.Qt.LeftButton,
                                                 qt.Qt.ShiftButton),
                Qwt.QwtEventPattern.MousePattern(qt.Qt.MidButton,
                                                 qt.Qt.ShiftButton),
                Qwt.QwtEventPattern.MousePattern(qt.Qt.RightButton,
                                                 qt.Qt.ShiftButton),
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
        todo = ((Qwt.QwtPlot.xBottom, "x0=%+.6g", x),
                (Qwt.QwtPlot.yLeft,   "y0=%+.6g", y),
                (Qwt.QwtPlot.xTop,    "x1=%+.6g", x),
                (Qwt.QwtPlot.yRight,  "y1=%+.6g", y))
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
        g = GracePlotter(debug = 0)
        g('subtitle "%s"' % self.title().text())
        index = 0
        for xAxis, yAxis, graph, xPlace, yPlace in [
            (Qwt.QwtPlot.xBottom, Qwt.QwtPlot.yLeft,
             'g0', 'normal', 'normal'),
            (Qwt.QwtPlot.xBottom, Qwt.QwtPlot.yRight,
             'g1', 'normal', 'opposite'),
            (Qwt.QwtPlot.xTop, Qwt.QwtPlot.yLeft,
             'g2', 'opposite', 'normal'),
            (Qwt.QwtPlot.xTop, Qwt.QwtPlot.yRight,
             'g3', 'opposite', 'opposite')
            ]:
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
                self.axisScaleEngine(xAxis), Qwt.QwtLog10ScaleEngine
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
                self.axisScaleEngine(yAxis), Qwt.QwtLog10ScaleEngine
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
                if not isinstance(curve, Qwt.QwtPlotCurve):
                    continue
                if not curve.isVisible():
                    continue
                if not (xAxis == curve.xAxis() and yAxis == curve.yAxis()):
                    continue
                g('s%s legend "%s"' % (index, curve.title().text()))
                print "curve.symbol().style()", curve.symbol().style()
                if curve.symbol().style():
                    g('s%s symbol 1;'
                      's%s symbol size 0.4;'
                      's%s symbol fill pattern 1'
                      % (index, index, index))
                print "curve.style()", curve.style()
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
    """Sugar coating for Qwt.QwtPlotCurve.
    """
    def __init__(self, x, y, *args):
        """Constructor.

        Usage: curve = Curve(x, y, *args)
        
        Curve takes two obligatory arguments followed by any number of
        optional arguments. The arguments 'x' and 'y' must be sequences
        of floats. The interpretation of each optional argument depends
        on its data type:
        (1) Axis -- attaches an axis to the curve.
        (2) Pen -- sets the pen to connect the data points.
        (3) Symbol -- sets the symbol to draw the data points.
        (4) string or qt.QString -- sets the title of the curve.
        """
        self.x = x # must be sequence of floats, typecode()?
        self.y = y # must be sequence of floats
        self.name = ""
        self.xAxis = Qwt.QwtPlot.xBottom
        self.yAxis = Qwt.QwtPlot.yLeft
        self.symbol = None
        self.pen = None

        for arg in args:
            if isinstance(arg, AxisOrientation):
                if arg.orientation in (
                    Qwt.QwtPlot.xBottom,
                    Qwt.QwtPlot.xTop
                    ):
                    self.xAxis = arg.orientation
                elif arg.orientation in (
                    Qwt.QwtPlot.yLeft,
                    Qwt.QwtPlot.yRight
                    ):
                    self.yAxis = arg.orientation
                else:
                    raise FIXME
            elif isinstance(arg, Pen):
                self.pen = arg
            elif (isinstance(arg, str) or isinstance(arg, qt.QString)):
                self.name = arg
            elif isinstance(arg, Symbol):
                self.symbol = arg
            else:
                print "Curve fails to accept %s." % arg

        if not self.symbol and not self.pen:
            self.pen = qt.QPen()

    # __init__()


class AxisOrientation:
    def __init__(self, orientation):
        self.orientation = orientation

# class AxisOrientation

Left   = AxisOrientation(Qwt.QwtPlot.yLeft)
Right  = AxisOrientation(Qwt.QwtPlot.yRight)
Bottom = AxisOrientation(Qwt.QwtPlot.xBottom)
Top    = AxisOrientation(Qwt.QwtPlot.xTop)

Lin = Qwt.QwtLinearScaleEngine
Log = Qwt.QwtLog10ScaleEngine

NoAttribute      = Qwt.QwtScaleEngine.NoAttribute
IncludeReference = Qwt.QwtScaleEngine.IncludeReference
Symmetric        = Qwt.QwtScaleEngine.Symmetric
Floating         = Qwt.QwtScaleEngine.Floating
Inverted         = Qwt.QwtScaleEngine.Inverted


class Axis:
    def __init__(self, *args):
        """Constructor.

        Usage: axis = Axis(*args)
        
        Axis takes any number of optional arguments. The interpretation
        of each optional argument depends on its data type:
        (1) AxisOrientation -- sets the orientation of the axis.
        (2) FIXME: Lin, Log
        (3) int -- sets the attributes of the axis.
        (4) string or qt.QString -- sets the title of the axis.
        """
        self.attributes = NoAttribute
        self.engine = Qwt.QwtLinearScaleEngine
        self.title = Qwt.QwtText('')
        font = qt.QFont(Font)
        font.setPointSize(12)
        font.setBold(True)
        self.title.setFont(font)

        for arg in args:
            if isinstance(arg, AxisOrientation):
                self.orientation = arg.orientation
            elif arg in [Lin, Log]:
                self.engine = arg
            elif isinstance(arg, int):
                self.attributes = arg
            elif (isinstance(arg, str) or isinstance(arg, qt.QString)):
                self.title.setText(arg)
            else:
                print "Axis() fails to accept %s." % arg

    # __init__()

# class Axis


class SymbolStyle:
    def __init__(self, style):
        self.style = style

    # __init__()

# class SymbolStyle


NoSymbol = SymbolStyle(Qwt.QwtSymbol.NoSymbol)
Circle   = SymbolStyle(Qwt.QwtSymbol.Ellipse)
Square   = SymbolStyle(Qwt.QwtSymbol.Rect)
Diamond  = SymbolStyle(Qwt.QwtSymbol.Diamond)


class PenStyle:
    def __init__(self, style):
        self.style = style

    # __init__()

# class PenStyle


NoLine         = PenStyle(qt.Qt.NoPen) 
SolidLine      = PenStyle(qt.Qt.SolidLine)
DashLine       = PenStyle(qt.Qt.DashLine)
DotLine        = PenStyle(qt.Qt.DotLine)
DashDotLine    = PenStyle(qt.Qt.DashDotLine)
DashDotDotLine = PenStyle(qt.Qt.DashDotDotLine)


class Symbol(Qwt.QwtSymbol):
    """Sugar coating for Qwt.QwtSymbol.
    """
    def __init__(self, *args):
        """Constructor.

        Usage: symbol = Symbol(*args)
        
        Symbol takes any number of optional arguments. The interpretation
        of each optional argument depends on its data type:
        (1) qt.QColor -- sets the fill color of the symbol.
        (2) SymbolStyle -- sets the style of the symbol.
        (3) int -- sets the size of the symbol.
        """
        Qwt.QwtSymbol.__init__(self)
        self.setSize(5)
        for arg in args:
            if isinstance(arg, qt.QColor):
                brush = self.brush()
                brush.setColor(arg)
                self.setBrush(brush)
            elif isinstance(arg, SymbolStyle):
                self.setStyle(arg.style)
            elif isinstance(arg, int):
                self.setSize(arg)
            else:
                print "Symbol fails to accept %s." %  arg

    # __init__()

# class Symbol


class Pen(qt.QPen):
    def __init__(self, *args):
        """Constructor.

        Usage: pen = Pen(*args)
        
        Pen takes any number of optional arguments. The interpretation
        of each optional argument depends on its data type:
        (1) PenStyle -- sets the style of the pen.
        (2) qt.QColor -- sets the color of the pen.
        (3) int -- sets the width of the pen.
        """
        qt.QPen.__init__(self)
        for arg in args:
            if isinstance(arg, PenStyle):
                self.setStyle(arg.style)
            elif isinstance(arg, qt.QColor):
                self.setColor(arg)
            elif isinstance(arg, int):
                self.setWidth(arg)
            else:
                print "Pen fails to accept %s." % arg

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


class IPlot(qt.QMainWindow):
    """A QMainWindow widget with a Plot widget as central widget.

    It provides:
    (1) a toolbar for printing and piping into Grace.
    (2) a legend with control to toggle curves between hidden and shown.
    (3) mouse tracking to display the coordinates in the status bar.
    (4) an infinite stack of zoom region.
    """

    def __init__(self, *args):
        """Constructor.

        Usage: plot = IPlot(*args)
        
        IPlot takes any number of optional arguments. The interpretation
        of each optional argument depend on its data type:
        (1) Axis -- enables the axis.
        (2) Curve -- plots a curve.
        (3) string or qt.QString -- sets the title.
        (4) tuples of 2 integer -- sets the size.
        """
        qt.QMainWindow.__init__(self)

        self.__plot = Plot(self, *args)
        self.setCentralWidget(self.__plot)

        toolBar = qt.QToolBar(self)

        printButton = qt.QToolButton(toolBar)
        printButton.setText("Print")
        printButton.setPixmap(qt.QPixmap(print_xpm))
        toolBar.addSeparator()

        graceButton = qt.QToolButton(toolBar)
        graceButton.setText("Grace")
        graceButton.setPixmap(qt.QPixmap(grace_xpm))
        toolBar.addSeparator()

        mouseComboBox = qt.QComboBox(toolBar)
        for name in ('3 buttons (PyQwt)',
                     '1 button',
                     '2 buttons',
                     '3 buttons (Qwt)'):
            mouseComboBox.insertItem(name)
        mouseComboBox.setCurrentItem(self.getZoomerMouseEventSet())
        toolBar.addSeparator()

        self.connect(printButton,
                     qt.SIGNAL('clicked()'),
                     self.printPlot)
        self.connect(graceButton,
                     qt.SIGNAL('clicked()'),
                     self.gracePlot)
        self.connect(mouseComboBox,
                     qt.SIGNAL('activated(int)'),
                     self.setZoomerMouseEventSet)

        self.statusBar().message("Move the mouse within the plot canvas"
                                 " to show the cursor position.")

        ## FIXME
        #self.__plot.canvas().setMouseTracking(True)
        #self.setMouseTracking(True)

        qt.QWhatsThis.add(
            printButton,
            'Print to a printer or an (E)PS file.'
            )

        qt.QWhatsThis.add(
            graceButton,
            'Clone the plot into Grace.\n\n'
            'The hardcopy output of Grace is better for\n'
            'scientific journals and LaTeX documents.'
            )
        
        qt.QWhatsThis.add(
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

        qt.QWhatsThis.add(
            self.__plot.legend(),
            'Clicking on a legend button toggles\n'
            'a curve between hidden and shown.'
            )

        qt.QWhatsThis.add(
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

    def printPlot(self):
        printer = qt.QPrinter(qt.QPrinter.HighResolution)
        printer.setColorMode(qt.QPrinter.Color)
        printer.setOutputToFile(True)
        if printer.setup():
            self.__plot.print_(p)

    # printPlot()

##     def mouseMoveEvent(self, e):
##         print 'wow'
##         print e
##         #qt.QWidget.changeEvent(self, e)
##         print e.type()
##         print qt.QEvent.MouseTrackingChange
##         if e.type() == qt.QEvent.MouseTrackingChange:
##             self.statusBar().message(
##                 ' -- '.join(self.formatCoordinates(e.pos().x(), e.pos().y())))
        
        
    def __getattr__(self, attr):
        """Inherit everything from QMainWindow and Plot
        """
        if hasattr(qt.QMainWindow, attr):
            return getattr(self.sipThis, attr)
        elif hasattr(self.__plot, attr):
            return getattr(self.__plot, attr)
        else:
            raise AttributeError, ('%s has no attribute named %s'
                                   % (self.__class__.__name__, attr))

    # __getattr__()

# class IPlot
        
        
# Admire!
def testPlot():
    x = arange(-2*pi, 2*pi, 0.01)
    p = Plot(
        Axis(Bottom, "linear x-axis"),
        Axis(Left, "linear y-axis"),
        Axis(Right, Log, "logarithmic y-axis"),             
        Curve(x, cos(x), Pen(Magenta, 2), "cos(x)"),
        Curve(x, exp(x), Pen(Red), "exp(x)", Right),
        "PyQwt using Qt-%s and Qwt-%s"
        % (qt.QT_VERSION_STR, Qwt.QWT_VERSION_STR),
        )
    x = x[0:-1:10]
    p.plot(
        Curve(x, cos(x-pi/4), Symbol(Circle, Yellow), "circle"),
        Curve(x, cos(x+pi/4), Pen(Blue), Symbol(Square, Cyan), "square"),
        )
    return p

# testPlot()


def testIPlot():
    x = arange(-2*pi, 2*pi, 0.01)
    p = IPlot(
        Axis(Bottom, "linear x-axis"),
        Axis(Left, "linear y-axis"),
        Axis(Right, Log, "logarithmic y-axis"),             
        Curve(x, cos(x), Pen(Magenta, 2), "cos(x)"),
        Curve(x, exp(x), Pen(Red), "exp(x)", Right),
        "PyQwt using Qt-%s and Qwt-%s"
        % (qt.QT_VERSION_STR, Qwt.QWT_VERSION_STR),
        )
    x = x[0:-1:10]
    p.plot(
        Curve(x, cos(x-pi/4), Symbol(Circle, Yellow), "circle"),
        Curve(x, cos(x+pi/4), Pen(Blue), Symbol(Square, Cyan), "square"),
        )
    return p

# testIPlot()


def standard_map(x, y, kappa, n):
    xs = zeros(n, Float)
    ys = zeros(n, Float)
    for i in range(n):
        xs[i] = x
        ys[i] = y
        xn = y-kappa*sin(2.0*pi*x)
        yn = x+y
        if (xn > 1.0) or (xn < 0.0):
            x = xn-floor(xn)
        else:
            x = xn
        if (yn > 1.0) or (yn < 0.0):
            y = yn-floor(yn)
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
    xs, ys = standard_map(x, y, kappa, 1 << 16)
    p = IPlot(
        Curve(xs, ys, Symbol(Circle, Red), "standard_map"),
        "PyQwt using Qt-%s and Qwt-%s"
        % (qt.QT_VERSION_STR, Qwt.QWT_VERSION_STR),
        )

    return p

# testStandardMap()


if __name__ == '__main__':
    a = qt.QApplication(sys.argv)
    p = testIPlot()
    a.setMainWidget(p)
    a.exec_loop()

# Local Variables: ***
# mode: python ***
# End: ***
