// The SIP interface specification for:
//      QwtPlotMagnifier.
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


%If (Qwt_5_0_0 - Qwt_5_1_0)
class QwtPlotMagnifier: QObject
{
%TypeHeaderCode
#include <qwt_plot_magnifier.h>
%End // %TypeHeaderCode

public:
    QwtPlotMagnifier(QwtPlotCanvas* /TransferThis/);
    virtual ~QwtPlotMagnifier();
    void setEnabled(bool);
    bool isEnabled() const;
    void setAxisEnabled(int, bool);
    bool isAxisEnabled(int) const;
    void setMouseFactor(double);
    double mouseFactor() const;
    void setMouseButton(int, int = Qt::NoButton);
    void getMouseButton(int&, int&) const;
    void setWheelFactor(double);
    double wheelFactor() const;
    void setWheelButtonState(int);
    int wheelButtonState() const;
    void setKeyFactor(double);
    double keyFactor() const;
    void setZoomInKey(int, int);
    void getZoomInKey(int&, int&);
    void setZoomOutKey(int, int);
    void getZoomOutKey(int&, int&);
    QwtPlotCanvas* canvas();
    // signature: const QwtPlotCanvas* canvas() const;
    QwtPlot* plot();
    // signature: const QwtPlot* plot() const;
    virtual bool eventFilter(QObject*, QEvent*);
protected:
    virtual void rescale(double);
    virtual void widgetMousePressEvent(QMouseEvent*);
    virtual void widgetMouseReleaseEvent(QMouseEvent*);
    virtual void widgetMouseMoveEvent(QMouseEvent*);
    virtual void widgetWheelEvent(QWheelEvent*);
    virtual void widgetKeyPressEvent(QKeyEvent*);
    virtual void widgetKeyReleaseEvent(QKeyEvent*);
}; // class QwtPlotMagnifier
%End // (Qwt_5_0_0 - Qwt_5_1_0)

%If (Qwt_5_1_0 - )
class QwtPlotMagnifier: QwtMagnifier
{
%TypeHeaderCode
#include <qwt_plot_magnifier.h>
%End // %TypeHeaderCode

public:
    QwtPlotMagnifier(QwtPlotCanvas* /TransferThis/);
    virtual ~QwtPlotMagnifier();
    void setAxisEnabled(int, bool);
    bool isAxisEnabled(int) const;
    QwtPlotCanvas* canvas();
    // signature: const QwtPlotCanvas* canvas() const;
    QwtPlot* plot();
    // signature: const QwtPlot* plot() const;
protected:
    virtual void rescale(double);
}; // class QwtPlotMagnifier
%End // (Qwt_5_1_0 - )


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
