// The SIP interface specification for:
//      QwtDoublePoint,
//      QwtDoubleRect,
//      QwtDoubleSize.
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
class QwtDoublePoint
{
%TypeHeaderCode
#include <qwt_double_rect.h>
%End // %TypeHeaderCode

public:
    QwtDoublePoint();
    QwtDoublePoint(double, double);
    QwtDoublePoint(const QPoint&);
    QPoint toPoint() const;
    bool isNull() const;
    double x() const;
    double y() const;
    double rx();
    double ry();
    void setX(double);
    void setY(double);
    bool operator==(const QwtDoublePoint&) const;
    bool operator!=(const QwtDoublePoint&) const;
    const QwtDoublePoint __neg__() const;
    const QwtDoublePoint operator+(const QwtDoublePoint&) const;
    const QwtDoublePoint operator-(const QwtDoublePoint&) const;
    const QwtDoublePoint operator*(double) const;
    const QwtDoublePoint operator/(double) const;
    QwtDoublePoint& __iadd__(const QwtDoublePoint&);
    QwtDoublePoint& __isub__(const QwtDoublePoint&);
    QwtDoublePoint& __imul__(double);
    QwtDoublePoint& __idiv__(double);
}; // class QwtDoublePoint


class QwtDoubleRect
{
%TypeHeaderCode
#include <qwt_double_rect.h>
%End // %TypeHeaderCode

public:
    QwtDoubleRect();
    QwtDoubleRect(double, double, double, double);
    QwtDoubleRect(const QwtDoublePoint&, const QwtDoubleSize&);
    bool isNull() const;
    bool isEmpty() const;
    bool isValid() const;
    QwtDoubleRect normalized() const;
    double x() const;
    double y() const;
    double left() const;
    double right() const;
    double top() const;
    double bottom() const;
    void setX(double);
    void setY(double);
    void setLeft(double);
    void setRight(double);
    void setTop(double);
    void setBottom(double);
    QwtDoublePoint center() const;
    void moveLeft(double);
    void moveRight(double);
    void moveTop(double);
    void moveBottom(double);
    void moveTo(double, double);
    void moveTo(const QwtDoublePoint&);
    void moveBy(double, double);
    void moveCenter(const QwtDoublePoint&);
    void moveCenter(double, double);
    void setRect(double, double, double, double);
    double width() const;
    double height() const;
    QwtDoubleSize size() const;
    void setWidth(double);
    void setHeight(double);
    void setSize(const QwtDoubleSize&);
    QwtDoubleRect operator|(const QwtDoubleRect&) const;
    QwtDoubleRect operator&(const QwtDoubleRect&) const;
    QwtDoubleRect& __ior__(const QwtDoubleRect&);
    QwtDoubleRect& __iand__(const QwtDoubleRect&);
    bool operator==(const QwtDoubleRect&) const;
    bool operator!=(const QwtDoubleRect&) const;
    bool contains(const QwtDoublePoint&, bool = false) const;
    bool contains(double, double, bool = false) const;
    bool contains(const QwtDoubleRect&, bool = false) const;
    QwtDoubleRect unite(const QwtDoubleRect&) const;
    QwtDoubleRect intersect(const QwtDoubleRect&) const;
    bool intersects(const QwtDoubleRect&) const;
}; // class QwtDoubleRect


class QwtDoubleSize
{
%TypeHeaderCode
#include <qwt_double_rect.h>
%End // %TypeHeaderCode

public:
    QwtDoubleSize();
    QwtDoubleSize(double, double);
    QwtDoubleSize(const QSize&);
    bool isNull() const;
    bool isEmpty() const;
    bool isValid() const;
    double width() const;
    double height() const;
    void setWidth(double);
    void setHeight(double);
    void transpose();
    QwtDoubleSize expandedTo(const QwtDoubleSize&) const;
    QwtDoubleSize boundedTo(const QwtDoubleSize&) const;
    bool operator==(const QwtDoubleSize&) const;
    bool operator!=(const QwtDoubleSize&) const;
    const QwtDoubleSize operator+(const QwtDoubleSize&) const;
    const QwtDoubleSize operator-(const QwtDoubleSize&) const;
    const QwtDoubleSize operator*(double) const;
    const QwtDoubleSize operator/(double) const;
    QwtDoubleSize& __iadd__(const QwtDoubleSize&);
    QwtDoubleSize& __isub__(const QwtDoubleSize&);
    QwtDoubleSize& __imul__(double);
    QwtDoubleSize& __idiv__(double);
}; // class QwtDoubleSize
%End // (Qwt_5_0_0 - Qwt_5_1_0)

%If (Qwt_5_1_0 - )
class QwtDoublePoint
{
%TypeHeaderCode
#include <qwt_double_rect.h>
%End // %TypeHeaderCode

public:
    QwtDoublePoint();
    QwtDoublePoint(double, double);
    QwtDoublePoint(const QPoint&);
    QPoint toPoint() const;
    bool isNull() const;
    double x() const;
    double y() const;
    double rx();
    double ry();
    void setX(double);
    void setY(double);
    bool operator==(const QwtDoublePoint&) const;
    bool operator!=(const QwtDoublePoint&) const;
    const QwtDoublePoint __neg__() const;
    const QwtDoublePoint operator+(const QwtDoublePoint&) const;
    const QwtDoublePoint operator-(const QwtDoublePoint&) const;
    const QwtDoublePoint operator*(double) const;
    const QwtDoublePoint operator/(double) const;
    QwtDoublePoint& __iadd__(const QwtDoublePoint&);
    QwtDoublePoint& __isub__(const QwtDoublePoint&);
    QwtDoublePoint& __imul__(double);
    QwtDoublePoint& __idiv__(double);
}; // class QwtDoublePoint


class QwtDoubleRect
{
%TypeHeaderCode
#include <qwt_double_rect.h>
%End // %TypeHeaderCode

public:
    QwtDoubleRect();
    QwtDoubleRect(double, double, double, double);
    QwtDoubleRect(const QwtDoublePoint&, const QwtDoubleSize&);
    QwtDoubleRect(const QRect&);
    QRect toRect() const;
    bool isNull() const;
    bool isEmpty() const;
    bool isValid() const;
    QwtDoubleRect normalized() const;
    double x() const;
    double y() const;
    double left() const;
    double right() const;
    double top() const;
    double bottom() const;
    void setX(double);
    void setY(double);
    void setLeft(double);
    void setRight(double);
    void setTop(double);
    void setBottom(double);
    QwtDoublePoint center() const;
    void moveLeft(double);
    void moveRight(double);
    void moveTop(double);
    void moveBottom(double);
    void moveTo(double, double);
    void moveTo(const QwtDoublePoint&);
    void moveBy(double, double);
    void moveCenter(const QwtDoublePoint&);
    void moveCenter(double, double);
    void setRect(double, double, double, double);
    double width() const;
    double height() const;
    QwtDoubleSize size() const;
    void setWidth(double);
    void setHeight(double);
    void setSize(const QwtDoubleSize&);
    QwtDoubleRect operator|(const QwtDoubleRect&) const;
    QwtDoubleRect operator&(const QwtDoubleRect&) const;
    QwtDoubleRect& __ior__(const QwtDoubleRect&);
    QwtDoubleRect& __iand__(const QwtDoubleRect&);
    bool operator==(const QwtDoubleRect&) const;
    bool operator!=(const QwtDoubleRect&) const;
    bool contains(const QwtDoublePoint&, bool = false) const;
    bool contains(double, double, bool = false) const;
    bool contains(const QwtDoubleRect&, bool = false) const;
    QwtDoubleRect unite(const QwtDoubleRect&) const;
    QwtDoubleRect intersect(const QwtDoubleRect&) const;
    bool intersects(const QwtDoubleRect&) const;
    QwtDoublePoint bottomRight() const;
    QwtDoublePoint topRight() const;
    QwtDoublePoint topLeft() const;
    QwtDoublePoint bottomLeft() const;
}; // class QwtDoubleRect


class QwtDoubleSize
{
%TypeHeaderCode
#include <qwt_double_rect.h>
%End // %TypeHeaderCode

public:
    QwtDoubleSize();
    QwtDoubleSize(double, double);
    QwtDoubleSize(const QSize&);
    bool isNull() const;
    bool isEmpty() const;
    bool isValid() const;
    double width() const;
    double height() const;
    void setWidth(double);
    void setHeight(double);
    void transpose();
    QwtDoubleSize expandedTo(const QwtDoubleSize&) const;
    QwtDoubleSize boundedTo(const QwtDoubleSize&) const;
    bool operator==(const QwtDoubleSize&) const;
    bool operator!=(const QwtDoubleSize&) const;
    const QwtDoubleSize operator+(const QwtDoubleSize&) const;
    const QwtDoubleSize operator-(const QwtDoubleSize&) const;
    const QwtDoubleSize operator*(double) const;
    const QwtDoubleSize operator/(double) const;
    QwtDoubleSize& __iadd__(const QwtDoubleSize&);
    QwtDoubleSize& __isub__(const QwtDoubleSize&);
    QwtDoubleSize& __imul__(double);
    QwtDoubleSize& __idiv__(double);
}; // class QwtDoubleSize
%End // (Qwt_5_1_0 - )


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
