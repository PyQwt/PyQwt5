Installation
************

Source Code Installation
========================

Build Prerequisites
-------------------

Recommended build prerequisites for PyQwt-|release| are: 

#. `Python <http://www.python.org>`_, version 2.6.x and 2.5.x are
   supported.  
#. `Qt <http://trolltech.com/products/qt>`_, version 4.5.x, 4.4.x,
   4.3.x, and 3.3.x  are supported.
#. `SIP <http://www.riverbankcomputing.co.uk/software/sip/intro>`_,
   version 4.8.x and 4.7.x (x > 3) are supported. 
#. `PyQt <http://www.riverbankcomputing.co.uk/software/pyqt/intro>`_
   for Mac OS X, Windows, and/or X11, version 4.5.x, 4.4.x, 4.3.x,
   3.18.x, and 3.17.x are supported.
#. optionally `NumPy <http://www.scipy.org/NumPy>`_, version 1.3.x,
   1.2.x, and 1.1.x are supported.
#. optionally `Qwt <http://qwt.sourceforge.net>`_, version 5.2.x,
   5.1.x, and 5.0.x are supported. 

The source package
`PyQwt-5.2.1.tar.gz
<http://prdownloads.sourceforge.net/pyqwt/PyQwt-5.2.1.tar.gz>`_
contains a snapshot of the Qwt-5.2 subversion bug fix branch which may
fix some bugs in Qwt-5.2.0. 
I recommend to compile and link the bug fix branch statically into PyQwt.

To exploit the full power of PyQwt, you should install at least one of
the numerical Python extensions:

* `NumPy <http://www.scipy.org/NumPy>`_
* `numarray
  <http://www.stsci.edu/resources/software_hardware/numarray>`_
* `Numeric <http://numpy.scipy.org/>`_

and built PyQwt with support for the numerical Python extension(s) of
your choice.  However, only NumPy is actively developed and numarray and
Numeric are deprecated. 

PyQwt-|release| and recent versions of the numerical Python extensions support
the `N-D array interface <http://numpy.scipy.org/array_interface.shtml>`_
protocol.  Therefore, PyQwt supports those extensions, even if they have not
been installed when PyQwt has been built. In this case, the functionality is
somewhat reduced, since conversion from an QImage to a Numerical
Python array is not supported. 


Installation
------------

The installation procedure consists of three steps:

#. Unpack PyQwt-|release|.tar.gz.
#. Invoke the following commands to build PyQwt-|release| for Qt-4::

      cd PyQwt-5.2.1
      cd configure
      python configure.py -Q ../qwt-5.2
      make
      make install

   or invoke the commands to build PyQwt-|release| for Qt-3::

      cd PyQwt-5.2.1
      cd configure
      python configure.py -3 -Q ../qwt-5.2
      make
      make install

   This assumes that the correct Python interpreter is on your path. Replace
   :command:`make` by :command:`nmake`, if you use Microsoft Visual C++.
   The commands build PyQwt against the included Qwt subversion snapshot and
   install PyQwt.
   Test the installation by playing with the example programs.

#. Fine tune (optional):

   * to use a Qwt library already installed on your system invoke
     commands similar to::
 
        python configure.py -I/usr/include/qwt -lqwt
	make
	make install

     where the Qwt header files are assumed to be installed in
     ``/usr/include/qwt``.

     If the linker fails to find the qwt library, add::

        -L /directory/with/qwt/library

     to the :command:`configure.py` options.
        
   The configure.py script takes many options. The command::

      python configure.py -h

   displays a full list of the available options

   .. literalinclude:: configure.help


Troubleshooting and getting help
---------------------------------

#. Check whether all development packages have been installed when
   :command:`make` produces lots of errors on Linux.
#. If you fail to install PyQwt, unpack PyQwt-5.2.1.tar.gz into a
   clean directory and create two log files containing :file:`stdout`
   *and* :file:`stderr`:: 

      python configure.py --your --options 2&>1 >configure.log
      make 2&>1 >make.log
   
   Send the log files to the
   `mailing list <mailto:pyqwt-users@lists.sourceforge.net>`_ after 
   `subscribing 
   <http://lists.sourceforge.net/lists/listinfo/pyqwt-users>`_  to the
   mailing list, because the mailing list is for subscribers only, see
   :ref:`getting-help`.


Windows Binary Installer
========================

Make sure that you have installed:

#. `python-2.6.3.msi
   <http://www.python.org/ftp/python/2.6.3/python-2.6.3.msi>`_ 
#. `numpy-1.3.0-win32-superpack-python2.6.exe
   <http://prdownloads.sourceforge.net/numpy/numpy-1.3.0-win32-superpack-python2.6.exe>`_ 
#. `PyQt-Py2.6-gpl-4.6.1-1.exe
   <http://pyqwt.sourceforge.net/support/PyQt-Py2.6-gpl-4.6.1-1.exe>`_

before installing
`PyQwt5.2.1-Python2.6-PyQt4.6.1-NumPy1.3.0-1.exe
<http://prdownloads.sourceforge.net/pyqwt/PyQwt5.2.1-Python2.6-PyQt4.6.1-NumPy1.3.0-1.exe>`_.
