// The SIP interface specification for:
//      QMap<double, QString>.
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


%MappedType QMap<double, QString>
{
%TypeHeaderCode
#include <qwt_compass.h>
%End

%ConvertFromTypeCode
    PyObject *d = PyDict_New();

    if (!d)
        return d;

    QMap<double, QString>::const_iterator i = sipCpp->constBegin();

    while (i != sipCpp->constEnd()) {
        QString *t = new QString(i.data());

        PyObject *kobj = PyFloat_FromDouble(i.key());
        PyObject *tobj = sipConvertFromNewType(
            t, sipType_QString, sipTransferObj);

        if ((0 == kobj) || (0 == tobj) || (0 > PyDict_SetItem(d, kobj, tobj))) {
            Py_DECREF(d);

            if (kobj)
                Py_DECREF(kobj);

            if (tobj)
                Py_DECREF(tobj);
            else
                delete t;

            return 0;
        }

        Py_DECREF(kobj);
        Py_DECREF(tobj);

        ++i;
    }

    return d;
%End // ConvertFromTypeCode

%ConvertToTypeCode
    PyObject *kobj, *tobj;
    SIP_SSIZE_T i = 0;

    if (0 == sipIsErr) {
        if (!PyDict_Check(sipPy))
            return 0;

        while (PyDict_Next(sipPy, &i, &kobj, &tobj))
            if (!sipCanConvertToType(tobj, sipType_QString, SIP_NOT_NONE))
                return 0;

        return 1;
    }

    QMap<double, QString> *qm = new QMap<double, QString>;

    while (PyDict_Next(sipPy, &i, &kobj, &tobj)) {
        int state;
        double k = PyFloat_AS_DOUBLE(kobj);
        QString *t = reinterpret_cast<QString *>(
            sipConvertToType(tobj, sipType_QString, sipTransferObj,
                             SIP_NOT_NONE, &state, sipIsErr));

        if (*sipIsErr) {
            sipReleaseType(t, sipType_QString, state);

            delete qm;
            return 0;
        }

        qm->insert(k, *t);

        sipReleaseType(t, sipType_QString, state);
    }

    *sipCppPtr = qm;

    return sipGetState(sipTransferObj);
%End // ConvertToTypeCode

}; // QMap<double, QString>


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
