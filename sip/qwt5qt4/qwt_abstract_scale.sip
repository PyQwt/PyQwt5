// The SIP interface specification for:
//      QwtAbstractScale.
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


class QwtAbstractScale
{
%TypeHeaderCode
#include <qwt_abstract_scale.h>
%End // %TypeHeaderCode

public:
    QwtAbstractScale();
    virtual ~QwtAbstractScale();
    void setScale(double, double, double = 0.0);
    void setScale(const QwtDoubleInterval&, double = 0.0);
    void setScale(const QwtScaleDiv&);
    void setAutoScale();
    bool autoScale() const;
    void setScaleMaxMajor(int);
    int scaleMaxMinor() const;
    void setScaleMaxMinor(int);
    int scaleMaxMajor() const;
    void setScaleEngine(QwtScaleEngine* /Transfer/);
    // signature: const QwtScaleEngine* scaleEngine() const;
    QwtScaleEngine* scaleEngine();
    const QwtScaleMap& scaleMap() const;
protected:
    void rescale(double, double, double = 0.0);
    void setAbstractScaleDraw(QwtAbstractScaleDraw* /Transfer/);
    // signature: const QwtAbstractScaleDraw* abstractScaleDraw() const;
    QwtAbstractScaleDraw* abstractScaleDraw();
    virtual void scaleChange();
}; // class QwtAbstractScale


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
