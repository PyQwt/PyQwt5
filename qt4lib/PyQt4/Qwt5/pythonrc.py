# Set your PYTHONSTARTUP environment variable to $HOME/.pythonrc.py
#
# inspired by:
# http://opag.ca/wiki/OpagCode/OpagSnippets

from __future__ import division

# Import Numpy and SciPy
try:
    import numpy as np
    import scipy as sp
    sp.pkgload(#'cluster',
               'constants',
               'fftpack',
               'integrate',
               'interpolate',
               #'io',
               'linalg',
               'misc',
               'ndimage',
               'odr',
               'optimize',
               #'signal',
               #'sparse',
               #'spatial',
               'special',
               #'stats',
               #'stsci',
               #'weave',
               )
except ImportError:
    pass

# Import PyQt4.Qt and PyQt4.Qwt5; initialize an application.
# Note: hides the builtins hex and oct.
try:
    from PyQt4.Qt import *
    from PyQt4.Qwt5 import *
    from PyQt4.Qwt5.qplt import *
    application = QApplication([])
except ImportError:
    application = None

# Setup readline and history saving
from atexit import register
from os import path
import readline
import rlcompleter

# Set up a tab for completion; use a single space to indent Python code.
readline.parse_and_bind('tab: complete')

history = path.expanduser('~/.python_history')
readline.set_history_length(1000)

# Read the history of the previous session, if it exists.
if path.exists(history):
    readline.read_history_file(history)

# Set up history saving on exit.
def save(history=history, readline=readline, application=application):
    readline.write_history_file(history)

register(save)

# Clean up the global name space; save, history, readline, and application
# will continue to exist, since del decrements the reference count by one.
del register, path, readline, rlcompleter, history, save, application

# Local Variables: ***
# mode: python ***
# End: ***
