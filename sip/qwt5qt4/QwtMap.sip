// The SIP interface specification for:
//      QMap<double, QString>.
//
// Copyright (C) 2001-2006 Gerard Vermeulen
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


%MappedType QMap<double, QString>
{
%TypeHeaderCode
#include <qwt_compass.h>
%End

%ConvertFromTypeCode
    PyObject *d = PyDict_New();

    if (!sipCpp || !d)
        return d;

    const QMap<double, QString> map = *sipCpp;
    QMap<double, QString>::ConstIterator it;

    for (it = map.begin(); it != map.end(); ++it) {
        PyObject *key = PyFloat_FromDouble(it.key());
        PyObject *val = sipBuildResult(
            0, "N", new QString(it.value()), sipClass_QString);
        if ((0 == key) || (0 == val) || (0 > PyDict_SetItem(d, key, val))) {
            Py_XDECREF(key);
            Py_XDECREF(val);
            Py_DECREF(d);
            return 0;
        }
    }

    return d;
%End // ConvertFromTypeCode

%ConvertToTypeCode
    if (0 == sipIsErr)
        return PyDict_Check(sipPy);

    QMap<double, QString> *map = new QMap<double, QString>;

    PyObject *key, *val;
    int i = 0;

    while (PyDict_Next(sipPy, &i, &key, &val)) {
        double cKey = PyFloat_AS_DOUBLE(key);
        QString *cVal = reinterpret_cast<QString *>(
            sipForceConvertTo_QString(val, sipIsErr));

        if (*sipIsErr) {
            delete map;
            return 0;
        }

        map->insert(cKey, *cVal);
    }

    *sipCppPtr = map;

    return 1;
%End // ConvertToTypeCode

}; // QMap<double, QString>


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
