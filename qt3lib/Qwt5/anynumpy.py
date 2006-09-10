# import either scipy, or numarray, or Numeric into numpy

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
    raise SystemExit, 'Failed to import either scipy, or numarray, or Numeric'

# Local Variables: ***
# mode: python ***
# End: ***
