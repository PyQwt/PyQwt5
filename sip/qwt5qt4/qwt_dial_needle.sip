// The SIP interface specification for:
//      QwtCompassMagnetNeedle,
//      QwtCompassWindArrow,
//      QwtDialNeedle,
//      QwtDialSimpleNeedle.
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


class QwtCompassMagnetNeedle: QwtDialNeedle
{
%TypeHeaderCode
#include <qwt_dial_needle.h>
%End // %TypeHeaderCode

public:
    enum Style {
        TriangleStyle,
        ThinStyle
    }; // enum Style

    QwtCompassMagnetNeedle(QwtCompassMagnetNeedle::Style = TriangleStyle, const QColor& = Qt::white, const QColor& = Qt::red);
    virtual void draw(QPainter*, const QPoint&, int, double, QPalette::ColorGroup = QPalette::Active) const;
    static void drawTriangleNeedle(QPainter*, const QPalette&, QPalette::ColorGroup, const QPoint&, int, double);
    static void drawThinNeedle(QPainter*, const QPalette&, QPalette::ColorGroup, const QPoint&, int, double);
protected:
    static void drawPointer(QPainter*, const QBrush&, int, const QPoint&, int, int, double);
}; // class QwtCompassMagnetNeedle


class QwtCompassWindArrow: QwtDialNeedle
{
%TypeHeaderCode
#include <qwt_dial_needle.h>
%End // %TypeHeaderCode

public:
    enum Style {
        Style1,
        Style2
    }; // enum Style

    QwtCompassWindArrow(QwtCompassWindArrow::Style, const QColor& = Qt::white, const QColor& = Qt::gray);
    virtual void draw(QPainter*, const QPoint&, int, double, QPalette::ColorGroup = QPalette::Active) const;
    static void drawStyle1Needle(QPainter*, const QPalette&, QPalette::ColorGroup, const QPoint&, int, double);
    static void drawStyle2Needle(QPainter*, const QPalette&, QPalette::ColorGroup, const QPoint&, int, double);
}; // class QwtCompassWindArrow


class QwtDialNeedle
{
%TypeHeaderCode
#include <qwt_dial_needle.h>
%End // %TypeHeaderCode

public:
    QwtDialNeedle();
    virtual ~QwtDialNeedle();
    virtual void draw(QPainter*, const QPoint&, int, double, QPalette::ColorGroup = QPalette::Active) const = 0;
    virtual void setPalette(const QPalette&);
    const QPalette& palette() const;
protected:
    static void drawKnob(QPainter*, const QPoint&, int, const QBrush&, bool);
}; // class QwtDialNeedle


class QwtDialSimpleNeedle: QwtDialNeedle
{
%TypeHeaderCode
#include <qwt_dial_needle.h>
%End // %TypeHeaderCode

public:
    enum Style {
        Arrow,
        Ray
    }; // enum Style

    QwtDialSimpleNeedle(QwtDialSimpleNeedle::Style, bool = true, const QColor& = Qt::gray, const QColor& = Qt::darkGray);
    virtual void draw(QPainter*, const QPoint&, int, double, QPalette::ColorGroup = QPalette::Active) const;
    static void drawArrowNeedle(QPainter*, const QPalette&, QPalette::ColorGroup, const QPoint&, int, int, double, bool);
    static void drawRayNeedle(QPainter*, const QPalette&, QPalette::ColorGroup, const QPoint&, int, int, double, bool);
    void setWidth(int);
    int width() const;
}; // class QwtDialSimpleNeedle


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
