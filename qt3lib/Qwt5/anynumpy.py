# import either NumPy, or numarray, or Numeric

for name in ('numpy', 'numarray', 'Numeric'):
    failed = False
    try:
         eval(compile('from %s import *' % name, 'eval', 'exec'))
	 if name == 'numpy':
	     from numpy.oldnumeric.compat import *
             Float = float
             UInt8 = uint8
    except ImportError:
        failed = True
    if not failed:
        break
else:
    import qt
    # Provoke a runtime error when no QApplication instance exists, since
    # qt.qApp does not return None when no QApplication instance exists.
    try:
        qt.qApp.name()
    except RuntimeError:
        a = qt.QApplication([])
    qt.QMessageBox.critical(
        None,
        'Numerical Python Extension Required',
        'This example requires a Numerical Python Extension, but\n'
        'failed to import either NumPy, or numarray, or Numeric.\n'
        'NumPy is available at http://sourceforge.net/projects/numpy'
        )
    raise SystemExit, (
        'Failed to import either NumPy, or numarray, or Numeric.\n'
        'NumPy is available at http://sourceforge.net/projects/numpy'
        )

# Local Variables: ***
# mode: python ***
# End: ***
