// The header for the interface PyQwt <-> Numerical Python extensions.
//
// Copyright (C) 2001-2009 Gerard Vermeulen
// Copyright (C) 2000 Mark Colclough
//
// This file is part of PyQwt.
//
// PyQwt is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// PyQwt is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along
// with PyQwt; if not, write to the Free Software Foundation, Inc.,
// 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
//
// In addition, as a special exception, Gerard Vermeulen gives permission
// to link PyQwt dynamically with non-free versions of Qt and PyQt,
// and to distribute PyQwt in this form, provided that equally powerful
// versions of Qt and PyQt have been released under the terms of the GNU
// General Public License.
//
// If PyQwt is dynamically linked with non-free versions of Qt and PyQt,
// PyQwt becomes a free plug-in for a non-free program.


#ifndef QWT_NUMERICAL_INTERFACE_H
#define QWT_NUMERICAL_INTERFACE_H

#include <Python.h>
#include <qimage.h>
#include <qwt_array.h>

#ifdef HAS_NUMARRAY
// to hide numarray's import_array()
void qwt_import_numarray();

PyObject *toNumarray(const QImage &image);
#endif

#ifdef HAS_NUMERIC
// to hide Numeric's import_array()
void qwt_import_numeric();

PyObject *toNumeric(const QImage &image);
#endif

#ifdef HAS_NUMPY
// to hide NumPy's import_array()
void qwt_import_numpy();

PyObject *toNumpy(const QImage &image);
#endif

// returns 1, 0, -1 in case of success, wrong object type, failure
int try_PyObject_to_QwtArray(PyObject *object, QwtArray<double> &array);

// returns 1, 0, -1 in case of success, wrong object type, failure
int try_PyObject_to_QwtArray(PyObject *object, QwtArray<int> &array);

// returns 1, 0, -1 in case of success, wrong object type, failure
int try_PyObject_to_QwtArray(PyObject *object, QwtArray<long> &array);

// returns 1, 0, -1 in case of success, wrong object type, failure
int try_PyObject_to_QImage(PyObject *object, QImage **image);

#endif // QWT_NUMERICAL_INTERFACE_H

// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
