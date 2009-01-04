// The SIP interface specification for:
//      QwtArrayData,
//      QwtData,
//      QwtPolygonFData.
//
// Copyright (C) 2001-2009 Gerard Vermeulen
// Copyright (C) 2000 Mark Colclough
//
// This file is part of PyQwt.
//
// PyQwt is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
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


class QwtArrayData: QwtData
{
%TypeHeaderCode
#include <qwt_data.h>
%End // %TypeHeaderCode

public:
    QwtArrayData(const QwtArrayDouble&, const QwtArrayDouble&);
    QwtArrayData(SIP_PYOBJECT, SIP_PYOBJECT) [(const double*, const double*, size_t)];
%MethodCode
QwtArray<double> xArray;
if (-1 == try_PyObject_to_QwtArray(a0, xArray))
    return 0;

QwtArray<double> yArray;
if (-1 == try_PyObject_to_QwtArray(a1, yArray))
    return 0;

sipCpp = new sipQwtArrayData(xArray, yArray);
%End

    // Not Pythonic: QwtArrayData& operator=(const QwtArrayData&);
    virtual QwtData* copy() const /Factory/;
    virtual size_t size() const;
    virtual double x(size_t) const;
    virtual double y(size_t) const;
    const QwtArrayDouble& xData() const;
    const QwtArrayDouble& yData() const;
    virtual QwtDoubleRect boundingRect() const;
}; // class QwtArrayData


class QwtData
{
%TypeHeaderCode
#include <qwt_data.h>
%End // %TypeHeaderCode

public:
    QwtData();
    virtual ~QwtData();
    virtual QwtData* copy() const = 0 /Factory/;
    virtual size_t size() const = 0;
    virtual double x(size_t) const = 0;
    virtual double y(size_t) const = 0;
    virtual QwtDoubleRect boundingRect() const;
protected:
    // Not Pythonic: QwtData& operator=(const QwtData&);

private:
    QwtData(const QwtData&);
%If (CXX_DYNAMIC_CAST)
%ConvertToSubClassCode
    // Walk the inheritance tree depth first in alphabetical order
    // This code is for Qwt4 and Qwt5
#ifdef sipClass_QwtArrayData
    if (dynamic_cast<const QwtArrayData *>(sipCpp))
        sipClass = sipClass_QwtArrayData;
    else
#endif
#ifdef sipClass_QwtDoublePointData
    if (dynamic_cast<const QwtDoublePointData *>(sipCpp))
        sipClass = sipClass_QwtDoublePointData;
    else
#endif
#ifdef sipClass_QwtPolygonFData
    if (dynamic_cast<const QwtPolygonFData *>(sipCpp))
        sipClass = sipClass_QwtPolygonFData;
    else
#endif
#ifdef sipClass_QwtData
    if (dynamic_cast<const QwtData *>(sipCpp))
        sipClass = sipClass_QwtData;
    else
#endif
        sipClass = 0;
%End
%End

}; // class QwtData


class QwtPolygonFData: QwtData
{
%TypeHeaderCode
#include <qwt_data.h>
%End // %TypeHeaderCode

public:
    QwtPolygonFData(const QwtArrayQwtDoublePoint&);
    // Not Pythonic: QwtPolygonFData& operator=(const QwtPolygonFData&);
    virtual QwtData* copy() const;
    virtual size_t size() const;
    virtual double x(size_t) const;
    virtual double y(size_t) const;
    const QwtArrayQwtDoublePoint& data() const;
}; // class QwtPolygonFData


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
