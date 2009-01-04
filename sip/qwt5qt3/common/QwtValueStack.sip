// The SIP interface specification for:
//      QValueStack<Type>.
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


// QValueStack<Type> is implemented as a Python list.
template<Type>
%MappedType QValueStack<Type>
{
%TypeHeaderCode
#include <qvaluestack.h>
%End

%ConvertFromTypeCode
    // Create the list.
    PyObject *l = PyList_New(sipCpp->size());
    if (!l)
        return 0;

    // Set the list elements.
    int i = 0;
    QValueListConstIterator<Type> it;
    for (it = sipCpp->begin(); it != sipCpp->end(); ++it) {
        PyObject *o;
        if (0 == (o = sipConvertFromInstance(new Type(*it), sipClass_Type, sipTransferObj))
            || 0 > PyList_SetItem(l, i, o)) {
            Py_XDECREF(o);
            Py_DECREF(l);
            
            return 0;
        }
        ++i;
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

    // Return the QValueStack.
    QValueStack<Type> *s = new QValueStack<Type>;
    for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i) {
        int iserr = 0, state;

        Type *t = reinterpret_cast<Type *>(sipConvertToInstance(PyList_GET_ITEM(sipPy, i), sipClass_Type, 0, SIP_NOT_NONE, &state, &iserr));

        if (iserr) {
            sipReleaseInstance(t, sipClass_Type, state);
            *sipIsErr = 1;
            delete s;
            
            return 0;
        }
        s->append(*t);
        sipReleaseInstance(t, sipClass_Type, state);
    }
    *sipCppPtr = s;    
    
    return sipGetState(sipTransferObj);
%End
}; // template<Type> %MappedType QValueStack<Type>


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:

