// The SIP interface specification for:
//      QwtPlotMarker.
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
class QwtPlotMarker: QwtPlotItem
{
%TypeHeaderCode
#include <qwt_plot_marker.h>
%End // %TypeHeaderCode

public:
    enum LineStyle {
        NoLine,
        HLine,
        VLine,
        Cross
    }; // enum LineStyle

    QwtPlotMarker();
    virtual ~QwtPlotMarker();
    virtual int rtti() const;
    double xValue() const;
    double yValue() const;
    QwtDoublePoint value() const;
    void setXValue(double);
    void setYValue(double);
    void setValue(double, double);
    void setValue(const QwtDoublePoint&);
    void setLineStyle(QwtPlotMarker::LineStyle);
    QwtPlotMarker::LineStyle lineStyle() const;
    void setLinePen(const QPen&);
    const QPen& linePen() const;
    void setSymbol(const QwtSymbol&);
    const QwtSymbol& symbol() const;
    void setLabel(const QwtText&);
    QwtText label() const;
    void setLabelAlignment(Qt::Alignment);
    Qt::Alignment labelAlignment() const;
    virtual void draw(QPainter*, const QwtScaleMap&, const QwtScaleMap&, const QRect&) const;
    virtual QwtDoubleRect boundingRect() const;
}; // class QwtPlotMarker
%End // (Qwt_5_0_0 - Qwt_5_2_0)

%If (Qwt_5_2_0 - )
class QwtPlotMarker: QwtPlotItem
{
%TypeHeaderCode
#include <qwt_plot_marker.h>
%End // %TypeHeaderCode

public:
    enum LineStyle {
        NoLine,
        HLine,
        VLine,
        Cross
    }; // enum LineStyle

    QwtPlotMarker();
    virtual ~QwtPlotMarker();
    virtual int rtti() const;
    double xValue() const;
    double yValue() const;
    QwtDoublePoint value() const;
    void setXValue(double);
    void setYValue(double);
    void setValue(double, double);
    void setValue(const QwtDoublePoint&);
    void setLineStyle(QwtPlotMarker::LineStyle);
    QwtPlotMarker::LineStyle lineStyle() const;
    void setLinePen(const QPen&);
    const QPen& linePen() const;
    void setSymbol(const QwtSymbol&);
    const QwtSymbol& symbol() const;
    void setLabel(const QwtText&);
    QwtText label() const;
    void setLabelAlignment(Qt::Alignment);
    Qt::Alignment labelAlignment() const;
    void setLabelOrientation(Qt::Orientation);
    Qt::Orientation labelOrientation() const;
    void setSpacing(int);
    int spacing() const;
    virtual void draw(QPainter*, const QwtScaleMap&, const QwtScaleMap&, const QRect&) const;
    virtual QwtDoubleRect boundingRect() const;
protected:
    void drawAt(QPainter*, const QRect&, const QPoint&) const;
}; // class QwtPlotMarker
%End // (Qwt_5_2_0 - )


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
