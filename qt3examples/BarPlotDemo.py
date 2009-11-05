#!/usr/bin/env python

# Contributed by Tomaz Curk in a bug report showing that the stack order of the
# curves was dependent on the number of curves. This has been fixed in Qwt.
#
# BarCurve is an idea of Tomaz Curk.
#
# Beautified and expanded by Gerard Vermeulen.

import random
import sys
import qt
import Qwt5 as Qwt


class Spy(qt.QObject):
    
    def __init__(self, parent):
        qt.QObject.__init__(self, parent)
        parent.setMouseTracking(True)
        parent.installEventFilter(self)

    # __init__()

    def eventFilter(self, _, event):
        if event.type() == qt.QEvent.MouseMove:
            self.emit(qt.PYSIGNAL("MouseMove"), (event.pos(),))
        return False

    # eventFilter()

# class Spy


class BarCurve(Qwt.QwtPlotCurve):

    def __init__(self, penColor=qt.Qt.black, brushColor=qt.Qt.white):
        Qwt.QwtPlotCurve.__init__(self)
        self.penColor = penColor
        self.brushColor = brushColor
        
    # __init__()
    
    def drawFromTo(self, painter, xMap, yMap, start, stop):
        """Draws rectangles with the corners taken from the x- and y-arrays.
        """

        painter.setPen(qt.QPen(self.penColor, 2))
        painter.setBrush(self.brushColor)
        if stop == -1:
            stop = self.dataSize()
        # force 'start' and 'stop' to be even and positive
        if start & 1:
            start -= 1
        if stop & 1:
            stop -= 1
        start = max(start, 0)
        stop = max(stop, 0)
        for i in range(start, stop, 2):
            px1 = xMap.transform(self.x(i))
            py1 = yMap.transform(self.y(i))
            px2 = xMap.transform(self.x(i+1))
            py2 = yMap.transform(self.y(i+1))
            painter.drawRect(px1, py1, (px2 - px1), (py2 - py1))

    # drawFromTo()

# class BarCurve


class BarPlotMainWindow(qt.QMainWindow):

    colors = (qt.Qt.red,
              qt.Qt.green,
              qt.Qt.blue,
              qt.Qt.cyan,
              qt.Qt.magenta,
              qt.Qt.yellow,
              )

    def __init__(self, parent=None):
        qt.QMainWindow.__init__(self, parent)

        # Initialize a QwPlot central widget
        self.plot = Qwt.QwtPlot(self)
        self.plot.setTitle('left-click & drag to zoom')

        self.plot.setCanvasBackground(qt.Qt.white)

        self.plot.plotLayout().setCanvasMargin(0)
        self.plot.plotLayout().setAlignCanvasToScales(True)
        self.setCentralWidget(self.plot)

        grid = Qwt.QwtPlotGrid()
        pen = qt.QPen(qt.Qt.DotLine)
        pen.setColor(qt.Qt.black)
        pen.setWidth(0)
        grid.setPen(pen)
        grid.attach(self.plot)

        self.__initTracking()
        self.__initZooming()
        self.__initToolBar()
        
        # Finalize
        self.counter.setValue(10)
        self.go(self.counter.value())

    # __init__()

    def __initTracking(self):
        """Initialize tracking
        """        

        self.connect(Spy(self.plot.canvas()),
                     qt.PYSIGNAL("MouseMove"),
                     self.showCoordinates) 

        self.statusBar().message(
            'Mouse movements in the plot canvas are shown in the status bar')

    # __initTracking()

    def showCoordinates(self, position):
        self.statusBar().message(
            'x = %+.6g, y = %.6g'
            % (self.plot.invTransform(Qwt.QwtPlot.xBottom, position.x()),
               self.plot.invTransform(Qwt.QwtPlot.yLeft, position.y())))

    # showCoordinates()
    
    def __initZooming(self):
        """Initialize zooming
        """

        self.zoomer = Qwt.QwtPlotZoomer(Qwt.QwtPlot.xBottom,
                                        Qwt.QwtPlot.yLeft,
                                        Qwt.QwtPicker.DragSelection,
                                        Qwt.QwtPicker.AlwaysOff,
                                        self.plot.canvas())
        self.zoomer.setRubberBandPen(qt.QPen(qt.Qt.black))

    # __initZooming()
       
    def setZoomerMousePattern(self, index):
        """Set the mouse zoomer pattern.
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
            self.zoomer.setMousePattern(pattern)
        elif index in (1, 2, 3):
            self.zoomer.initMousePattern(index)
        else:
            raise ValueError, 'index must be in (0, 1, 2, 3)'

    # setZoomerMousePattern()

    def __initToolBar(self):
        """Initialize the toolbar
        """
        
        toolBar = qt.QToolBar(self)
 
        qt.QLabel('Bars', toolBar)
        self.counter = Qwt.QwtCounter(toolBar)
        self.counter.setRange(0, 10000, 1)
        self.counter.setNumButtons(3)
        toolBar.addSeparator()

        qt.QLabel('Mouse', toolBar)
        mouseComboBox = qt.QComboBox(toolBar)
        for name in ('3 buttons (PyQwt)',
                     '1 button',
                     '2 buttons',
                     '3 buttons (Qwt)'):
            mouseComboBox.insertItem(name)
        mouseComboBox.setCurrentItem(0)
        toolBar.addSeparator()
        self.setZoomerMousePattern(0)

        qt.QWhatsThis.whatsThisButton(toolBar)

        qt.QWhatsThis.add(
            self.plot.canvas(),
            'A QwtPlotZoomer lets you zoom infinitely deep '
            'by saving the zoom states on a stack.\n\n'
            'You can:\n'
            '- select a zoom region\n'
            '- unzoom all\n'
            '- walk down the stack\n'
            '- walk up the stack.\n\n'
            'The combo box in the toolbar lets you attach '
            'different sets of mouse events to those actions.'
            )
        
        qt.QWhatsThis.add(
            self.counter,
            'Select the number of bars'
            )
        
        qt.QWhatsThis.add(
            mouseComboBox,
            'Configure the zoomer mouse buttons.\n\n'
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
            'If some of those key combinations interfere with '
            'your Window manager, press the:\n'
            '- escape-key to unzoom all\n'
            '- minus-key to walk down the stack\n'
            '- plus-key to walk up the stack.'
            )

        self.connect(self.counter,
                     qt.SIGNAL('valueChanged(double)'),
                     self.go)
        self.connect(mouseComboBox,
                     qt.SIGNAL('activated(int)'),
                     self.setZoomerMousePattern)

    # __initToolBar()

    def go(self, value):
        """Create and plot a sequence of bars taking into account the controls
        """

        n = int(value)

        for bar in self.plot.itemList():
            if isinstance(bar, BarCurve):
                bar.detach()

        for i in range(n):
            bar = BarCurve(
                self.colors[random.randint(0, len(self.colors)-1)],
                self.colors[random.randint(0, len(self.colors)-1)],
                )
            bar.attach(self.plot)
            bar.setData([i, i+1.4], [0.3*i, 5.0+0.3*i])

        self.clearZoomStack()

    # go()

    def clearZoomStack(self):
        """Auto scale and clear the zoom stack
        """

        self.plot.setAxisAutoScale(Qwt.QwtPlot.xBottom)
        self.plot.setAxisAutoScale(Qwt.QwtPlot.yLeft)
        self.plot.replot()
        self.zoomer.setZoomBase()

    # clearZoomStack()
    
# class BarPlotMainWindow


def make():
    demo = BarPlotMainWindow()
    demo.resize(500, 500)
    demo.show()
    return demo

# make()


def main(args):
    app = qt.QApplication(args)
    demo = make()
    app.setMainWidget(demo)
    sys.exit(app.exec_loop())

# main()


# Admire!
if __name__ == '__main__':
    if 'settracemask' in sys.argv:
        # for debugging, requires: python configure.py --trace ...
        import sip
        sip.settracemask(0x3f)

    main(sys.argv)

# Local Variables: ***
# mode: python ***
# End: ***

