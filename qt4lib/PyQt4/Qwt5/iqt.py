"""iqt

Provides control over PyQt and PyQwt widgets from the command line interpreter.
"""

import sys

if 'readline' in sys.modules and '.py' not in sys.modules['readline'].__file__:
    pass
else:
    try:
        import iqt_readline
    except ImportError:
        pass
    
from PyQt4.QtGui import QApplication
_a = QApplication([])

import _iqt 

# Local Variables: ***
# mode: python ***
# End: ***
