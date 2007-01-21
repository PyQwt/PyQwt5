// The SIP interface definition for:
//      QList<QwtPickerMachine::Command>,
//      QwtValueList.
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


%MappedType QList<QwtPickerMachine::Command>
{
%TypeHeaderCode
#include <qlist.h>
#include <qwt_picker_machine.h>
%End

%ConvertFromTypeCode
    // Create the list.
    PyObject *l = PyList_New(sipCpp->size());
    if (!l)
        return 0;

    for (int i = 0; i < sipCpp->size(); ++i) {
	PyObject *o =  PyInt_FromLong(long(sipCpp->value(i)));
        if (!o) {
            Py_DECREF(l);
            return 0;
        }
        PyList_SET_ITEM(l, i, o);
    }
    return l;
%End // %ConvertFromTypeCode

%ConvertToTypeCode
    if (0 == sipIsErr)
        return PyList_Check(sipPy);

    QList<QwtPickerMachine::Command> *l = new QList<QwtPickerMachine::Command>;

    for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i) {
        l->append(QwtPickerMachine::Command(PyInt_AsLong(PyList_GET_ITEM(sipPy, i))));
    }
    *sipCppPtr = l;
    return sipGetState(sipTransferObj);
%End // %ConvertToTypeCode

}; // QList<QwtPickerMachine::Command>


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

    for (int i = 0; i < int(sipCpp->count()); ++i) {
	PyObject *o = PyFloat_FromDouble(sipCpp->value(i));
	if (!o) {
            Py_DECREF(l);
            return 0;
        }
        PyList_SET_ITEM(l, i, o);
    }
    return l;
%End // %ConvertFromTypeCode

%ConvertToTypeCode
    if (0 == sipIsErr)
        return PyList_Check(sipPy);

    QwtValueList *l = new QwtValueList;

    for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i) {
        l->append(PyFloat_AsDouble(PyList_GET_ITEM(sipPy, i)));
    }
    *sipCppPtr = l;
    return sipGetState(sipTransferObj);
%End // %ConvertToTypeCode

}; // QwtValueList


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// End:
