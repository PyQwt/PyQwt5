"""iqt

Provides control over PyQt and PyQwt widgets from the command line interpreter.
"""

import sys

# Import GNU readline or inputhooker; is also usable in Python scripts.
try:
    import readline
    if '.py' in sys.modules['readline'].__file__:
        # try inputhooker when readline is not GNU readline
        try:
            import inputhooker
        except ImportError:
            print 'Install InputHooker from http://pyqwt.sourceforge.net.'
except ImportError:
    try:
        import inputhooker
    except ImportError:
        print 'Install InputHooker from http://pyqwt.sourceforge.net.'
    
from PyQt4.QtGui import QApplication
_a = QApplication([])

import _iqt 

# Local Variables: ***
# mode: python ***
# End: ***
