#!/usr/bin/env python
#
# Copyright (C) 2003-2006 Gerard Vermeulen
#
# This file is part of PyQwt.
#
# PyQwt is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# PyQwt is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA


import os
import popen2
import time

class GracePlotter:
    def __init__ (self, debug = None):
        self.debug = debug
        self.p = popen2.Popen3 ("xmgrace -nosafe -noask -dpipe 0")
        self.command("view xmin 0.15")
        self.command("view xmax 0.85")
        self.command("view ymin 0.15")
        self.command("view ymax 0.85")
        self.flush()

    def command(self, cmd):
        if self.debug:
            print cmd
        self.p.tochild.write(cmd + '\n')
        self.flush()

    def flush(self):
        self.p.tochild.flush()

    def wait(self):
        return self.p.wait()

    def kill(self):
        os.kill(self.p.pid, 9)

    def __call__(self, cmd):
        self.command(cmd)


if __name__ == '__main__':
    g = GracePlotter()
    g('world xmax 100')
    g('world ymax 10000')
    g('xaxis tick major 20')
    g('xaxis tick minor 10')
    g('yaxis tick major 2000')
    g('yaxis tick minor 1000')
    g('s0 on')
    g('s0 symbol 1')
    g('s0 symbol size 0.3')
    g('s0 symbol fill pattern 1')
    g('s1 on')
    g('s1 symbol 1')
    g('s1 symbol size 0.3')
    g('s1 symbol fill pattern 1')

    # Display sample data
    for i in range(1,101):
        g('g0.s0 point %d, %d' % (i, i))
        g('g0.s1 point %d, %d' % (i, i * i))
        # Update the Grace display after every ten steps
        if i % 10 == 0:
            g('redraw')
            # Wait a second, just to simulate some time needed for
            # calculations. Your real application shouldn't wait.
            time.sleep(1)

    # Tell Grace to save the data:
    g('saveall "sample.agr"')

    # Close Grace:
    g.wait()

# Local Variables: ***
# mode: python ***
# End: ***
