#!/usr/bin/env python

from PyQt4.Qt import QApplication
from PyQt4.Qwt5.qplt import *


def make():
    return testPlot(), testIPlot()

# make()

def main(args):
    app = QApplication(args)
    demo = make()
    sys.exit(app.exec_())

# main()

# Admire!
if __name__ == '__main__':
    main(sys.argv)

# Local Variables: ***
# mode: python ***
# End: ***
