// The SIP interface specification for:
//      QwtPlotCurve.
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


class QwtPlotCurve: QwtPlotItem
{
%TypeHeaderCode
#include <qwt_plot_curve.h>
%End // %TypeHeaderCode

public:
    enum CurveType {
        Yfx,
        Xfy
    }; // enum CurveType

    enum CurveStyle {
        NoCurve,
        Lines,
        Sticks,
        Steps,
        Dots,
        UserCurve
    }; // enum CurveStyle

    enum CurveAttribute {
        Inverted,
        Fitted
    }; // enum CurveAttribute

    enum PaintAttribute {
        PaintFiltered,
        ClipPolygons
    }; // enum PaintAttribute

    QwtPlotCurve();
    QwtPlotCurve(const QwtText&);
    QwtPlotCurve(const QString&);
    virtual ~QwtPlotCurve();
    virtual int rtti() const;
    void setCurveType(QwtPlotCurve::CurveType);
    QwtPlotCurve::CurveType curveType() const;
    void setPaintAttribute(QwtPlotCurve::PaintAttribute, bool = true);
    bool testPaintAttribute(QwtPlotCurve::PaintAttribute) const;
    // Not Pythonic: void setRawData(const double*, const double*, int);
    void setData(SIP_PYOBJECT, SIP_PYOBJECT);
%MethodCode
QwtArray<double> xArray;
if (-1 == try_PyObject_to_QwtArray(a0, xArray))
    return 0;

QwtArray<double> yArray;
if (-1 == try_PyObject_to_QwtArray(a1, yArray))
    return 0;

sipCpp->QwtPlotCurve::setData(xArray, yArray);
%End

    void setData(const QwtArrayDouble&, const QwtArrayDouble&);
    void setData(const QwtArrayQwtDoublePoint&);
    void setData(const QwtData&);
    int closestPoint(const QPoint&, double* = 0) const;
    QwtData& data();
    // signature: const QwtData& data() const;
    int dataSize() const;
    double x(int) const;
    double y(int) const;
    virtual QwtDoubleRect boundingRect() const;
    double minXValue() const;
    double maxXValue() const;
    double minYValue() const;
    double maxYValue() const;
    void setCurveAttribute(QwtPlotCurve::CurveAttribute, bool = true);
    bool testCurveAttribute(QwtPlotCurve::CurveAttribute) const;
    void setPen(const QPen&);
    const QPen& pen() const;
    void setBrush(const QBrush&);
    const QBrush& brush() const;
    void setBaseline(double);
    double baseline() const;
    void setStyle(QwtPlotCurve::CurveStyle);
    QwtPlotCurve::CurveStyle style() const;
    void setSymbol(const QwtSymbol&);
    const QwtSymbol& symbol() const;
    void setCurveFitter(QwtCurveFitter* /Transfer/);
    QwtCurveFitter* curveFitter() const;
    virtual void draw(QPainter*, const QwtScaleMap&, const QwtScaleMap&, const QRect&) const;
    virtual void draw(QPainter*, const QwtScaleMap&, const QwtScaleMap&, int, int) const /PyName=drawFromTo/;
    void draw(int, int) const;
    virtual void updateLegend(QwtLegend*) const;
protected:
    void init();
    virtual void drawCurve(QPainter*, int, const QwtScaleMap&, const QwtScaleMap&, int, int) const;
    virtual void drawSymbols(QPainter*, const QwtSymbol&, const QwtScaleMap&, const QwtScaleMap&, int, int) const;
    void drawLines(QPainter*, const QwtScaleMap&, const QwtScaleMap&, int, int) const;
    void drawSticks(QPainter*, const QwtScaleMap&, const QwtScaleMap&, int, int) const;
    void drawDots(QPainter*, const QwtScaleMap&, const QwtScaleMap&, int, int) const;
    void drawSteps(QPainter*, const QwtScaleMap&, const QwtScaleMap&, int, int) const;
    void fillCurve(QPainter*, const QwtScaleMap&, const QwtScaleMap&, QwtPolygon&) const;
    void closePolyline(const QwtScaleMap&, const QwtScaleMap&, QwtPolygon&) const;
}; // class QwtPlotCurve


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
