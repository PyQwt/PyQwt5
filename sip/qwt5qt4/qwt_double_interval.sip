// The SIP interface specification for:
//      QwtDoubleInterval.
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


%If (Qwt_5_0_0 - Qwt_5_2_0)
class QwtDoubleInterval
{
%TypeHeaderCode
#include <qwt_double_interval.h>
%End // %TypeHeaderCode

public:
    QwtDoubleInterval();
    QwtDoubleInterval(double, double);
    void setInterval(double, double);
    QwtDoubleInterval normalized() const;
    QwtDoubleInterval inverted() const;
    QwtDoubleInterval limited(double, double) const;
    int operator==(const QwtDoubleInterval&) const;
    int operator!=(const QwtDoubleInterval&) const;
    double minValue() const;
    double maxValue() const;
    double width() const;
    void setMinValue(double);
    void setMaxValue(double);
    bool contains(double) const;
    bool intersects(const QwtDoubleInterval&) const;
    QwtDoubleInterval intersect(const QwtDoubleInterval&) const;
    QwtDoubleInterval unite(const QwtDoubleInterval&) const;
    QwtDoubleInterval operator|(const QwtDoubleInterval&) const;
    QwtDoubleInterval operator&(const QwtDoubleInterval&) const;
    QwtDoubleInterval& __ior__(const QwtDoubleInterval&);
    QwtDoubleInterval& __iand__(const QwtDoubleInterval&);
    QwtDoubleInterval extend(double) const;
    QwtDoubleInterval operator|(double) const;
    QwtDoubleInterval& __ior__(double);
    bool isValid() const;
    bool isNull() const;
    void invalidate();
    QwtDoubleInterval symmetrize(double) const;
}; // class QwtDoubleInterval
%End // (Qwt_5_0_0 - Qwt_5_2_0)

%If (Qwt_5_2_0 - )
class QwtDoubleInterval
{
%TypeHeaderCode
#include <qwt_double_interval.h>
%End // %TypeHeaderCode

public:
    enum BorderMode {
        IncludeBorders,
        ExcludeMinimum,
        ExcludeMaximum,
        ExcludeBorders
    }; // enum BorderMode

    QwtDoubleInterval();
    QwtDoubleInterval(double, double, int = IncludeBorders);
    void setInterval(double, double, int = IncludeBorders);
    QwtDoubleInterval normalized() const;
    QwtDoubleInterval inverted() const;
    QwtDoubleInterval limited(double, double) const;
    int operator==(const QwtDoubleInterval&) const;
    int operator!=(const QwtDoubleInterval&) const;
    void setBorderFlags(int);
    int borderFlags() const;
    double minValue() const;
    double maxValue() const;
    double width() const;
    void setMinValue(double);
    void setMaxValue(double);
    bool contains(double) const;
    bool intersects(const QwtDoubleInterval&) const;
    QwtDoubleInterval intersect(const QwtDoubleInterval&) const;
    QwtDoubleInterval unite(const QwtDoubleInterval&) const;
    QwtDoubleInterval operator|(const QwtDoubleInterval&) const;
    QwtDoubleInterval operator&(const QwtDoubleInterval&) const;
    QwtDoubleInterval& __ior__(const QwtDoubleInterval&);
    QwtDoubleInterval& __iand__(const QwtDoubleInterval&);
    QwtDoubleInterval extend(double) const;
    QwtDoubleInterval operator|(double) const;
    QwtDoubleInterval& __ior__(double);
    bool isValid() const;
    bool isNull() const;
    void invalidate();
    QwtDoubleInterval symmetrize(double) const;
}; // class QwtDoubleInterval
%End // (Qwt_5_2_0 - )


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
