// The SIP interface specification for:
//      QwtAbstractScaleDraw.
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


class QwtAbstractScaleDraw
{
%TypeHeaderCode
#include <qwt_abstract_scale_draw.h>
%End // %TypeHeaderCode

public:
    enum ScaleComponent {
        Backbone,
        Ticks,
        Labels
    }; // enum ScaleComponent

    QwtAbstractScaleDraw();
    QwtAbstractScaleDraw(const QwtAbstractScaleDraw&);
    virtual ~QwtAbstractScaleDraw();
    // Not Pythonic: QwtAbstractScaleDraw& operator=(const QwtAbstractScaleDraw&);
    void setScaleDiv(const QwtScaleDiv&);
    const QwtScaleDiv& scaleDiv() const;
    void setTransformation(QwtScaleTransformation*);
    const QwtScaleMap& map() const;
    void enableComponent(QwtAbstractScaleDraw::ScaleComponent, bool = true);
    bool hasComponent(QwtAbstractScaleDraw::ScaleComponent) const;
    void setTickLength(QwtScaleDiv::TickType, int);
    int tickLength(QwtScaleDiv::TickType) const;
    int majTickLength() const;
    void setSpacing(int);
    int spacing() const;
    virtual void draw(QPainter*, const QColorGroup&) const;
    virtual QwtText label(double) const;
    virtual int extent(const QPen&, const QFont&) const = 0;
    void setMinimumExtent(int);
    int minimumExtent() const;
    QwtScaleMap& scaleMap();
protected:
    virtual void drawTick(QPainter*, double, int) const = 0;
    virtual void drawBackbone(QPainter*) const = 0;
    virtual void drawLabel(QPainter*, double) const = 0;
    void invalidateCache();
    const QwtText& tickLabel(const QFont&, double) const;
}; // class QwtAbstractScaleDraw


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
