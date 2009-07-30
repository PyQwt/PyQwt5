#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest
import numarray as np
from PyQt4.Qt import *
from PyQt4.Qwt5 import *


class TestImageConversionFunctions(unittest.TestCase):

    def testHorizontalLinesARGB32(self):
        colors = (Qt.red, Qt.green, Qt.blue, Qt.white, Qt.black)
        alpha = 0xff000000
        red   = 0x00ff0000
        green = 0x0000ff00
        blue  = 0x000000ff
        white = 0x00ffffff
        black = 0x00000000

        image = QImage(3, len(colors), QImage.Format_ARGB32)
        painter = QPainter(image)
        for i, color in enumerate(colors):
            painter.setPen(color)
            painter.drawLine(0, i, image.width(), i)
        del painter

        array = np.zeros((image.height(), image.width()), dtype=np.UInt32)
        array[0,:] = alpha|red
        array[1,:] = alpha|green
        array[2,:] = alpha|blue
        array[3,:] = alpha|white
        array[4,:] = alpha|black

        self.assertEqual(np.all(array == toNumpy(image)), True)
        self.assertEqual(image == toQImage(array), True)

    # testHorizontalLinesARGB32()

    def testVerticalLinesARGB32(self):
        colors = (Qt.red, Qt.green, Qt.blue)
        alpha = 0xff000000
        red   = 0x00ff0000
        green = 0x0000ff00
        blue  = 0x000000ff

        image = QImage(len(colors), 5, QImage.Format_ARGB32)
        painter = QPainter(image)
        for i, color in enumerate(colors):
            painter.setPen(color)
            painter.drawLine(i, 0, i, image.height())
        del painter
        
        array = np.zeros((image.height(), image.width()), dtype=np.UInt32)
        array[:,0] = alpha|red
        array[:,1] = alpha|green
        array[:,2] = alpha|blue

        self.assertEqual(np.all(array == toNumpy(image)), True)
        self.assertEqual(image == toQImage(array), True)

    # testVerticalLinesARGB32()

    def testHorizontalLinesIndexed8(self):
        image = QImage(3, 5, QImage.Format_Indexed8)
        image.setColorTable([qRgb(i, i, i) for i in range(256)])

        for i in range(image.height()):
            for j in range(image.width()):
                image.setPixel(j, i, i)

        array = np.zeros((image.height(), image.width()), dtype=np.UInt8)
        for i in range(image.height()):
            array[i,:] = i

        self.assertEqual(np.all(array == toNumpy(image)), True)
        self.assertEqual(image == toQImage(array), True)

    # testHorizontalLinesIndexed8()

    def testVerticalLinesIndexed8(self):
        image = QImage(5, 3, QImage.Format_Indexed8)
        image.setColorTable([qRgb(i, i, i) for i in range(256)])

        for i in range(image.width()):
            for j in range(image.height()):
                image.setPixel(i, j, i)

        array = np.zeros((image.height(), image.width()), dtype=np.UInt8)
        for i in range(image.width()):
            array[:,i] = i

        self.assertEqual(np.all(array == toNumpy(image)), True)
        self.assertEqual(image == toQImage(array), True)

    # testVerticalLinesIndexed8()
    
# class TestImageConversionFunctions


if __name__ == '__main__':
    unittest.main()

# Local Variables: ***
# mode: python ***
# End: ***
