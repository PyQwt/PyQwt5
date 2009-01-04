// The SIP interface specification for:
//      QwtPlotLayout.
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


class QwtPlotLayout
{
%TypeHeaderCode
#include <qwt_plot_layout.h>
%End // %TypeHeaderCode

public:
    enum Options {
        AlignScales,
        IgnoreScrollbars,
        IgnoreFrames,
        IgnoreMargin,
        IgnoreLegend
    }; // enum Options

    QwtPlotLayout();
    virtual ~QwtPlotLayout();
    void setMargin(int);
    int margin() const;
    void setCanvasMargin(int, int = -1);
    int canvasMargin(int) const;
    void setAlignCanvasToScales(bool);
    bool alignCanvasToScales() const;
    void setSpacing(int);
    int spacing() const;
    void setLegendPosition(QwtPlot::LegendPosition, double);
    void setLegendPosition(QwtPlot::LegendPosition);
    QwtPlot::LegendPosition legendPosition() const;
    void setLegendRatio(double);
    double legendRatio() const;
    virtual QSize minimumSizeHint(const QwtPlot*) const;
    virtual void activate(const QwtPlot*, const QRect&, int = 0);
    virtual void invalidate();
    const QRect& titleRect() const;
    const QRect& legendRect() const;
    const QRect& scaleRect(int) const;
    const QRect& canvasRect() const;
protected:
    QRect layoutLegend(int, const QRect&) const;
    QRect alignLegend(const QRect&, const QRect&) const;
    SIP_PYTUPLE expandLineBreaks(int, const QRect&) const [
        void (int, const QRect&, int&, int*)];
%MethodCode
int title, axes[QwtPlot::axisCnt];
sipCpp->sipProtect_expandLineBreaks(a0, *a1, title, axes);
sipRes = Py_BuildValue("i(iiii)", title, axes[0], axes[1], axes[2], axes[3]);
%End

    SIP_PYTUPLE alignScales(int, QRect&) const [
        void (int, QRect&, QRect*)];
%MethodCode
QRect scales[QwtPlot::axisCnt];
sipCpp->sipProtect_alignScales(a0, *a1, scales);
sipRes = sipBuildResult(0, "(BBBB)",
                        new QRect(scales[0]), sipClass_QRect, 0,
                        new QRect(scales[1]), sipClass_QRect, 0,
                        new QRect(scales[2]), sipClass_QRect, 0,
                        new QRect(scales[3]), sipClass_QRect, 0);
%End

}; // class QwtPlotLayout


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
