// The SIP interface definition for:
//      QMemArray<Type>.
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
// with this PyQwt; if not, write to the Free Software Foundation, Inc.,
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


// QMemArray<TYPE> is implemented as a Python list.
template<TYPE>
%MappedType QMemArray<TYPE>
{
%TypeHeaderCode
#include <qmemarray.h>
%End

%ConvertFromTypeCode
    // Create the list.
    PyObject *l = PyList_New(sipCpp->size());
    if (0 == l)
        return 0;
    // Set the list elements.
    for (int i=0; i<int(sipCpp->size()); ++i) {
        TYPE *t = new TYPE(sipCpp->at(i));
	PyObject *o = sipConvertFromNewInstance(t, sipClass_TYPE, sipTransferObj);
        if (0 == o) {
            Py_DECREF(l);
            delete t;
            return 0;
        }
        PyList_SET_ITEM(l, i, o);
    }
    return l;
%End

%ConvertToTypeCode
    // Type checking if that is all that is required.
    if (!sipIsErr) {
        if (!PyList_Check(sipPy))
            return 0;
	// check elements
        for (int i=0; i < PyList_GET_SIZE(sipPy); ++i)
            if (!sipCanConvertToInstance(PyList_GET_ITEM(sipPy, i), sipClass_TYPE, SIP_NOT_NONE))
                return 0;
        return 1;
    }
    // Return the QMemArray
    QMemArray<TYPE> *a = new QMemArray<TYPE>(PyList_GET_SIZE(sipPy));
    for (int i=0; i<PyList_GET_SIZE(sipPy); ++i) {
	int state;
        TYPE *t = reinterpret_cast<TYPE *>(
	    sipConvertToInstance(PyList_GET_ITEM(sipPy, i), sipClass_TYPE, sipTransferObj, SIP_NOT_NONE, &state, sipIsErr));
        if (*sipIsErr) {
            sipReleaseInstance(t, sipClass_TYPE, state);
            delete a;
            return 0;
        }
        (*a)[i] = *t;
        sipReleaseInstance(t, sipClass_TYPE, state);
    }
    *sipCppPtr = a;
    return sipGetState(sipTransferObj);
%End
}; // template<TYPE> %MappedType QMemArray<TYPE>
  

// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// End:
