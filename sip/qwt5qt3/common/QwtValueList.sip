// The SIP interface definition for:
//      QValueList<QwtPickerMachine::Command>,
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


// QValueList<QwtPickerMachine::Command> is implemented as a Python list.
%MappedType QValueList<QwtPickerMachine::Command>
{
%TypeHeaderCode
#include <qvaluelist.h>
%End

%ConvertFromTypeCode
    // Create the list.
    PyObject *l  = PyList_New(sipCpp->size());

    if (0 == l)
        return 0;

    // Set the list elements.
    for (int i = 0; i < int(sipCpp->size()); ++i) {
      QwtPickerMachine::Command *t = new QwtPickerMachine::Command((*sipCpp)[i]);
        PyObject *tobj = sipConvertFromNewType(t, sipType_QwtPickerMachine_Command, sipTransferObj);

        if (0 == tobj) {
            Py_DECREF(l);
            delete t;

            return 0;
        }

        PyList_SET_ITEM(l, i, tobj);
    }

    return l;
%End

%ConvertToTypeCode
    SIP_SSIZE_T size;

    // Check the type if that is all that is required.
    if (0 == sipIsErr)
    {
        if (!PySequence_Check(sipPy) || 0 > (size = PySequence_Size(sipPy)))
            return 0;

        for (SIP_SSIZE_T i = 0; i < size; ++i)
        {
            PyObject *item = PySequence_ITEM(sipPy, i);
            bool ok = (item && sipCanConvertToType(item, sipType_QwtPickerMachine_Command, SIP_NOT_NONE));

            Py_XDECREF(item);

            if (!ok)
                return 0;
        }

        return 1;
    }

    QValueList<QwtPickerMachine::Command> *l = new QValueList<QwtPickerMachine::Command>;

    size = PySequence_Size(sipPy);
 
    for (SIP_SSIZE_T i = 0; i < size; ++i) {
        PyObject *item = PySequence_ITEM(sipPy, i);
        int state;
        QwtPickerMachine::Command *t = reinterpret_cast<QwtPickerMachine::Command *>(sipConvertToType(item, sipType_QwtPickerMachine_Command, sipTransferObj, SIP_NOT_NONE, &state, sipIsErr));

        Py_DECREF(item);
 
        if (*sipIsErr)
        {
            sipReleaseType(t, sipType_QwtPickerMachine_Command, state);

            delete l;
            return 0;
        }

        l->append(*t);

        sipReleaseType(t, sipType_QwtPickerMachine_Command, state);
    }
 
    *sipCppPtr = l;
 
    return sipGetState(sipTransferObj);
%End
};


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
	PyObject *o = sipConvertFromType(t, sipType_TYPE, sipTransferObj);
        if (!o) {
            Py_DECREF(l);
            return 0;
        }
        PyList_SET_ITEM(l, i, o);
    }
    return l;
%End

%ConvertToTypeCode
    SIP_SSIZE_T len;

    // Check the type if that is all that is required.
    if (0 == sipIsErr) {
        if (!PySequence_Check(sipPy) || 0 < (len = PySequence_Size(sipPy)))
            return 0;

	// Check the elements
        for (SIP_SSIZE_T i = 0; i < len; ++i) {
	    PyObject *item = PySequence_ITEM(sipPy, i);
            bool ok = (item && sipCanConvertToType(item, sipType_TYPE, 0));

            Py_XDECREF(item);

            if (!ok)
                return 0;
	}
        return 1;
    }
    // Return the QValueList.
    QValueList<TYPE *> *l = new QValueList<TYPE *>;
    len = PySequence_Size(sipPy);
 
    for (SIP_SSIZE_T i=0; i < len; ++i) {
        PyObject *item = PySequence_ITEM(sipPy, i);
        TYPE *t = reinterpret_cast<TYPE *>(sipConvertToType(item, sipType_TYPE, sipTransferObj, 0, 0, sipIsErr));

        Py_DECREF(item);
 
        if (*sipIsErr)
        {
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
