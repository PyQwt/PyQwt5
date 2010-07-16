// The SIP interface definition for:
//      QList<QwtPickerMachine::Command>.
//
// Copyright (C) 2001-2010 Gerard Vermeulen
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


// Mapped type for QList<QwtPickerMachine::Command>.
%MappedType QList<QwtPickerMachine::Command> /DocType="list-of-QwtPickerMachine.Command"/
{
%TypeHeaderCode
#include <qwt_picker_machine.h>
%End

%ConvertFromTypeCode
    // Create the list.
    PyObject *l = PyList_New(sipCpp->size());
    if (0 == l)
        return 0;

    // Set the list elements.
    for (int i = 0; i < sipCpp->size(); ++i) {
        PyObject *o = sipConvertFromEnum(
            sipCpp->at(i), sipType_QwtPickerMachine_Command);
        if (0 == o) {
            Py_DECREF(l);
            return 0;
        }
        PyList_SET_ITEM(l, i, o);
    }
    return l;
%End  // %ConvertFromTypeCode

%ConvertToTypeCode
    // Check the type if that is all that is required.
    if (0 == sipIsErr) {
        if (!PyList_Check(sipPy))
            return 0;

        for (SIP_SSIZE_T i = 0; i < PyList_GET_SIZE(sipPy); ++i)
            if (PyObject_TypeCheck(
                    PyList_GET_ITEM(sipPy, i),
                    sipTypeAsPyTypeObject(sipType_QwtPickerMachine_Command)))
                return 0;

        return 1;
    }

    QList<QwtPickerMachine::Command> *ql = new QList<QwtPickerMachine::Command>;
 
    for (SIP_SSIZE_T i = 0; i < PyList_GET_SIZE(sipPy); ++i) {
        long l = SIPLong_AsLong(PyList_GET_ITEM(sipPy, i));
        ql->append(static_cast<QwtPickerMachine::Command>(l));
    }
 
    *sipCppPtr = ql;
    return sipGetState(sipTransferObj);
%End  // %ConvertToTypeCode

}; // QwtPickerMachine::Command


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
