#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest
import numpy as np
from PyQt4.Qt import *
from PyQt4.Qwt5 import *

def make_vlines_argb32():
    colors = (Qt.red, Qt.green, Qt.blue)
    image = QImage(len(colors), 5, QImage.Format_ARGB32)
    painter = QPainter(image)
    for i, color in enumerate(colors):
        painter.setPen(color)
        painter.drawLine(i, 0, i, result.height())
    return image

# make_vlines_argb32()

def make_hlines_argb32():
    colors = (Qt.red, Qt.green, Qt.blue, Qt.white, Qt.black)
    image = QImage(3, len(colors), QImage.Format_ARGB32)
    painter = QPainter(image)
    for i, color in enumerate(colors):
        painter.setPen(color)
        painter.drawLine(0, i, result.width(), i)
    return image

# make_vlines_argb32()

class TestImageConversionFunctions(unittest.TestCase):

    def testHorizontalLinesARGB32(self):
        colors = (Qt.red, Qt.green, Qt.blue, Qt.white, Qt.black)
        image = QImage(3, len(colors), QImage.Format_ARGB32)
        painter = QPainter(image)
        for i, color in enumerate(colors):
            painter.setPen(color)
            painter.drawLine(0, i, image.width(), i)
        del painter
        a = toNumpy(image)
        for mask in (0xff000000, 0x00ff0000, 0x0000ff00, 0x000000ff):
            print mask
            print a & mask
        self.assertEqual(np.all(a == toNumpy(toQImage(toNumpy(image)))), True)

    # testHorizontalLinesARGB32()

    def testVerticalLinesARGB32(self):
        colors = (Qt.red, Qt.green, Qt.blue)
        image = QImage(len(colors), 5, QImage.Format_ARGB32)
        painter = QPainter(image)
        for i, color in enumerate(colors):
            painter.setPen(color)
            painter.drawLine(i, 0, i, image.height())
        del painter
        a = toNumpy(image)
        for mask in (0xff000000, 0x00ff0000, 0x0000ff00, 0x000000ff):
            print mask
            print a & mask
        self.assertEqual(np.all(a == toNumpy(toQImage(toNumpy(image)))), True)

    # testVerticalLinesARGB32()

# class TestImageConversionFunctions


if __name__ == '__main__':
    unittest.main()

# Local Variables: ***
# mode: python ***
# End: ***
