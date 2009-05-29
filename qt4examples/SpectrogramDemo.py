#!/usr/bin/env python

# The Python version of Qwt-5.0.0/examples/spectrogram

import sys
from PyQt4 import Qt
import PyQt4.Qwt5 as Qwt


class SpectrogramData(Qwt.QwtRasterData):

    def __init__(self):
        Qwt.QwtRasterData.__init__(self, Qt.QRectF(-1.5, -1.5, 3.0, 3.0))

    # __init__()

    def copy(self):
        return self

    # copy()
    
    def range(self):
        return Qwt.QwtDoubleInterval(0.0, 10.0);

    # range()

    def value(self, x, y):
        c = 0.842;
        v1 = x * x + (y-c) * (y+c);
        v2 = x * (y+c) + x * (y+c);
        return 1.0 / (v1 * v1 + v2 * v2);

    # value()

# class SpectrogramData()


class Plot(Qwt.QwtPlot):

    def __init__(self, parent = None):
        Qwt.QwtPlot.__init__(self, parent)
        self.__spectrogram = Qwt.QwtPlotSpectrogram()

        colorMap = Qwt.QwtLinearColorMap(Qt.Qt.darkCyan, Qt.Qt.red)
        colorMap.addColorStop(0.1, Qt.Qt.cyan)
        colorMap.addColorStop(0.6, Qt.Qt.green)
        colorMap.addColorStop(0.95, Qt.Qt.yellow)

        self.__spectrogram.setColorMap(colorMap)

        self.__spectrogram.setData(SpectrogramData())
        self.__spectrogram.attach(self)

        self.__spectrogram.setContourLevels(
            [0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 7.5, 8.5, 9.5])

        rightAxis = self.axisWidget(Qwt.QwtPlot.yRight)
        rightAxis.setTitle("Intensity")
        rightAxis.setColorBarEnabled(True)
        rightAxis.setColorMap(self.__spectrogram.data().range(),
                              self.__spectrogram.colorMap())

        self.setAxisScale(Qwt.QwtPlot.yRight, 
                          self.__spectrogram.data().range().minValue(),
                          self.__spectrogram.data().range().maxValue())
        self.enableAxis(Qwt.QwtPlot.yRight)

        self.plotLayout().setAlignCanvasToScales(True)
        self.replot()

        # LeftButton for the zooming
        # MidButton for the panning
        # RightButton: zoom out by 1
        # Ctrl+RighButton: zoom out to full size

        zoomer = Qwt.QwtPlotZoomer(self.canvas())
        zoomer.setMousePattern(Qwt.QwtEventPattern.MouseSelect2,
                               Qt.Qt.RightButton, Qt.Qt.ControlModifier)
        zoomer.setMousePattern(Qwt.QwtEventPattern.MouseSelect3,
                               Qt.Qt.RightButton)
        zoomer.setRubberBandPen(Qt.Qt.darkBlue)
        zoomer.setTrackerPen(Qt.Qt.darkBlue)

        panner = Qwt.QwtPlotPanner(self.canvas())
        panner.setAxisEnabled(Qwt.QwtPlot.yRight, False)
        panner.setMouseButton(Qt.Qt.MidButton)

        # Avoid jumping when labels with more/less digits
        # appear/disappear when scrolling vertically

        fm = Qt.QFontMetrics(self.axisWidget(Qwt.QwtPlot.yLeft).font())
        self.axisScaleDraw(
            Qwt.QwtPlot.yLeft).setMinimumExtent(fm.width("100.00"))

    # __init__()
    
    def showContour(self, on):
        self.__spectrogram.setDisplayMode(
            Qwt.QwtPlotSpectrogram.ContourMode, on)
        self.replot()

    # showContour()

    def showSpectrogram(self, on):
        self.__spectrogram.setDisplayMode(Qwt.QwtPlotSpectrogram.ImageMode, on)
        if on:
            pen = Qt.QPen()
        else:
            pen = Qt.QPen(Qt.Qt.NoPen)
        self.__spectrogram.setDefaultContourPen(pen)
        self.replot();

    # showSpectrogram()

# class Plot()


class MainWindow(Qt.QMainWindow):

    def __init__(self, parent=None):
        Qt.QMainWindow.__init__(self, parent)
        plot = Plot()

        self.setCentralWidget(plot)

        toolBar = Qt.QToolBar(self)

        btnSpectrogram = Qt.QToolButton(toolBar)
        btnContour = Qt.QToolButton(toolBar)

        btnSpectrogram.setText("Spectrogram")
        btnSpectrogram.setCheckable(True)
        btnSpectrogram.setToolButtonStyle(Qt.Qt.ToolButtonTextUnderIcon)
        toolBar.addWidget(btnSpectrogram)

        btnContour.setText("Contour");
        btnContour.setCheckable(True)
        btnContour.setToolButtonStyle(Qt.Qt.ToolButtonTextUnderIcon)
        toolBar.addWidget(btnContour)

        self.addToolBar(toolBar)

        self.connect(btnSpectrogram, Qt.SIGNAL('toggled(bool)'), 
                     plot.showSpectrogram)
        self.connect(btnContour, Qt.SIGNAL('toggled(bool)'), 
                     plot.showContour)

        btnSpectrogram.setChecked(True)
        btnContour.setChecked(False)

    # __init__()

# MainWindow()


def make():
    demo = MainWindow()
    demo.resize(600, 400)
    demo.show()
    return demo

# make()


def main(args):
    app = Qt.QApplication(args)
    demo = make()
    sys.exit(app.exec_())

# main()


# Admire
if __name__ == '__main__':
    if 'settracemask' in sys.argv:
        # for debugging, requires: python configure.py --trace ...
        import sip
        sip.settracemask(0x3f)

    main(sys.argv)

# Local Variables: ***
# mode: python ***
# End: ***
