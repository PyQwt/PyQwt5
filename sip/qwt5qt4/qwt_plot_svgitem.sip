// The SIP interface specification for:
//      QwtPlotSvgItem.
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


class QwtPlotSvgItem: QwtPlotItem
{
%TypeHeaderCode
#include <qwt_plot_svgitem.h>
%End // %TypeHeaderCode

public:
    QwtPlotSvgItem(const QString& = QString::null);
    QwtPlotSvgItem(const QwtText&);
    virtual ~QwtPlotSvgItem();
    bool loadFile(const QwtDoubleRect&, const QString&);
    bool loadData(const QwtDoubleRect&, const QByteArray&);
    virtual QwtDoubleRect boundingRect() const;
    virtual void draw(QPainter*, const QwtScaleMap&, const QwtScaleMap&, const QRect&) const;
    virtual int rtti() const;
protected:
    // signature: const QSvgRenderer& renderer() const;
    QSvgRenderer& renderer();
    void render(QPainter*, const QwtDoubleRect&, const QRect&) const;
    QwtDoubleRect viewBox(const QwtDoubleRect&) const;
}; // class QwtPlotSvgItem


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
