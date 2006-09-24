#!/usr/bin/env python

# Plot of scipy-, Numeric-, numarray-arrays and lists of Python floats.

import sys

from PyQt4 import Qt
import PyQt4.Qwt5 as Qwt


def drange(start, stop, step):
    start, stop, step = float(start), float(stop), float(step)
    size = int(round((stop-start)/step))
    result = [start]*size
    for i in xrange(size):
        result[i] += i*step
    return result

# drange()
        
def lorentzian(x):
    return 1.0/(1.0+(x-5.0)**2)

# lorentzian()


class MultiDemo(Qt.QWidget):
    def __init__(self, *args):
        Qt.QWidget.__init__(self, *args)

        layout = Qt.QGridLayout(self)
        
        # try to create a plot for SciPy arrays
        try:
            import numpy
            # import does_not_exist
            numpy_plot = Qwt.QwtPlot(self)
            numpy_plot.setTitle('numpy array')
            numpy_plot.setCanvasBackground(Qt.Qt.white)
            numpy_plot.plotLayout().setCanvasMargin(0)
            numpy_plot.plotLayout().setAlignCanvasToScales(True)
            x = numpy.arange(0.0, 10.0, 0.01)
            y = lorentzian(x)
            # insert a curve, make it red and copy the arrays
            numpy_curve = Qwt.QwtPlotCurve('y = lorentzian(x)')
            numpy_curve.attach(numpy_plot)
            numpy_curve.setPen(Qt.QPen(Qt.Qt.red))
            numpy_curve.setData(x, y)
            layout.addWidget(numpy_plot, 0, 0)
            numpy_plot.replot()
        except ImportError, message:
            print "%s: %s" % (ImportError, message)
            print "Cannot show how to plot NumPy arrays"

        # try to create a plot for Numeric arrays
        try:
            import Numeric
            # import does_not_exist
            numeric_plot = Qwt.QwtPlot(self)
            numeric_plot.setTitle('Numeric array')
            numeric_plot.setCanvasBackground(Qt.Qt.white)
            numeric_plot.plotLayout().setCanvasMargin(0)
            numeric_plot.plotLayout().setAlignCanvasToScales(True)
            x = Numeric.arange(0.0, 10.0, 0.01)
            y = lorentzian(x)
            # insert a curve, make it red and copy the arrays
            numeric_curve = Qwt.QwtPlotCurve('y = lorentzian(x)')
            numeric_curve.attach(numeric_plot)
            numeric_curve.setPen(Qt.QPen(Qt.Qt.red))
            numeric_curve.setData(x, y)
            layout.addWidget(numeric_plot, 0, 1)
            numeric_plot.replot()
        except ImportError, message:
            print "%s: %s" % (ImportError, message)
            print "Cannot show how to plot Numeric arrays"

        # try to create a plot for numarray arrays
        try:
            import numarray
            # import does_not_exist
            numarray_plot = Qwt.QwtPlot(self)
            numarray_plot.setTitle('numarray array')
            numarray_plot.setCanvasBackground(Qt.Qt.white)
            numarray_plot.plotLayout().setCanvasMargin(0)
            numarray_plot.plotLayout().setAlignCanvasToScales(True)
            x = numarray.arange(0.0, 10.0, 0.01)
            y = lorentzian(x)
            # insert a curve, make it red and copy the arrays
            numarray_curve = Qwt.QwtPlotCurve('y = lorentzian(x)')
            numarray_curve.attach(numarray_plot)
            numarray_curve.setPen(Qt.QPen(Qt.Qt.red))
            numarray_curve.setData(x, y)
            layout.addWidget(numarray_plot, 1, 0)
            numarray_plot.replot()
        except ImportError, message:
            print "%s: %s" % (ImportError, message)
            print "Cannot show how to plot numarray arrays"
            pass

        # create a plot widget for lists of Python floats
        list_plot = Qwt.QwtPlot(self)
        list_plot.setTitle('Python list')
        list_plot.setCanvasBackground(Qt.Qt.white)
        list_plot.plotLayout().setCanvasMargin(0)
        list_plot.plotLayout().setAlignCanvasToScales(True)
        x = drange(0.0, 10.0, 0.01)
        y = map(lorentzian, x)
        # insert a curve, make it red and copy the lists
        list_curve = Qwt.QwtPlotCurve('y = lorentzian(x)')
        list_curve.attach(list_plot)
        list_curve.setPen(Qt.QPen(Qt.Qt.red))
        list_curve.setData(x, y)
        layout.addWidget(list_plot, 1, 1)
        list_plot.replot()

    # __init__()

# class MultiDemo


def main(args):
    app = Qt.QApplication(args)
    demo = make()
    sys.exit(app.exec_())

# main()


def make():
    demo = MultiDemo()
    demo.resize(400, 600)
    demo.show()
    return demo

# make()


# Admire!
if __name__ == '__main__':
    main(sys.argv)

# Local Variables: ***
# mode: python ***
# End: ***
