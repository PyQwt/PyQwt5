// The SIP interface specification for:
//      QwtColorMap,
//      QwtContinousColorMap.
//
// Copyright (C) 2001-2006 Gerard Vermeulen
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


class QwtColorMap
{
%TypeHeaderCode
#include <qwt_color_map.h>
%End // %TypeHeaderCode

public:
    enum Format {
        RGB,
        Indexed
    }; // enum Format

    QwtColorMap(QwtColorMap::Format = QwtColorMap::RGB);
    virtual ~QwtColorMap();
    QwtColorMap::Format format() const;
    virtual QwtColorMap* copy() const = 0;
    virtual QRgb rgb(const QwtDoubleInterval&, double) const = 0;
    virtual unsigned char colorIndex(const QwtDoubleInterval&, double) const = 0;
    QColor color(const QwtDoubleInterval&, double) const;
    virtual QValueVector<unsigned int> colorTable(const QwtDoubleInterval&) const;
}; // class QwtColorMap


class QwtContinousColorMap: QwtColorMap
{
%TypeHeaderCode
#include <qwt_color_map.h>
%End // %TypeHeaderCode

public:
    QwtContinousColorMap(QwtColorMap::Format = QwtColorMap::RGB);
    QwtContinousColorMap(const QColor&, const QColor&, QwtColorMap::Format = QwtColorMap::RGB);
    QwtContinousColorMap(const QwtContinousColorMap&);
    virtual ~QwtContinousColorMap();
    // Not Pythonic: QwtContinousColorMap& operator=(const QwtContinousColorMap&);
    virtual QwtContinousColorMap* copy() const;
    void setColorInterval(const QColor&, const QColor&);
    QColor color1() const;
    QColor color2() const;
    virtual QRgb rgb(const QwtDoubleInterval&, double) const;
    virtual unsigned char colorIndex(const QwtDoubleInterval&, double) const;
}; // class QwtContinousColorMap


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
