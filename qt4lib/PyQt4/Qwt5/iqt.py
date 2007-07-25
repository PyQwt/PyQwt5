"""iqt

Provides control over PyQt and PyQwt widgets from the command line interpreter.
"""

from PyQt4.Qt import QApplication, PYQT_VERSION
_a = QApplication([])

if PYQT_VERSION < 0x40300:
    import _iqt

# Local Variables: ***
# mode: python ***
# End: ***
