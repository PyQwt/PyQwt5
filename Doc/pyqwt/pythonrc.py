# Set your PYTHONSTARTUP environment variable to $HOME/.pythonrc.py
#
# inspired by:
# http://opag.ca/wiki/OpagCode/OpagSnippets

from atexit import register
from os import path
import readline
import rlcompleter

# Sets up a tab for completion (use a single space to indent Python code).
readline.parse_and_bind('tab: complete')

historyPath = path.expanduser('~/.python_history')
readline.set_history_length(1000)

# Reads the history of the previous session, if it exists.
if path.exists(historyPath):
    readline.read_history_file(historyPath)

# Sets up history saving on exit.
def save_history(historyPath=historyPath, readline=readline):
    readline.write_history_file(historyPath)

register(save_history)

# Cleans up the global name space.
del register, path, readline, rlcompleter, historyPath, save_history

# Tries to make the PyQt and PyQwt widgets usable from the command line.
try:
    import PyQt4.Qwt5.iqt
    del PyQt4.Qwt5.iqt
except ImportError:
    pass

# Tries to import PyQt and Qwt.
try:
    import PyQt4.Qwt5 as Qwt
    import PyQt4.Qt as Qt
except ImportError:
    pass

# Sets up the SciPy help for tab completion: help(sp.optimize.leastsq).
try:
    import numpy as np
    import scipy as sp
    sp.pkgload()
except ImportError:
    pass

# Local Variables: ***
# mode: python ***
# End: ***
