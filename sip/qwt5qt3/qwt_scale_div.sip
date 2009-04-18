// The SIP interface specification for:
//      QwtScaleDiv.
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


%If (Qwt_5_0_0 - Qwt_5_1_0)
class QwtScaleDiv
{
%TypeHeaderCode
#include <qwt_scale_div.h>
%End // %TypeHeaderCode

public:
    enum TickType {
        NoTick,
        MinorTick,
        MediumTick,
        MajorTick,
        NTickTypes
    }; // enum TickType

    QwtScaleDiv();
    QwtScaleDiv(const QwtDoubleInterval&, QwtValueList, QwtValueList, QwtValueList) [(const QwtDoubleInterval&, QwtValueList*)];
%MethodCode
Py_BEGIN_ALLOW_THREADS
QwtValueList ticks[QwtScaleDiv::NTickTypes] = {*a1, *a2, *a3};
sipCpp = new QwtScaleDiv(*a0, ticks);
Py_END_ALLOW_THREADS
%End

    QwtScaleDiv(double, double, QwtValueList, QwtValueList, QwtValueList) [(const QwtDoubleInterval&, QwtValueList*)];
%MethodCode
Py_BEGIN_ALLOW_THREADS
QwtValueList ticks[QwtScaleDiv::NTickTypes] = {*a2, *a3, *a4};
sipCpp = new QwtScaleDiv(a0, a1, ticks);
Py_END_ALLOW_THREADS
%End

    int operator==(const QwtScaleDiv&) const;
    int operator!=(const QwtScaleDiv&) const;
    double lBound() const;
    double hBound() const;
    double range() const;
    bool contains(double) const;
    const QwtValueList& ticks(int) const;
    void invalidate();
    bool isValid() const;
    void invert();
}; // class QwtScaleDiv
%End // (Qwt_5_0_0 - Qwt_5_1_0)

%If (Qwt_5_1_0 - Qwt_5_2_0)
class QwtScaleDiv
{
%TypeHeaderCode
#include <qwt_scale_div.h>
%End // %TypeHeaderCode

public:
    enum TickType {
        NoTick,
        MinorTick,
        MediumTick,
        MajorTick,
        NTickTypes
    }; // enum TickType

    QwtScaleDiv();
    QwtScaleDiv(const QwtDoubleInterval&, QwtValueList, QwtValueList, QwtValueList) [(const QwtDoubleInterval&, QwtValueList*)];
%MethodCode
Py_BEGIN_ALLOW_THREADS
QwtValueList ticks[QwtScaleDiv::NTickTypes] = {*a1, *a2, *a3};
sipCpp = new QwtScaleDiv(*a0, ticks);
Py_END_ALLOW_THREADS
%End

    QwtScaleDiv(double, double, QwtValueList, QwtValueList, QwtValueList) [(const QwtDoubleInterval&, QwtValueList*)];
%MethodCode
Py_BEGIN_ALLOW_THREADS
QwtValueList ticks[QwtScaleDiv::NTickTypes] = {*a2, *a3, *a4};
sipCpp = new QwtScaleDiv(a0, a1, ticks);
Py_END_ALLOW_THREADS
%End

    int operator==(const QwtScaleDiv&) const;
    int operator!=(const QwtScaleDiv&) const;
    void setInterval(double, double);
    void setInterval(const QwtDoubleInterval&);
    QwtDoubleInterval interval() const;
    double lBound() const;
    double hBound() const;
    double range() const;
    bool contains(double) const;
    void setTicks(int, const QwtValueList&);
    const QwtValueList& ticks(int) const;
    void invalidate();
    bool isValid() const;
    void invert();
}; // class QwtScaleDiv
%End // (Qwt_5_1_0 - Qwt_5_2_0)

%If (Qwt_5_2_0 - )
class QwtScaleDiv
{
%TypeHeaderCode
#include <qwt_scale_div.h>
%End // %TypeHeaderCode

public:
    enum TickType {
        NoTick,
        MinorTick,
        MediumTick,
        MajorTick,
        NTickTypes
    }; // enum TickType

    QwtScaleDiv();
    QwtScaleDiv(const QwtDoubleInterval&, QwtValueList, QwtValueList, QwtValueList) [(const QwtDoubleInterval&, QwtValueList*)];
%MethodCode
Py_BEGIN_ALLOW_THREADS
QwtValueList ticks[QwtScaleDiv::NTickTypes] = {*a1, *a2, *a3};
sipCpp = new QwtScaleDiv(*a0, ticks);
Py_END_ALLOW_THREADS
%End

    QwtScaleDiv(double, double, QwtValueList, QwtValueList, QwtValueList) [(const QwtDoubleInterval&, QwtValueList*)];
%MethodCode
Py_BEGIN_ALLOW_THREADS
QwtValueList ticks[QwtScaleDiv::NTickTypes] = {*a2, *a3, *a4};
sipCpp = new QwtScaleDiv(a0, a1, ticks);
Py_END_ALLOW_THREADS
%End

    int operator==(const QwtScaleDiv&) const;
    int operator!=(const QwtScaleDiv&) const;
    void setInterval(double, double);
    void setInterval(const QwtDoubleInterval&);
    QwtDoubleInterval interval() const;
    double lowerBound() const;
    double upperBound() const;
    double range() const;
    bool contains(double) const;
    void setTicks(int, const QwtValueList&);
    const QwtValueList& ticks(int) const;
    void invalidate();
    bool isValid() const;
    void invert();
}; // class QwtScaleDiv
%End // (Qwt_5_2_0 - )


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
