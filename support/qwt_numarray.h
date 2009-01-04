// The header for the interface PyQwt <-> numarray.
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


#ifndef QWT_NUMARRAY_H
#define QWT_NUMARRAY_H

#ifdef HAS_NUMARRAY

#include <Python.h>
#include <qwt_array.h>
#include <qwt_numerical_interface.h>

// returns 1, 0, -1 in case of success, wrong PyObject type, failure
int try_NumarrayArray_to_QwtArray(PyObject *in, QwtArray<double> &out);

// returns 1, 0, -1 in case of success, wrong PyObject type, failure
int try_NumarrayArray_to_QwtArray(PyObject *in, QwtArray<int> &out);

// returns 1, 0, -1 in case of success, wrong PyObject type, failure
int try_NumarrayArray_to_QwtArray(PyObject *in, QwtArray<long> &out);

// returns 1, 0, -1 in case of success, wrong PyObject type, failure
int try_NumarrayArray_to_QImage(PyObject *in, QImage **out);

#endif // HAS_NUMARRAY

#endif // QWT_NUMARRAY_H

// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
