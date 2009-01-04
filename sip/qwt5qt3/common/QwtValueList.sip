// The SIP interface definition for:
//      QValueList<QwtPickerMachine::Command>,
//      QValueList<Type>,
//      QValueList<Type*>,
//      QwtValueList.
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


%MappedType QValueList<QwtPickerMachine::Command>
{
%TypeHeaderCode
#include <qvaluelist.h>
#include <qwt_picker_machine.h>
%End

%ConvertFromTypeCode
    // Create the list.
    PyObject *l = PyList_New(sipCpp->size());
    if (0 == l)
        return 0;
    // Set the list elements.
    for (int i = 0; i < int(sipCpp->count()); ++i) {
	PyObject *o = PyInt_FromLong(long((*sipCpp)[i]));
	if (!o) {
	    Py_DECREF(l);
	    return 0;
	}
        PyList_SetItem(l, i, o);
    }
    return l;
%End // %ConvertFromTypeCode

%ConvertToTypeCode
    // Type checking if that is all that is required.
    if (!sipIsErr)
        return PyList_Check(sipPy);
    // Return the QValueList.    
    QValueList<QwtPickerMachine::Command> *l =
        new QValueList<QwtPickerMachine::Command>;
    for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i) {
        l->append((QwtPickerMachine::Command)PyInt_AsLong(PyList_GET_ITEM(sipPy, i)));
    }
    *sipCppPtr = l;
    return sipGetState(sipTransferObj);
%End // %ConvertToTypeCode

}; // QValueList<QwtPickerMachine::Command>


// QList<TYPE> is implemented as a Python list.
template<TYPE>
%MappedType QList<TYPE>
{
%TypeHeaderCode
#include <qvaluelist.h>
%End

%ConvertFromTypeCode
    // Handle NULL pointer.
    if (!sipCpp)
        return PyList_New(0);
    // Create the list.
    PyObject *l = PyList_New(sipCpp->size());
    if (!l)
        return 0;
    // Set the list elements.
    for (int i = 0; i < sipCpp->size(); ++i) {
        TYPE *t = new TYPE(sipCpp->at(i));
        PyObject *o = sipBuildResult(0, "N", t, sipClass_TYPE);
        if (!o) {
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
	// Check the elements
        for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i)
            if (!sipCanConvertToInstance(PyList_GET_ITEM(sipPy, i), sipClass_TYPE, SIP_NOT_NONE))
                return 0;
        return 1;
    }
    // Return the QValueList.    
    QValueList<TYPE> *l = new QValueList<TYPE>;
    for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i) {
        int state;
        TYPE *t = reinterpret_cast<TYPE *>(
	    sipConvertToInstance(PyList_GET_ITEM(sipPy, i), sipClass_TYPE, sipTransferObj, SIP_NOT_NONE, &state, sipIsErr));
        if (*sipIsErr) {
            sipReleaseInstance(t, sipClass_TYPE, state);
            delete l;
            return 0;
        }
        l->append(*t);
        sipReleaseInstance(t, sipClass_TYPE, state);
    }
    *sipCppPtr = l;
    return sipGetState(sipTransferObj);
%End
}; // template<TYPE> %MappedType QList<TYPE>


// QValueList<TYPE *> is implemented as a Python list.
template<TYPE>
%MappedType QValueList<TYPE *>
{
%TypeHeaderCode
#include <qvaluelist.h>
%End

%ConvertFromTypeCode
    // Create the list.
    PyObject *l = PyList_New(sipCpp->size());
    if (0 == l)
        return 0;
    // Set the list elements.
    for (int i = 0; i < int(sipCpp->size()); ++i) {
        TYPE *t = (*sipCpp)[i];
	PyObject *o = sipConvertFromInstance(t, sipClass_TYPE, sipTransferObj);
        if (!o) {
            Py_DECREF(l);
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
	// Check the elements
        for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i)
            if (!sipCanConvertToInstance(PyList_GET_ITEM(sipPy, i), sipClass_TYPE, 0))
                return 0;
        return 1;
    }
    // Return the QValueList.
    QValueList<TYPE *> *l = new QValueList<TYPE *>;
    for (int i=0; i < PyList_GET_SIZE(sipPy); ++i) {
        TYPE *t = reinterpret_cast<TYPE *>(
	    sipConvertToInstance(PyList_GET_ITEM(sipPy, i), sipClass_TYPE, sipTransferObj, 0, 0, sipIsErr));
        if (*sipIsErr) {
            delete l;
            return 0;
        }
        l->append(t);
    }
    *sipCppPtr = l;
    return sipGetState(sipTransferObj);
%End
}; // template<TYPE> %MappedType QValueList<TYPE *>


%If (HAS_QWT5)
%MappedType QwtValueList
{
%TypeHeaderCode
#include <qwt_valuelist.h>
%End

%ConvertFromTypeCode
    // Create the list.
    PyObject *l = PyList_New(sipCpp->size());
    if (0 == l)
        return 0;
    // Set the list elements.
    for (int i = 0; i < int(sipCpp->size()); ++i) {
	PyObject *o =  PyFloat_FromDouble((*sipCpp)[i]);
	if (!o) {
            Py_DECREF(l);            
            return 0;
        }
        PyList_SetItem(l, i, o);
    }
    return l;
%End // %ConvertFromTypeCode

%ConvertToTypeCode
    // Type checking if that is all that is required.
    if (!sipIsErr)
        return PyList_Check(sipPy);
    // Create the list.
    QwtValueList *l = new QwtValueList;
    for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i) {
        l->append(PyFloat_AsDouble(PyList_GET_ITEM(sipPy, i)));
    }
    *sipCppPtr = l;
    return sipGetState(sipTransferObj);
%End // %ConvertToTypeCode

}; // QwtValueList
%End // HAS_QWT5

// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// End:
