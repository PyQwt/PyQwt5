#!/usr/bin/env python

# The Python version of qwt-*/examples/dials

# for debugging, requires: python configure.py --trace ...
if 0:
    import sip
    sip.settracemask(0x3f)

import math
import random
import sys
from PyQt4 import Qt
import PyQt4.Qwt5 as Qwt


def enumList(enum, sentinel):
    '''
    '''
    return [enum(i) for i in range(sentinel)]

colorGroupList = enumList(
    Qt.QPalette.ColorGroup, Qt.QPalette.NColorGroups)
colorRoleList = enumList(
    Qt.QPalette.ColorRole, Qt.QPalette.NColorRoles)
handList  = enumList(
    Qwt.QwtAnalogClock.Hand, Qwt.QwtAnalogClock.NHands)


class CompassGrid(Qt.QFrame):

    def __init__(self, *args):
        Qt.QFrame.__init__(self, *args)

        palette = self.palette()
        palette.setColor(self.backgroundRole(), Qt.Qt.gray)
        self.setPalette(palette)
        
        layout = Qt.QGridLayout(self)

        for i in xrange(6):
            layout.addWidget(self.__createCompass(i), i / 3, i % 3)

        for i in xrange(layout.columnCount()):
            layout.setColumnStretch(i, 1)

    # __init__()
    
    def __createCompass(self, pos):

        palette = Qt.QPalette()
        for colorRole in colorRoleList:
            palette.setColor(colorRole, Qt.QColor())

        palette.setColor(
            Qt.QPalette.Base,
            self.palette().color(self.backgroundRole()).light(120))
        palette.setColor(
            Qt.QPalette.Foreground,
            palette.color(Qt.QPalette.Base))

        compass = Qwt.QwtCompass()
        compass.setLineWidth(4)
        if pos < 3:
            compass.setFrameShadow(Qwt.QwtCompass.Sunken)
        else:
            compass.setFrameShadow(Qwt.QwtCompass.Raised)

        if pos == 0:
            compass.setMode(Qwt.QwtCompass.RotateScale)
            rose = Qwt.QwtSimpleCompassRose(16, 2)
            rose.setWidth(0.15)
            compass.setRose(rose)
        elif pos == 1:
            compass.setLabelMap({0.0: "N",
                                 90.0: "E",
                                 180.0: "S",
                                 270.0: "W"})
            rose = Qwt.QwtSimpleCompassRose(4, 1)
            compass.setRose(rose)
            compass.setNeedle(
                Qwt.QwtCompassWindArrow(Qwt.QwtCompassWindArrow.Style2))
            compass.setValue(60.0)
        elif pos == 2:
            palette.setColor(Qt.QPalette.Base, Qt.Qt.darkBlue)
            palette.setColor(Qt.QPalette.Foreground,
                             Qt.QColor(Qt.Qt.darkBlue).dark(120))
            palette.setColor(Qt.QPalette.Text, Qt.Qt.white)
            compass.setScaleTicks(1, 1, 3)
            compass.setScale(36, 5, 0)
            compass.setNeedle(Qwt.QwtCompassMagnetNeedle(
                Qwt.QwtCompassMagnetNeedle.ThinStyle))
            compass.setValue(220.0)
        elif pos == 3:
            palette.setColor(Qt.QPalette.Base,
                             self.palette().color(self.backgroundRole()))
            palette.setColor(Qt.QPalette.Foreground, Qt.Qt.blue)
            compass.setLineWidth(0)
            compass.setScaleOptions(Qwt.QwtDial.ScaleBackbone
                                    | Qwt.QwtDial.ScaleTicks
                                    | Qwt.QwtDial.ScaleLabel)
            compass.setScaleTicks(0, 0, 3)
            compass.setLabelMap({  0.0:   '0',
                                  60.0:  '60',
                                 120.0: '120',
                                 180.0: '180',
                                 240.0: '240',
                                 320.0: '320'})
            compass.setScale(36, 5, 0)
            compass.setNeedle(Qwt.QwtDialSimpleNeedle(
                Qwt.QwtDialSimpleNeedle.Ray,
                False,
                Qt.Qt.white))
            compass.setOrigin(220.0)
            compass.setValue(20.0)
        elif pos == 4:
            compass.setScaleTicks(0, 0, 3)
            compass.setNeedle(Qwt.QwtCompassMagnetNeedle(
                Qwt.QwtCompassMagnetNeedle.TriangleStyle,
                Qt.Qt.white,
                Qt.Qt.red))
            compass.setValue(220.0)
        elif pos == 5:
            palette.setColor(Qt.QPalette.Foreground, Qt.Qt.black)
            compass.setNeedle(Qwt.QwtDialSimpleNeedle(
                Qwt.QwtDialSimpleNeedle.Ray,
                False,
                Qt.Qt.yellow))
            compass.setValue(315.0)

        newPalette = compass.palette()
        for colorRole in colorRoleList:
            if palette.color(colorRole).isValid():
                for colorGroup in colorGroupList:
                    newPalette.setColor(
                        colorGroup, colorRole, palette.color(colorRole))

        for colorGroup in colorGroupList:
            light = newPalette.color(
                colorGroup, Qt.QPalette.Base).light(170)
            dark = newPalette.color(
                colorGroup, Qt.QPalette.Base).dark(170)
            if compass.frameShadow() == Qwt.QwtDial.Raised:
                mid = newPalette.color(
                    colorGroup, Qt.QPalette.Base).dark(110)
            else:
                mid = newPalette.color(
                    colorGroup, Qt.QPalette.Base).light(110)

            newPalette.setColor(colorGroup, Qt.QPalette.Dark, dark)
            newPalette.setColor(colorGroup, Qt.QPalette.Mid, mid)
            newPalette.setColor(colorGroup, Qt.QPalette.Light, light)

        compass.setPalette(newPalette)

        return compass

    # __createCompass()

# class CompassGrid


class SpeedoMeter(Qwt.QwtDial):

    def __init__(self, *args):
        Qwt.QwtDial.__init__(self, *args)
        self.__label = 'km/h'
        self.setWrapping(False)
        self.setReadOnly(True)

        self.setOrigin(135.0)
        self.setScaleArc(0.0, 270.0)

        self.setNeedle(Qwt.QwtDialSimpleNeedle(
            Qwt.QwtDialSimpleNeedle.Arrow,
            True,
            Qt.QColor(Qt.Qt.red),
            Qt.QColor(Qt.Qt.gray).light(130)))

        self.setScaleOptions(Qwt.QwtDial.ScaleTicks | Qwt.QwtDial.ScaleLabel)
        self.setScaleTicks(0, 4, 8)

    # __init__()
    
    def setLabel(self, text):
        self.__label = text
        self.update()

    # setLabel()
    
    def label(self):
        return self.__label

    # label()
    
    def drawScaleContents(self, painter, center, radius):
        rect = Qt.QRect(0, 0, 2 * radius, 2 * radius - 10)
        rect.moveCenter(center)
        painter.setPen(self.palette().color(Qt.QPalette.Text))
        painter.drawText(
            rect, Qt.Qt.AlignBottom | Qt.Qt.AlignHCenter, self.__label)

    # drawScaleContents

# class SpeedoMeter


class AttitudeIndicatorNeedle(Qwt.QwtDialNeedle):

    def __init__(self, color):
        Qwt.QwtDialNeedle.__init__(self)
        palette = Qt.QPalette()
        for colourGroup in colorGroupList:
            palette.setColor(colourGroup, Qt.QPalette.Text, color)
        self.setPalette(palette)

    # __init__()
    
    def draw(self, painter, center, length, direction, cg):
        direction *= math.pi / 180.0
        triangleSize = int(round(length * 0.1))

        painter.save()

        p0 = Qt.QPoint(center.x() + 1, center.y() + 1)
        p1 = Qwt.qwtPolar2Pos(p0, length - 2 * triangleSize - 2, direction)

        pa = Qt.QPolygon([
            Qwt.qwtPolar2Pos(p1, 2 * triangleSize, direction),
            Qwt.qwtPolar2Pos(p1, triangleSize, direction + math.pi/2),
            Qwt.qwtPolar2Pos(p1, triangleSize, direction - math.pi/2),
            ])

        color = self.palette().color(cg, Qt.QPalette.Text)
        painter.setBrush(color)
        painter.drawPolygon(pa)

        painter.setPen(Qt.QPen(color, 3))
        painter.drawLine(
            Qwt.qwtPolar2Pos(p0, length - 2, direction + math.pi/2),
            Qwt.qwtPolar2Pos(p0, length - 2, direction - math.pi/2))

        painter.restore()

    # draw()

# class AttitudeIndicatorNeedle


class AttitudeIndicator(Qwt.QwtDial):

    def __init__(self, *args):
        Qwt.QwtDial.__init__(self, *args)
        self.__gradient = 0.0
        self.setMode(Qwt.QwtDial.RotateScale)
        self.setWrapping(True)
        self.setOrigin(270.0)
        self.setScaleOptions(Qwt.QwtDial.ScaleTicks)
        self.setScale(0, 0, 30.0)
        self.setNeedle(AttitudeIndicatorNeedle(
            self.palette().color(Qt.QPalette.Text)))

    # __init__()

    def angle(self):
        return self.value()

    # angle()
    
    def setAngle(self, angle):
        self.setValue(angle)

    # setAngle()

    def gradient(self):
        return self.__gradient

    # gradient()

    def setGradient(self, gradient):
        self.__gradient = gradient

    # setGradient()
    
    def keyPressEvent(self, event):
        if event.key() == Qt.Qt.Key_Plus:
            self.setGradient(self.gradient() + 0.05)
        elif event.key() == Qt.Qt.Key_Minus:
            self.setGradient(self.gradient() - 0.05)
        else:
            Qwt.QwtDial.keyPressEvent(self, event)

    # keyPressEvent()

    def drawScale(self, painter, center, radius, origin, minArc, maxArc):
        dir = (360.0 - origin) * math.pi / 180.0
        offset = 4
        p0 = Qwt.qwtPolar2Pos(center, offset, dir + math.pi)

        w = self.contentsRect().width()

        # clip region to swallow 180 - 360 degrees
        pa = []
        pa.append(Qwt.qwtPolar2Pos(p0, w, dir - math.pi/2))
        pa.append(Qwt.qwtPolar2Pos(pa[-1], 2 * w, dir + math.pi/2))
        pa.append(Qwt.qwtPolar2Pos(pa[-1], w, dir))
        pa.append(Qwt.qwtPolar2Pos(pa[-1], 2 * w, dir - math.pi/2))

        painter.save()
        painter.setClipRegion(Qt.QRegion(Qt.QPolygon(pa)))
        Qwt.QwtDial.drawScale(
            self, painter, center, radius, origin, minArc, maxArc)
        painter.restore()

    # drawScale()
    
    def drawScaleContents(self, painter, center, radius):
        dir = 360 - int(round(self.origin() - self.value()))
        arc = 90 + int(round(self.gradient() * 90))
        skyColor = Qt.QColor(38, 151, 221)
        painter.save()
        painter.setBrush(skyColor)
        painter.drawChord(
            self.scaleContentsRect(), (dir - arc)*16, 2*arc*16)
        painter.restore()

    # drawScaleContents()

# class AttitudeIndicator


class CockpitGrid(Qt.QFrame):
    
    def __init__(self, *args):
        Qt.QFrame.__init__(self, *args)

        self.setPalette(
            self.__colorTheme(Qt.QColor(Qt.Qt.darkGray).dark(150)))

        layout = Qt.QGridLayout(self)
        
        for i in xrange(3):
            layout.addWidget(self.__createDial(i), 0, i)

        for i in xrange(layout.columnCount()):
            layout.setColumnStretch(i, 1)

        self.__speed_offset = 0.8
        self.__angle_offset = 0.05
        self.__gradient_offset = 0.005
            
    # __init__()
    
    def __colorTheme(self, base):
        background = base.dark(150)
        foreground = base.dark(200)
        
        mid = base.dark(110)
        dark = base.dark(170)
        light = base.light(170)
        text = foreground.light(800)

        palette = Qt.QPalette()
        for colorGroup in colorGroupList:
            palette.setColor(colorGroup, Qt.QPalette.Base, base)
            palette.setColor(colorGroup, Qt.QPalette.Background, background)
            palette.setColor(colorGroup, Qt.QPalette.Mid, mid)
            palette.setColor(colorGroup, Qt.QPalette.Light, light)
            palette.setColor(colorGroup, Qt.QPalette.Dark, dark)
            palette.setColor(colorGroup, Qt.QPalette.Text, text)
            palette.setColor(colorGroup, Qt.QPalette.Foreground, foreground)
        
        return palette

    # __colorTheme()

    def __createDial(self, pos):
        dial = None
        if pos == 0:
            self.__clock = Qwt.QwtAnalogClock(self)
            knobColor = Qt.QColor(Qt.Qt.gray).light(130)
            for h in handList:
                handColor = Qt.QColor(Qt.Qt.gray).light(150)
                width = 8
                if h == Qwt.QwtAnalogClock.SecondHand:
                    handColor = Qt.Qt.gray
                    width = 5

                hand = Qwt.QwtDialSimpleNeedle(
                    Qwt.QwtDialSimpleNeedle.Arrow, True, handColor, knobColor)
                hand.setWidth(width)
                self.__clock.setHand(h, hand)
            timer = Qt.QTimer(self.__clock)
            timer.connect(timer,
                          Qt.SIGNAL('timeout()'),
                          self.__clock.setCurrentTime)
            timer.start(1000)
            dial = self.__clock
        elif pos == 1:
            self.__speedo = SpeedoMeter(self)
            self.__speedo.setRange(0.0, 240.0)
            self.__speedo.setScale(-1, 2, 20)
            timer = Qt.QTimer(self.__speedo)
            timer.connect(timer,
                          Qt.SIGNAL('timeout()'),
                          self.changeSpeed)
            timer.start(50)
            dial = self.__speedo
        elif pos == 2:
            self.__ai = AttitudeIndicator(self)
            gradientTimer = Qt.QTimer(self.__ai)
            gradientTimer.connect(gradientTimer,
                                  Qt.SIGNAL('timeout()'),
                                  self.changeGradient)
            gradientTimer.start(100)
            angleTimer = Qt.QTimer(self.__ai)
            angleTimer.connect(
                angleTimer, Qt.SIGNAL('timeout()'), self.changeAngle)
            angleTimer.start(100)
            dial = self.__ai

        if dial:
            dial.setReadOnly(True)
            dial.scaleDraw().setPenWidth(3)
            dial.setLineWidth(4)
            dial.setFrameShadow(Qwt.QwtDial.Sunken)

        return dial
    
    # __createDial()

    def changeSpeed(self):
        speed = self.__speedo.value()
        if ((speed < 40.0 and self.__speed_offset < 0.0)
            or (speed > 200.0 and self.__speed_offset > 0.0)):
            self.__speed_offset = -self.__speed_offset
        r = random.randrange(12)
        if r < 6:
            self.__speedo.setValue(speed + r*self.__speed_offset)

    # changeSpeed()

    def changeAngle(self):
        angle = self.__ai.angle()
        if angle > 180.0:
            angle -= 360.0

        if ((angle < -7.0 and self.__angle_offset < 0.0 )
            or (angle > 7.0 and self.__angle_offset > 0.0)):
            self.__angle_offset = -self.__angle_offset
            
        self.__ai.setAngle(angle + self.__angle_offset)

    # changeAngle()

    def changeGradient(self):
        gradient = self.__ai.gradient()

        if ((gradient < -0.05 and self.__gradient_offset < 0.0 )
            or (gradient > 0.05 and self.__gradient_offset > 0.0)):
            self.__gradient_offset = -self.__gradient_offset

        self.__ai.setGradient(gradient + self.__gradient_offset)

    # changeGradient()

# class CockpitGrid


def make():
    demo = Qt.QTabWidget()
    demo.addTab(CompassGrid(), "Compass")
    demo.addTab(CockpitGrid(), "Cockpit")
    demo.show()
    return demo

# make()


def main(args):
    app = Qt.QApplication(args)
    demo = make()
    sys.exit(app.exec_())

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
