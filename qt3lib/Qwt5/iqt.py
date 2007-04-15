"""iqt

Provides control over PyQt and PyQwt widgets from the command line interpreter.
"""

import sys

if 'readline' in sys.modules and '.py' not in sys.modules['readline'].__file__:
    pass
else:
    try:
        import inputhooker
    except ImportError:
        print 'Install InputHooker from http://pyqwt.sourceforge.net.'

from qt import QApplication
_a = QApplication([])

import _iqt 

# Local Variables: ***
# mode: python ***
# End: ***
