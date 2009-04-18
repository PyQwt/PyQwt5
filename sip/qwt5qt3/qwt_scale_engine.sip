// The SIP interface specification for:
//      QwtLinearScaleEngine,
//      QwtLog10ScaleEngine,
//      QwtScaleArithmetic,
//      QwtScaleEngine.
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
class QwtLinearScaleEngine: QwtScaleEngine
{
%TypeHeaderCode
#include <qwt_scale_engine.h>
%End // %TypeHeaderCode

public:
    virtual void autoScale(int, double&, double&, double&) const;
    virtual QwtScaleDiv divideScale(double, double, int, int, double = 0.0) const;
    virtual QwtScaleTransformation* transformation() const;
protected:
    QwtDoubleInterval align(const QwtDoubleInterval&, double) const;
}; // class QwtLinearScaleEngine


class QwtLog10ScaleEngine: QwtScaleEngine
{
%TypeHeaderCode
#include <qwt_scale_engine.h>
%End // %TypeHeaderCode

public:
    virtual void autoScale(int, double&, double&, double&) const;
    virtual QwtScaleDiv divideScale(double, double, int, int, double = 0.0) const;
    virtual QwtScaleTransformation* transformation() const;
protected:
    QwtDoubleInterval log10(const QwtDoubleInterval&) const;
    QwtDoubleInterval pow10(const QwtDoubleInterval&) const;
}; // class QwtLog10ScaleEngine


class QwtScaleArithmetic
{
%TypeHeaderCode
#include <qwt_scale_engine.h>
%End // %TypeHeaderCode

public:
    static int compareEps(double, double, double);
    static double ceilEps(double, double);
    static double floorEps(double, double);
    static double divideEps(double, double);
    static double ceil125(double);
    static double floor125(double);
}; // class QwtScaleArithmetic


class QwtScaleEngine
{
%TypeHeaderCode
#include <qwt_scale_engine.h>
%End // %TypeHeaderCode

public:
    enum Attribute {
        NoAttribute,
        IncludeReference,
        Symmetric,
        Floating,
        Inverted
    }; // enum Attribute

    QwtScaleEngine();
    virtual ~QwtScaleEngine();
    void setAttribute(QwtScaleEngine::Attribute, bool = true);
    bool testAttribute(QwtScaleEngine::Attribute) const;
    void setAttributes(int);
    int attributes() const;
    void setReference(double);
    double reference() const;
    void setMargins(double, double);
    double loMargin() const;
    double hiMargin() const;
    virtual void autoScale(int, double&, double&, double&) const = 0;
    virtual QwtScaleDiv divideScale(double, double, int, int, double = 0.0) const = 0;
    virtual QwtScaleTransformation* transformation() const = 0;
protected:
    bool contains(const QwtDoubleInterval&, double) const;
    QwtValueList strip(const QwtValueList&, const QwtDoubleInterval&) const;
    double divideInterval(double, int) const;
    QwtDoubleInterval buildInterval(double) const;
}; // class QwtScaleEngine
%End // (Qwt_5_0_0 - Qwt_5_2_0)

%If (Qwt_5_2_0 - )
class QwtLinearScaleEngine: QwtScaleEngine
{
%TypeHeaderCode
#include <qwt_scale_engine.h>
%End // %TypeHeaderCode

public:
    virtual void autoScale(int, double&, double&, double&) const;
    virtual QwtScaleDiv divideScale(double, double, int, int, double = 0.0) const;
    virtual QwtScaleTransformation* transformation() const;
protected:
    QwtDoubleInterval align(const QwtDoubleInterval&, double) const;
}; // class QwtLinearScaleEngine


class QwtLog10ScaleEngine: QwtScaleEngine
{
%TypeHeaderCode
#include <qwt_scale_engine.h>
%End // %TypeHeaderCode

public:
    virtual void autoScale(int, double&, double&, double&) const;
    virtual QwtScaleDiv divideScale(double, double, int, int, double = 0.0) const;
    virtual QwtScaleTransformation* transformation() const;
protected:
    QwtDoubleInterval log10(const QwtDoubleInterval&) const;
    QwtDoubleInterval pow10(const QwtDoubleInterval&) const;
}; // class QwtLog10ScaleEngine


class QwtScaleArithmetic
{
%TypeHeaderCode
#include <qwt_scale_engine.h>
%End // %TypeHeaderCode

public:
    static int compareEps(double, double, double);
    static double ceilEps(double, double);
    static double floorEps(double, double);
    static double divideEps(double, double);
    static double ceil125(double);
    static double floor125(double);
}; // class QwtScaleArithmetic


class QwtScaleEngine
{
%TypeHeaderCode
#include <qwt_scale_engine.h>
%End // %TypeHeaderCode

public:
    enum Attribute {
        NoAttribute,
        IncludeReference,
        Symmetric,
        Floating,
        Inverted
    }; // enum Attribute

    QwtScaleEngine();
    virtual ~QwtScaleEngine();
    void setAttribute(QwtScaleEngine::Attribute, bool = true);
    bool testAttribute(QwtScaleEngine::Attribute) const;
    void setAttributes(int);
    int attributes() const;
    void setReference(double);
    double reference() const;
    void setMargins(double, double);
    double lowerMargin() const;
    double upperMargin() const;
    virtual void autoScale(int, double&, double&, double&) const = 0;
    virtual QwtScaleDiv divideScale(double, double, int, int, double = 0.0) const = 0;
    virtual QwtScaleTransformation* transformation() const = 0;
protected:
    bool contains(const QwtDoubleInterval&, double) const;
    QwtValueList strip(const QwtValueList&, const QwtDoubleInterval&) const;
    double divideInterval(double, int) const;
    QwtDoubleInterval buildInterval(double) const;
}; // class QwtScaleEngine
%End // (Qwt_5_2_0 - )


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
