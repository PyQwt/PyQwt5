// The SIP interface specification for:
//      QwtPlotGrid.
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


class QwtPlotGrid: QwtPlotItem
{
%TypeHeaderCode
#include <qwt_plot_grid.h>
%End // %TypeHeaderCode

public:
    QwtPlotGrid();
    virtual ~QwtPlotGrid();
    virtual int rtti() const;
    void enableX(bool);
    bool xEnabled() const;
    void enableY(bool);
    bool yEnabled() const;
    void enableXMin(bool);
    bool xMinEnabled() const;
    void enableYMin(bool);
    bool yMinEnabled() const;
    void setXDiv(const QwtScaleDiv&);
    const QwtScaleDiv& xScaleDiv() const;
    void setYDiv(const QwtScaleDiv&);
    const QwtScaleDiv& yScaleDiv() const;
    void setPen(const QPen&);
    void setMajPen(const QPen&);
    const QPen& majPen() const;
    void setMinPen(const QPen&);
    const QPen& minPen() const;
    virtual void draw(QPainter*, const QwtScaleMap&, const QwtScaleMap&, const QRect&) const;
    virtual void updateScaleDiv(const QwtScaleDiv&, const QwtScaleDiv&);
}; // class QwtPlotGrid


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
