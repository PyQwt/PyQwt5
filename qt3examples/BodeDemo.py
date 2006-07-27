#!/usr/bin/env python

# The Python version of Qwt-5.0.0/examples/bode

# To get an impression of the expressive power of Numeric,
# compare the Python and C++ versions of setDamp()


import sys
import qt as Qt
import Qwt5 as Qwt
from Qwt5.anynumpy import *


print_xpm = ['32 32 12 1',
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
             '..................###...........']

zoom_xpm = ['32 32 8 1',
            '# c #000000',
            'b c #c0c0c0',
            'a c #ffffff',
            'e c #585858',
            'd c #a0a0a4',
            'c c #0000ff',
            'f c #00ffff',
            '. c None',
            '..######################........',
            '.#a#baaaaaaaaaaaaaaaaaa#........',
            '#aa#baaaaaaaaaaaaaccaca#........',
            '####baaaaaaaaaaaaaaaaca####.....',
            '#bbbbaaaaaaaaaaaacccaaa#da#.....',
            '#aaaaaaaaaaaaaaaacccaca#da#.....',
            '#aaaaaaaaaaaaaaaaaccaca#da#.....',
            '#aaaaaaaaaabe###ebaaaaa#da#.....',
            '#aaaaaaaaa#########aaaa#da#.....',
            '#aaaaaaaa###dbbbb###aaa#da#.....',
            '#aaaaaaa###aaaaffb###aa#da#.....',
            '#aaaaaab##aaccaaafb##ba#da#.....',
            '#aaaaaae#daaccaccaad#ea#da#.....',
            '#aaaaaa##aaaaaaccaab##a#da#.....',
            '#aaaaaa##aacccaaaaab##a#da#.....',
            '#aaaaaa##aaccccaccab##a#da#.....',
            '#aaaaaae#daccccaccad#ea#da#.....',
            '#aaaaaab##aacccaaaa##da#da#.....',
            '#aaccacd###aaaaaaa###da#da#.....',
            '#aaaaacad###daaad#####a#da#.....',
            '#acccaaaad##########da##da#.....',
            '#acccacaaadde###edd#eda#da#.....',
            '#aaccacaaaabdddddbdd#eda#a#.....',
            '#aaaaaaaaaaaaaaaaaadd#eda##.....',
            '#aaaaaaaaaaaaaaaaaaadd#eda#.....',
            '#aaaaaaaccacaaaaaaaaadd#eda#....',
            '#aaaaaaaaaacaaaaaaaaaad##eda#...',
            '#aaaaaacccaaaaaaaaaaaaa#d#eda#..',
            '########################dd#eda#.',
            '...#dddddddddddddddddddddd##eda#',
            '...#aaaaaaaaaaaaaaaaaaaaaa#.####',
            '...########################..##.']



class PrintFilter(Qwt.QwtPlotPrintFilter):

    def __init__(self):
        Qwt.QwtPlotPrintFilter.__init__(self)

    # __init___()
    
    def color(self, c, item, i):
        if not (self.options() & Qwt.QwtPlotPrintFilter.PrintCanvasBackground):
            if item == Qwt.QwtPlotPrintFilter.MajorGrid:
                return Qt.Qt.darkGray
            elif item == Qwt.QwtPlotPrintFilter.MinorGrid:
                return Qt.Qt.gray
        if item == Qwt.QwtPlotPrintFilter.Title:
            return Qt.Qt.red
        elif item == Qwt.QwtPlotPrintFilter.AxisScale:
            return Qt.Qt.green
        elif item == Qwt.QwtPlotPrintFilter.AxisTitle:
            return Qt.Qt.blue
        return c

    # color()

    def font(self, f, item, i):
        result = Qt.QFont(f)
        result.setPointSize(int(f.pointSize()*1.25))
        return result

    # font()

# class PrintFilter


class BodePlot(Qwt.QwtPlot):

    def __init__(self, *args):
        Qwt.QwtPlot.__init__(self, *args)

        self.setTitle('Frequency Response of a 2<sup>nd</sup>-order System')
        self.setCanvasBackground(Qt.Qt.darkBlue)

        # legend
        legend = Qwt.QwtLegend()
        legend.setFrameStyle(Qt.QFrame.Box | Qt.QFrame.Sunken)
        legend.setItemMode(Qwt.QwtLegend.ClickableItem)
        self.insertLegend(legend, Qwt.QwtPlot.BottomLegend)

        # grid
        self.grid = Qwt.QwtPlotGrid()
        self.grid.enableXMin(True)
        self.grid.setMajPen(Qt.QPen(Qt.Qt.white, 0, Qt.Qt.DotLine))
        self.grid.setMinPen(Qt.QPen(Qt.Qt.gray, 0 , Qt.Qt.DotLine))
        self.grid.attach(self)

        # axes
        self.enableAxis(Qwt.QwtPlot.yRight)
        self.setAxisTitle(Qwt.QwtPlot.xBottom, u'\u03c9/\u03c9<sub>0</sub>')
        self.setAxisTitle(Qwt.QwtPlot.yLeft, 'Amplitude [dB]')
        self.setAxisTitle(Qwt.QwtPlot.yRight, u'Phase [\u00b0]')

        self.setAxisMaxMajor(Qwt.QwtPlot.xBottom, 6)
        self.setAxisMaxMinor(Qwt.QwtPlot.xBottom, 10)
        self.setAxisScaleEngine(Qwt.QwtPlot.xBottom, Qwt.QwtLog10ScaleEngine())

        # curves
        self.curve1 = Qwt.QwtPlotCurve('Amplitude')
        self.curve1.setPen(Qt.QPen(Qt.Qt.yellow))
        self.curve1.setYAxis(Qwt.QwtPlot.yLeft)
        self.curve1.attach(self)
        
        self.curve2 = Qwt.QwtPlotCurve('Phase')
        self.curve2.setPen(Qt.QPen(Qt.Qt.cyan))
        self.curve2.setYAxis(Qwt.QwtPlot.yRight)
        self.curve2.attach(self)

        # alias
        fn = self.fontInfo().family()

        # marker
        self.dB3Marker = m = Qwt.QwtPlotMarker()
        m.setValue(0.0, 0.0)
        m.setLineStyle(Qwt.QwtPlotMarker.VLine)
        m.setLabelAlignment(Qt.Qt.AlignRight | Qt.Qt.AlignBottom)
        m.setLinePen(Qt.QPen(Qt.Qt.green, 2, Qt.Qt.DashDotLine))
        text = Qwt.QwtText('')
        text.setColor(Qt.Qt.green)
        text.setBackgroundBrush(Qt.QBrush(Qt.Qt.red))
        text.setFont(Qt.QFont(fn, 12, Qt.QFont.Bold))
        m.setLabel(text)
        m.attach(self)

        self.peakMarker = m = Qwt.QwtPlotMarker()
        m.setLineStyle(Qwt.QwtPlotMarker.HLine)
        m.setLabelAlignment(Qt.Qt.AlignRight | Qt.Qt.AlignBottom)
        m.setLinePen(Qt.QPen(Qt.Qt.red, 2, Qt.Qt.DashDotLine))
        text = Qwt.QwtText('')
        text.setColor(Qt.Qt.red)
        text.setBackgroundBrush(Qt.QBrush(self.canvasBackground()))
        text.setFont(Qt.QFont(fn, 12, Qt.QFont.Bold))
        
        m.setLabel(text)
        m.setSymbol(Qwt.QwtSymbol(Qwt.QwtSymbol.Diamond,
                                  Qt.QBrush(Qt.Qt.yellow),
                                  Qt.QPen(Qt.Qt.green),
                                  Qt.QSize(7,7)))
        m.attach(self)

        # text marker
        m = Qwt.QwtPlotMarker()
        m.setValue(0.1, -20.0)
        m.setLabelAlignment(Qt.Qt.AlignRight | Qt.Qt.AlignBottom)
        text = Qwt.QwtText(
            u'[1-(\u03c9/\u03c9<sub>0</sub>)<sup>2</sup>+2j\u03c9/Q]'
            '<sup>-1</sup>'
            )
        text.setFont(Qt.QFont(fn, 12, Qt.QFont.Bold))
        text.setColor(Qt.Qt.blue)
        text.setBackgroundBrush(Qt.QBrush(Qt.Qt.yellow))
        text.setBackgroundPen(Qt.QPen(Qt.Qt.red, 2))
        m.setLabel(text)
        m.attach(self)

        self.setDamp(0.01)

    # __init__()

    def showData(self, frequency, amplitude, phase):
        self.curve1.setData(frequency, amplitude)
        self.curve2.setData(frequency, phase)

    # showData()

    def showPeak(self, frequency, amplitude):
        self.peakMarker.setValue(frequency, amplitude)
        label = self.peakMarker.label()
        label.setText('Peak: %4g dB' % amplitude)
        self.peakMarker.setLabel(label)

    # showPeak()

    def show3dB(self, frequency):
        self.dB3Marker.setValue(frequency, 0.0)
        label = self.dB3Marker.label()
        label.setText('-3dB at f = %4g' % frequency)
        self.dB3Marker.setLabel(label)

    # show3dB()

    def setDamp(self, d):
        self.damping = d
        # Numerical Python: f, g, a and p are numpy arrays!
        f = exp(log(10.0)*arange(-2, 2.02, 0.04))
        g = 1.0/(1.0-f*f+2j*self.damping*f)
        a = 20.0*log10(abs(g))
        p = 180*arctan2(g.imag, g.real)/pi
        # for show3dB
        i3 = argmax(where(less(a, -3.0), a, -100.0))
        f3 = f[i3] - (a[i3]+3.0)*(f[i3]-f[i3-1])/(a[i3]-a[i3-1])
        # for showPeak
        imax = argmax(a)

        self.showPeak(f[imax], a[imax])
        self.show3dB(f3)
        self.showData(f, a, p)

        self.replot()

    # setDamp()

# class BodePlot


class BodeDemo(Qt.QMainWindow):

    def __init__(self, *args):
        Qt.QMainWindow.__init__(self, *args)

        self.plot = BodePlot(self)
        self.plot.setMargin(5)

        self.zoomers = []
        zoomer = Qwt.QwtPlotZoomer(
            Qwt.QwtPlot.xBottom,
            Qwt.QwtPlot.yLeft,
            Qwt.QwtPicker.DragSelection,
            Qwt.QwtPicker.AlwaysOff,
            self.plot.canvas())
        zoomer.setRubberBandPen(Qt.QPen(Qt.Qt.green))
        self.zoomers.append(zoomer)

        zoomer = Qwt.QwtPlotZoomer(
            Qwt.QwtPlot.xTop,
            Qwt.QwtPlot.yRight,
            Qwt.QwtPicker.PointSelection | Qwt.QwtPicker.DragSelection,
            Qwt.QwtPicker.AlwaysOff,
            self.plot.canvas())
        zoomer.setRubberBand(Qwt.QwtPicker.NoRubberBand)
        self.zoomers.append(zoomer)

        self.picker = Qwt.QwtPlotPicker(
            Qwt.QwtPlot.xBottom,
            Qwt.QwtPlot.yLeft,
            Qwt.QwtPicker.PointSelection | Qwt.QwtPicker.DragSelection,
            Qwt.QwtPlotPicker.CrossRubberBand,
            Qwt.QwtPicker.AlwaysOn,
            self.plot.canvas())
        self.picker.setRubberBandPen(Qt.QPen(Qt.Qt.green))
        self.picker.setTrackerPen(Qt.QPen(Qt.Qt.cyan))
 
        self.setCentralWidget(self.plot)

        toolBar = Qt.QToolBar(self)
        
        btnZoom = Qt.QToolButton(toolBar)
        btnZoom.setTextLabel("Zoom")
        btnZoom.setPixmap(Qt.QPixmap(zoom_xpm))
        btnZoom.setToggleButton(True)
        btnZoom.setUsesTextLabel(True)

        btnPrint = Qt.QToolButton(toolBar)
        btnPrint.setTextLabel("Print")
        btnPrint.setPixmap(Qt.QPixmap(print_xpm))
        btnPrint.setUsesTextLabel(True)

        toolBar.addSeparator()

        dampBox = Qt.QWidget(toolBar)
        dampLayout = Qt.QHBoxLayout(dampBox)
        dampLayout.setSpacing(0)
        dampLayout.addWidget(Qt.QWidget(dampBox), 10) # spacer
        dampLayout.addWidget(Qt.QLabel("Damping Factor", dampBox), 0)
        dampLayout.addSpacing(10)

        self.cntDamp = Qwt.QwtCounter(dampBox)
        self.cntDamp.setRange(0.01, 5.0, 0.01)
        self.cntDamp.setValue(0.01)
        dampLayout.addWidget(self.cntDamp, 10)

        toolBar.setStretchableWidget(dampBox)

        self.statusBar()
        
        self.zoom(False)
        self.showInfo()
        
        self.connect(
            self.cntDamp,
            Qt.SIGNAL('valueChanged(double)'),
            self.plot.setDamp)
        self.connect(
            btnPrint,
            Qt.SIGNAL('clicked()'),
            self.print_)
        self.connect(
            btnZoom,
            Qt.SIGNAL('toggled(bool)'),
            self.zoom)
        self.connect(
            self.picker,
            Qt.SIGNAL('moved(const QPoint &)'),
            self.moved)
        self.connect(
            self.picker,
            Qt.SIGNAL('selected(const QwtPolygon &)'),
            self.selected)

    # __init__()

    def print_(self):
        printer = Qt.QPrinter(Qt.QPrinter.HighResolution)

        #docName = self.plot.title.text().
        printer.setOrientation(Qt.QPrinter.Landscape)
        printer.setColorMode(Qt.QPrinter.Color)
        printer.setOutputToFile(True)
        printer.setOutputFileName('bode-example-%s.ps' % Qt.qVersion())
        if printer.setup():
            filter = PrintFilter()
            if (Qt.QPrinter.GrayScale == printer.colorMode()):
                filter.setOptions(
                    Qwt.QwtPlotPrintFilter.PrintAll
                    & ~Qwt.QwtPlotPrintFilter.PrintCanvasBackground)
            self.plot.print_(printer, filter)

    # print_()
    
    def zoom(self, on):
        self.zoomers[0].setEnabled(on)
        self.zoomers[0].zoom(0)
        
        self.zoomers[1].setEnabled(on)
        self.zoomers[1].zoom(0)

        if on:
            self.picker.setRubberBand(Qwt.QwtPicker.NoRubberBand)
        else:
            self.picker.setRubberBand(Qwt.QwtPicker.CrossRubberBand)

        self.showInfo()

    # zoom()
    
    def showInfo(self, text=None):
        if not text:
            if self.picker.rubberBand():
                text = 'Cursor Pos: Press left mouse button in plot region'
            else:
                text = 'Zoom: Press mouse button and drag'
                
        self.statusBar().message(text)
                
    # showInfo()
    
    def moved(self, point):
        info = "Freq=%g, Ampl=%g, Phase=%g" % (
            self.plot.invTransform(Qwt.QwtPlot.xBottom, point.x()),
            self.plot.invTransform(Qwt.QwtPlot.yLeft, point.y()),
            self.plot.invTransform(Qwt.QwtPlot.yRight, point.y()))
        self.showInfo(info)

    # moved()

    def selected(self, points):
        self.showInfo()

    # selected()

# class BodeDemo
    

def make():
    demo = BodeDemo()
    demo.resize(540, 400)
    demo.show()
    return demo

# make()


def main(args):
    app = Qt.QApplication(args)
    fonts = Qt.QFontDatabase()
    if Qt.QString('Verdana') in fonts.families():
        app.setFont(Qt.QFont('Verdana'))
    demo = make()
    app.setMainWidget(demo)
    sys.exit(app.exec_loop())

# main()


# Admire!
if __name__ == '__main__':
    main(sys.argv)

# Local Variables: ***
# mode: python ***
# End: ***
