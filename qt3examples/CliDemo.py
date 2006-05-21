#!/usr/bin/env python

from Qwt5.qplt import *


def make():
    return testPlot(), testIPlot()

# make()

def main(args):
    app = qt.QApplication(args)
    demo = make()
    app.setMainWidget(demo[-1])
    sys.exit(app.exec_loop())

# main()

# Admire!
if __name__ == '__main__':
    main(sys.argv)

# Local Variables: ***
# mode: python ***
# End: ***
