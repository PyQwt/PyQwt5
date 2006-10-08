#!/usr/bin/env python

# The Python version of Qwt-5.0.0/examples/radio

# for debugging, requires; python configure.py  --trace ...
if False:
    import sip
    sip.settracemask(0x3f)

import sys
import qt
import Qwt5 as Qwt
from math import *


#-- tunerfrm.cpp --#

class TuningThermo(qt.QWidget):

    def __init__(self, *args):
        qt.QWidget.__init__(self, *args)

        self.thermo = Qwt.QwtThermo(self)
        self.thermo.setOrientation(qt.Qt.Horizontal, Qwt.QwtThermo.NoScale)
        self.thermo.setRange(0.0, 1.0)
        self.thermo.setFillColor(qt.Qt.green)

        label = qt.QLabel("Tuning", self)
        label.setAlignment(qt.Qt.AlignCenter)

        layout = qt.QVBoxLayout(self)
        layout.setMargin(0)
        layout.addWidget(self.thermo)
        layout.addWidget(label)

        self.setFixedWidth(3*label.sizeHint().width())

    # __init__()

    def setValue(self, value):
        self.thermo.setValue(value)

    # setValue()

# class TuningThermo

        
class TunerFrame(qt.QFrame):

    def __init__(self, *args):
        qt.QFrame.__init__(self, *args)

        self.frequencySlider = Qwt.QwtSlider(
            self, qt.Qt.Horizontal, Qwt.QwtSlider.TopScale)
        self.frequencySlider.setScaleMaxMinor(5)
        self.frequencySlider.setScaleMaxMajor(12)
        self.frequencySlider.setThumbLength(80)
        self.frequencySlider.setBorderWidth(1)
        self.frequencySlider.setRange(87.5, 108, 0.01, 10)

        self.tuningThermo = TuningThermo(self)

        self.frequencyWheel = Qwt.QwtWheel(self)
        self.frequencyWheel.setMass(0.5)
        self.frequencyWheel.setRange(87.5, 108, 0.01)
        self.frequencyWheel.setTotalAngle(3600.0)

        self.connect(self.frequencyWheel,
                     qt.SIGNAL("valueChanged(double)"),
                     self.adjustFreq)
        self.connect(self.frequencySlider,
                     qt.SIGNAL("valueChanged(double)"),
                     self.adjustFreq)

        mainLayout = qt.QVBoxLayout(self)
        mainLayout.setMargin(10)
        mainLayout.setSpacing(5)
        mainLayout.addWidget(self.frequencySlider)

        hLayout = qt.QHBoxLayout()
        hLayout.setMargin(0)
        hLayout.addWidget(self.tuningThermo, 0)
        hLayout.addStretch(5)
        hLayout.addWidget(self.frequencyWheel, 2)

        mainLayout.addLayout(hLayout)

    # __init__()

    def adjustFreq(self, f):
        factor = 13.0 / (108 - 87.5)
        x = (f - 87.5)  * factor
        field = (sin(x) * cos(4.0 * x))**2
        self.tuningThermo.setValue(field)  
        if self.frequencySlider.value() != f:
            self.frequencySlider.setValue(f)
        if self.frequencyWheel.value() != f:
            self.frequencyWheel.setValue(f)
        self.emit(qt.PYSIGNAL('fieldChanged(double)'), (field,))	

    # adjustFreq()

    def setFreq(self, f):
        self.frequencyWheel.setValue(f)

    # setFreq()

# class TunerFrame


#-- ampfrm.cpp --#

class Knob(qt.QWidget):

    def __init__(self, title, min, max, parent):
        qt.QWidget.__init__(self, parent)

        self.knob = Qwt.QwtKnob(self)
        self.knob.setRange(min, max, 0, 1)
        self.knob.setScaleMaxMajor(10)

        self.knob.setKnobWidth(50)

        self.label = qt.QLabel(title, self)
        self.label.setAlignment(qt.Qt.AlignTop | qt.Qt.AlignHCenter)

        self.setSizePolicy(qt.QSizePolicy.MinimumExpanding,
                           qt.QSizePolicy.MinimumExpanding)

    # __init__()

    def sizeHint(self):
        sz1 = self.knob.sizeHint()
        sz2 = self.label.sizeHint()

        w = max(sz1.width(), sz2.width())
        h = sz1.height() + sz2.height()

        off = self.knob.scaleDraw().extent(qt.QPen(), self.knob.font())
        off -= 10 # spacing

        return qt.QSize(w, h - off)

    # sizeHint()

    def value(self):
        return self.knob.value()

    # value()


    def resizeEvent(self, event):
        sz = event.size()

        h = self.label.sizeHint().height()

        self.label.setGeometry(0, sz.height() - h, sz.width(), h)

        h = self.knob.sizeHint().height()
        off = self.knob.scaleDraw().extent(qt.QPen(), self.knob.font())
        off -= 10 # spacing

        self.knob.setGeometry(0, self.label.pos().y() - h + off, sz.width(), h)

    # resizeEvent()

# class Knob


class Thermo(qt.QWidget):

    def __init__(self, title, parent):
        qt.QWidget.__init__(self, parent)

        self.thermo = Qwt.QwtThermo(self)
        self.thermo.setPipeWidth(6)
        self.thermo.setRange(-40, 10)
        self.thermo.setFillColor(qt.Qt.green)
        self.thermo.setAlarmColor(qt.Qt.red)
        self.thermo.setAlarmLevel(0.0)
        self.thermo.setAlarmEnabled(True)

        label = qt.QLabel(title, self)
        label.setAlignment(qt.Qt.AlignTop | qt.Qt.AlignLeft)

        layout = qt.QVBoxLayout(self)
        layout.setMargin(0)
        layout.setSpacing(0)
        layout.addWidget(self.thermo, 10)
        layout.addWidget(label)

    # __init__()

    def setValue(self, value):
        self.thermo.setValue(value)

    # setValue()

# class Thermo


class AmplifierFrame(qt.QFrame):

    def __init__(self, *args):
        qt.QFrame.__init__(self, *args)

        self.phs = 0.0
        self.master = 0.0

        self.volumeKnob = Knob('Volume', 0.0, 10.0, self)
        self.balanceKnob = Knob('Balance', -10.0, 10.0, self)
        self.trebleKnob = Knob('Treble', -10.0, 10.0, self)
        self.bassKnob = Knob('Bass', -10.0, 10.0, self)

        self.leftThermo = Thermo('Left [dB]', self)
        self.rightThermo = Thermo('Right [dB]', self)

        layout = qt.QHBoxLayout(self)
        layout.setSpacing(0)
        layout.setMargin(10)
        layout.addWidget(self.volumeKnob)
        layout.addWidget(self.balanceKnob)
        layout.addWidget(self.trebleKnob)
        layout.addWidget(self.bassKnob)
        layout.addSpacing(20)
        layout.addStretch(10)
        layout.addWidget(self.leftThermo)
        layout.addSpacing(10)
        layout.addWidget(self.rightThermo)

        self.startTimer(50)

    # __init__()

    def timerEvent(self, event):
        sig_bass = (1.0 + 0.1*self.bassKnob.value()) * sin(13.0*self.phs)
        sig_mid_l = sin(17.0*self.phs)
        sig_mid_r = cos(17.5*self.phs)
        sig_trbl_l = 0.5*(1.0+0.1*self.trebleKnob.value()) * sin(35.0*self.phs)
        sig_trbl_r = 0.5*(1.0+0.1*self.trebleKnob.value()) * sin(34.0*self.phs)
        sig_l = 0.05*self.master*self.volumeKnob.value() * \
                (sig_bass+sig_mid_l+sig_trbl_l)**2
        sig_r = 0.05*self.master*self.volumeKnob.value() * \
                (sig_bass+sig_mid_r+sig_trbl_r)**2
    
        balance = 0.1 * self.balanceKnob.value() 
        if balance > 0: 
            sig_l *= (1.0 - balance)
        else:
            sig_r *= (1.0 + balance)

        if sig_l > 0.01:
            sig_l = 20.0 * log10(sig_l)
        else:
            sig_l = -40.0

        if sig_r > 0.01:
            sig_r = 20.0 * log10(sig_r)
        else:
            sig_r = - 40.0
        self.leftThermo.setValue(sig_l)
        self.rightThermo.setValue(sig_r)

        self.phs += pi / 100
        if self.phs > pi:
            self.phs = 0

    # timerEvent()
    
    def setMaster(self, value):
        self.master = value

    # setMaster()

# class AmplifierFrame


#-- radio.cpp --#

class RadioDemo(qt.QWidget):

    def __init__(self, *args):
        qt.QWidget.__init__(self, *args)

        tunerFrame = TunerFrame(self)
        tunerFrame.setFrameStyle(qt.QFrame.Panel | qt.QFrame.Raised)

        amplifierFrame = AmplifierFrame(self)
        amplifierFrame.setFrameStyle(qt.QFrame.Panel | qt.QFrame.Raised)

        layout = qt.QVBoxLayout(self)
        layout.setMargin(0)
        layout.setSpacing(0)
        layout.addWidget(tunerFrame)
        layout.addWidget(amplifierFrame)
    
        self.connect(tunerFrame,
                     qt.PYSIGNAL("fieldChanged(double)"),
                     amplifierFrame.setMaster)

        tunerFrame.setFreq(90.0)

    # __init__()

# class RadioDemo


def make():
    demo = RadioDemo()
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
    main(sys.argv)

# Local Variables: ***
# mode: python ***
# End: ***

