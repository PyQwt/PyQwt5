// The SIP interface specification for:
//      QwtScaleMap,
//      QwtScaleTransformation.
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


class QwtScaleMap
{
%TypeHeaderCode
#include <qwt_scale_map.h>
%End // %TypeHeaderCode

public:
    static const double LogMin;
    static const double LogMax;
    QwtScaleMap();
    QwtScaleMap(int, int, double, double);
    ~QwtScaleMap();
    void setTransformation(bool);
    void setTransformation(const QwtScaleTransformation&);
    const QwtScaleTransformation& transformation() const;
    void setPaintInterval(int, int);
    void setPaintXInterval(double, double);
    void setScaleInterval(double, double);
    // FIXME: void setTransformationData(void*);
    // FIXME: void* transformationData() const;
    int transform(double) const;
    double invTransform(double) const;
    double xTransform(double) const;
    double p1() const;
    double p2() const;
    double s1() const;
    double s2() const;
    double pDist() const;
    double sDist() const;
}; // class QwtScaleMap


class QwtScaleTransformation
{
%TypeHeaderCode
#include <qwt_scale_map.h>
%End // %TypeHeaderCode

public:
    // FIXME: double (*)(double, double, double, double, double, void*) xForm;
    // FIXME: double (*)(double, double, double, double, double, void*) invXForm;
    QwtScaleTransformation();
    // FIXME: QwtScaleTransformation(double (*)(double, double, double, double, double, void*), double (*)(double, double, double, double, double, void*));
    // FIXME: static double linearXForm(double, double, double, double, double, void*);
    // FIXME: static double log10XForm(double, double, double, double, double, void*);
    // FIXME: static double log10InvXForm(double, double, double, double, double, void*);
}; // class QwtScaleTransformation


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
