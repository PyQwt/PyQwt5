#!/usr/bin/env python
#
# Copyright (C) 2003-2009 Gerard Vermeulen
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
#
# In addition, as a special exception, Gerard Vermeulen gives permission
# to link PyQwt dynamically with non-free versions of Qt and PyQt,
# and to distribute PyQwt in this form, provided that equally powerful
# versions of Qt and PyQt have been released under the terms of the GNU
# General Public License.
#
# If PyQwt is dynamically linked with non-free versions of Qt and PyQt,
# PyQwt becomes a free plug-in for a non-free program.


import subprocess
import sys
if sys.version_info[:2] < (2, 6):
    import os
    import signal


class GraceProcess:
    """Provides a simple interface to a Grace subprocess."""
    
    def __init__ (self, debug = None):
        self.debug = debug
        self.p = subprocess.Popen(
            ["xmgrace", "-nosafe", "-noask", "-dpipe", "0"],
            stdin=subprocess.PIPE, close_fds=True)
        self.command("view xmin 0.15")
        self.command("view xmax 0.85")
        self.command("view ymin 0.15")
        self.command("view ymax 0.85")
        self.flush()

    # __init__()

    def command(self, text):
        if self.debug:
            print text
        self.p.stdin.write(text + '\n')
        self.flush()

    # command()

    def flush(self):
        self.p.stdin.flush()

    # flush()

    def wait(self):
        return self.p.wait()

    # wait()

    def kill(self):
        if sys.version_info[:2] < (2, 6):
            os.kill(self.p.pid, signal.SIGKILL)
        else:
            self.p.kill()

    # kill()

    def __call__(self, text):
        self.command(text)

    # __call__()

# class GraceProcess


if __name__ == '__main__':

    import time

    g = GraceProcess()
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
