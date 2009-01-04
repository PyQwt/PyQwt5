// The SIP interface specification for:
//      QwtRasterData.
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


class QwtRasterData
{
%TypeHeaderCode
#include <qwt_raster_data.h>
%End // %TypeHeaderCode

public:
    enum ConrecAttribute {
        IgnoreAllVerticesOnLevel,
        IgnoreOutOfRange
    }; // enum ConrecAttribute

    QwtRasterData();
    QwtRasterData(const QwtDoubleRect&);
    virtual ~QwtRasterData();
    virtual QwtRasterData* copy() const = 0 /Factory/;
    virtual void setBoundingRect(const QwtDoubleRect&);
    QwtDoubleRect boundingRect() const;
    virtual QSize rasterHint(const QwtDoubleRect&) const;
    virtual void initRaster(const QwtDoubleRect&, const QSize&);
    virtual void discardRaster();
    virtual double value(double, double) const = 0;
    virtual QwtDoubleInterval range() const = 0;
    // FIXME: virtual QMap<double,QPolygonF> contourLines(const QwtDoubleRect&, const QSize&, const QList<double>&, int) const;
}; // class QwtRasterData


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
