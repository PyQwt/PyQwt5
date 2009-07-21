// The SIP interface specification for:
//      QwtScaleMap,
//      QwtScaleTransformation.
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


%If (Qwt_5_0_0 - Qwt_5_0_1)
class QwtScaleMap
{
%TypeHeaderCode
#include <qwt_scale_map.h>
%End // %TypeHeaderCode

public:
    static const double LogMin;
    static const double LogMax;
    QwtScaleMap();
    QwtScaleMap(const QwtScaleMap&);
    ~QwtScaleMap();
    // Not Pythonic: QwtScaleMap& operator=(const QwtScaleMap&);
    void setTransformation(QwtScaleTransformation* /Transfer/);
    const QwtScaleTransformation* transformation() const;
    void setPaintInterval(int, int);
    void setPaintXInterval(double, double);
    void setScaleInterval(double, double);
    int transform(double) const;
    double invTransform(double) const;
    double xTransform(double) const;
    double p1() const;
    double p2() const;
    double s1() const;
    double s2() const;
    double pDist() const;
    double sDist() const;

public:
    QwtScaleMap(int, int, double, double);
%MethodCode
sipCpp = new QwtScaleMap();
sipCpp->setPaintInterval(a0, a1);
sipCpp->setScaleInterval(a2, a3);
%End

}; // class QwtScaleMap


class QwtScaleTransformation
{
%TypeHeaderCode
#include <qwt_scale_map.h>
%End // %TypeHeaderCode

public:
    enum Type {
        Linear,
        Log10,
        Other
    }; // enum Type

    QwtScaleTransformation(QwtScaleTransformation::Type);
    virtual ~QwtScaleTransformation();
    virtual double xForm(double, double, double, double, double) const;
    virtual double invXForm(double, double, double, double, double) const;
    QwtScaleTransformation::Type type() const;
    virtual QwtScaleTransformation* copy() const /Factory/;

private:
    QwtScaleTransformation(const QwtScaleTransformation&);

}; // class QwtScaleTransformation
%End // (Qwt_5_0_0 - Qwt_5_0_1)

%If (Qwt_5_0_1 - )
class QwtScaleMap
{
%TypeHeaderCode
#include <qwt_scale_map.h>
%End // %TypeHeaderCode

public:
    static const double LogMin;
    static const double LogMax;
    QwtScaleMap();
    QwtScaleMap(const QwtScaleMap&);
    ~QwtScaleMap();
    // Not Pythonic: QwtScaleMap& operator=(const QwtScaleMap&);
    void setTransformation(QwtScaleTransformation* /Transfer/);
    const QwtScaleTransformation* transformation() const;
    void setPaintInterval(int, int);
    void setPaintXInterval(double, double);
    void setScaleInterval(double, double);
    int transform(double) const;
    double invTransform(double) const;
    double xTransform(double) const;
    double p1() const;
    double p2() const;
    double s1() const;
    double s2() const;
    double pDist() const;
    double sDist() const;

public:
    QwtScaleMap(int, int, double, double);
%MethodCode
sipCpp = new QwtScaleMap();
sipCpp->setPaintInterval(a0, a1);
sipCpp->setScaleInterval(a2, a3);
%End

}; // class QwtScaleMap


class QwtScaleTransformation
{
%TypeHeaderCode
#include <qwt_scale_map.h>
%End // %TypeHeaderCode

public:
    enum Type {
        Linear,
        Log10,
        Other
    }; // enum Type

    QwtScaleTransformation(QwtScaleTransformation::Type);
    virtual ~QwtScaleTransformation();
    virtual double xForm(double, double, double, double, double) const;
    virtual double invXForm(double, double, double, double, double) const;
    QwtScaleTransformation::Type type() const;
    virtual QwtScaleTransformation* copy() const /Factory/;
private:
    QwtScaleTransformation();

private:
    QwtScaleTransformation(const QwtScaleTransformation&);

}; // class QwtScaleTransformation
%End // (Qwt_5_0_1 - )


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
