"""iqt

Provides control over PyQt and PyQwt widgets from the command line interpreter.
"""

# Import GNU readline, so that readline can do its work in Python scripts.
# _iqt falls back on a different method when there is no GNU readline.
try:
    import readline
except ImportError:
    pass

from qt import QApplication, qApp

# Provoke a runtime error when no QApplication instance exists, since
# qApp does not return None when no QApplication instance exists.
try:
    qApp.name()
except RuntimeError:
    _a = QApplication([])

import _iqt 

# Local Variables: ***
# mode: python ***
# End: ***
