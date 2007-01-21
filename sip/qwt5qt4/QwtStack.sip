// The SIP interface specification for:
//      QStack<Type>.
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


// QStack<Type> is implemented as a Python list.
template<Type>
%MappedType QStack<Type>
{
%TypeHeaderCode
#include <qstack.h>
%End

%ConvertFromTypeCode
    // Create the list.
    PyObject *l = PyList_New(sipCpp->size());
    if (!l)
        return 0;

    // Set the list elements.
    for (int i=0; i<sipCpp->size(); ++i) {
        Type *t = new Type(sipCpp->at(i));
        PyObject *o = sipConvertFromNewInstance(t, sipClass_Type, sipTransferObj);
        if (0 == o) {
            Py_XDECREF(o);
            Py_DECREF(l);

            return 0;
        }
        PyList_SetItem(l, i, o);
    }
    return l;
%End

%ConvertToTypeCode
    // Type checking if only that is required.
    if (!sipIsErr) {
        if (!PyList_Check(sipPy))
            return 0;
        // check elements
        for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i)
            if (!sipCanConvertToInstance(PyList_GET_ITEM(sipPy, i), sipClass_Type, 0))
                return 0;
        return 1;
    }

    // Return the QStack.
    QStack<Type> *s = new QStack<Type>;
    for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i) {
        int state;
        Type *t = reinterpret_cast<Type *>(sipConvertToInstance(PyList_GET_ITEM(sipPy, i), sipClass_Type, 0, SIP_NOT_NONE, &state, sipIsErr));

        if (*sipIsErr) {
            sipReleaseInstance(t, sipClass_Type, state);
            delete s;
            return 0;
        }
        s->append(*t);
        sipReleaseInstance(t, sipClass_Type, state);
    }
    *sipCppPtr = s;

    return sipGetState(sipTransferObj);
%End
}; // template<Type> %MappedType QStack<Type>


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:

