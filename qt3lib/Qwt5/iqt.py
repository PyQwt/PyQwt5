"""iqt

Provides control over PyQt and PyQwt widgets from the command line interpreter.
"""

try:
    import readline as _r
    del _r
except ImportError:
    pass

from qt import QApplication
_a = QApplication([])

import _iqt 
_iqt.hook(True)

# Local Variables: ***
# mode: python ***
# End: ***
