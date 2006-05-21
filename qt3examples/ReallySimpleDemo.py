#!/usr/bin/env python

# The really simple Python version of Qwt-5.0.0/examples/simple


# for debugging, requires: python configure.py  --trace ...
if False:
    import sip
    sip.settracemask(0x3f)

import sys
import qt
import Qwt5 as Qwt
from Qwt5.anynumpy import *


class SimplePlot(Qwt.QwtPlot):

    def __init__(self, *args):
        Qwt.QwtPlot.__init__(self, *args)

	# make a QwtPlot widget
	self.setTitle('ReallySimpleDemo.py')
        self.insertLegend(Qwt.QwtLegend(), Qwt.QwtPlot.RightLegend)
        
	# set axis titles
	self.setAxisTitle(Qwt.QwtPlot.xBottom, 'x -->')
	self.setAxisTitle(Qwt.QwtPlot.yLeft, 'y -->')

	# insert a few curves
	cSin = Qwt.QwtPlotCurve('y = sin(x)')
	cSin.setPen(qt.QPen(qt.Qt.red))
        cSin.attach(self)

	cCos = Qwt.QwtPlotCurve('y = cos(x)')
	cCos.setPen(qt.QPen(qt.Qt.blue))
        cCos.attach(self)
        
	# make a Numeric array for the horizontal data
        x = arange(0.0, 10.0, 0.1)

	# initialize the data
	cSin.setData(x, sin(x))
	cCos.setData(x, cos(x))

	# insert a horizontal marker at y = 0
 	mY = Qwt.QwtPlotMarker()
        mY.setLabel(Qwt.QwtText('y = 0'))
        mY.setLabelAlignment(qt.Qt.AlignRight | qt.Qt.AlignTop)
        mY.setLineStyle(Qwt.QwtPlotMarker.HLine)
        mY.setYValue(0.0)
        mY.attach(self)

 	# insert a vertical marker at x = 2 pi
        mX = Qwt.QwtPlotMarker()
        mX.setLabel(Qwt.QwtText('x = 2 pi'))
        mX.setLabelAlignment(qt.Qt.AlignRight | qt.Qt.AlignTop)
        mX.setLineStyle(Qwt.QwtPlotMarker.VLine)
        mX.setXValue(2*pi)
        mX.attach(self)

        # replot
        self.replot()

    # __init__()

# class Plot


def make():
    demo = SimplePlot()
    demo.resize(500, 300)
    demo.show()
    return demo

# make()


def main(args):
    app = qt.QApplication(args)
    demo = make()
    app.setMainWidget(demo)
    sys.exit(app.exec_loop())

# main()


# Admire
if __name__ == '__main__':
    main(sys.argv)

# Local Variables: ***
# mode: python ***
# End: ***



