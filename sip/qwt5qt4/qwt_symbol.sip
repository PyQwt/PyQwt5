// The SIP interface specification for:
//      QwtSymbol.
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
class QwtSymbol
{
%TypeHeaderCode
#include <qwt_symbol.h>
%End // %TypeHeaderCode

public:
    enum Style {
        NoSymbol,
        Ellipse,
        Rect,
        Diamond,
        Triangle,
        DTriangle,
        UTriangle,
        LTriangle,
        RTriangle,
        Cross,
        XCross,
        HLine,
        VLine,
        Star1,
        Star2,
        Hexagon,
        StyleCnt
    }; // enum Style

    QwtSymbol();
    QwtSymbol(QwtSymbol::Style, const QBrush&, const QPen&, const QSize&);
    virtual ~QwtSymbol();
    bool operator!=(const QwtSymbol&) const;
    bool operator==(const QwtSymbol&) const;
    void setSize(const QSize&);
    void setSize(int, int = -1);
    void setBrush(const QBrush&);
    void setPen(const QPen&);
    void setStyle(QwtSymbol::Style);
    const QBrush& brush() const;
    const QPen& pen() const;
    const QSize& size() const;
    QwtSymbol::Style style() const;
    void draw(QPainter*, const QPoint&) const;
    void draw(QPainter*, int, int) const;
    virtual void draw(QPainter*, const QRect&) const;
}; // class QwtSymbol
%End // (Qwt_5_0_0 - Qwt_5_1_0)

%If (Qwt_5_1_0 - )
class QwtSymbol
{
%TypeHeaderCode
#include <qwt_symbol.h>
%End // %TypeHeaderCode

public:
    enum Style {
        NoSymbol,
        Ellipse,
        Rect,
        Diamond,
        Triangle,
        DTriangle,
        UTriangle,
        LTriangle,
        RTriangle,
        Cross,
        XCross,
        HLine,
        VLine,
        Star1,
        Star2,
        Hexagon,
        StyleCnt
    }; // enum Style

    QwtSymbol();
    QwtSymbol(QwtSymbol::Style, const QBrush&, const QPen&, const QSize&);
    virtual ~QwtSymbol();
    bool operator!=(const QwtSymbol&) const;
    virtual bool operator==(const QwtSymbol&) const;
    virtual QwtSymbol* clone() const /Factory/;
    void setSize(const QSize&);
    void setSize(int, int = -1);
    void setBrush(const QBrush&);
    void setPen(const QPen&);
    void setStyle(QwtSymbol::Style);
    const QBrush& brush() const;
    const QPen& pen() const;
    const QSize& size() const;
    QwtSymbol::Style style() const;
    void draw(QPainter*, const QPoint&) const;
    void draw(QPainter*, int, int) const;
    virtual void draw(QPainter*, const QRect&) const;
}; // class QwtSymbol
%End // (Qwt_5_1_0 - )


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
