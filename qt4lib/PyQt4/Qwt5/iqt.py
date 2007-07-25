"""iqt

Provides control over PyQt and PyQwt widgets from the command line interpreter.
"""

# Import GNU readline, so that readline can do its work in Python scripts.
# _iqt falls back on a different method when there is no GNU readline.
try:
    import readline
except ImportError:
    pass

from PyQt4.Qt import QApplication, QCoreApplication, PYQT_VERSION

if QCoreApplication.instance() is None:
    _a = QApplication([])

if PYQT_VERSION < 0x40300:
    import _iqt

# Local Variables: ***
# mode: python ***
# End: ***
