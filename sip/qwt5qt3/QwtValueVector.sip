// The SIP interface definition for:
//      QValueVector<unsigned>.
//
// Copyright (C) 2001-2007 Gerard Vermeulen
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


%MappedType QValueVector<unsigned>
{
%TypeHeaderCode
#include <qvaluevector.h>
%End

%ConvertFromTypeCode
    // Create the list.
     PyObject *l = PyList_New(sipCpp->size());

    if (!l)
        return 0;
    // Set the list elements.
    for (int i = 0; i < sipCpp->size(); ++i) {
        PyObject *o = PyInt_FromLong(long((*sipCpp)[i]));
        if (!o) {
            Py_DECREF(l);
            return 0;
        }
        PyList_SET_ITEM(l, i, o);
    }
    return l;
%End // %ConvertFromTypeCode

%ConvertToTypeCode
    // Type checking if that is all that is required.
    if (!sipIsErr)
        return PyList_Check(sipPy);

    QValueVector<unsigned> *v = new QValueVector<unsigned>;

    for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i) {
        v[i] = PyInt_AsLong(PyList_GET_ITEM(sipPy, i));
    }
    *sipCppPtr = v;
    return sipGetState(sipTransferObj);
%End // %ConvertToTypeCode

}; // QValueVector<unsigned>


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// End:
