// The SIP interface specification for:
//      QwtPlotZoomer.
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
class QwtPlotZoomer: QwtPlotPicker
{
%TypeHeaderCode
#include <qwt_plot_zoomer.h>
%End // %TypeHeaderCode

public:
    QwtPlotZoomer(QwtPlotCanvas* /TransferThis/, bool = true);
    QwtPlotZoomer(int, int, QwtPlotCanvas* /TransferThis/, bool = true);
    QwtPlotZoomer(int, int, int, QwtPicker::DisplayMode, QwtPlotCanvas* /TransferThis/, bool = true);
    virtual ~QwtPlotZoomer();
    virtual void setZoomBase();
    virtual void setZoomBase(const QwtDoubleRect&);
    QwtDoubleRect zoomBase() const;
    QwtDoubleRect zoomRect() const;
    virtual void setAxis(int, int);
    void setMaxStackDepth(int);
    int maxStackDepth() const;
    const QValueStack<QwtDoubleRect>& zoomStack() const;
    uint zoomRectIndex() const;
    virtual void setSelectionFlags(int);
public slots:
    void moveBy(double, double);
    virtual void move(double, double);
    virtual void zoom(const QwtDoubleRect&);
    virtual void zoom(int);
signals:
    void zoomed(const QwtDoubleRect&);
protected:
    virtual void rescale();
    virtual QwtDoubleSize minZoomSize() const;
    virtual void widgetMouseReleaseEvent(QMouseEvent*);
    virtual void widgetKeyPressEvent(QKeyEvent*);
    virtual void begin();
    virtual bool end(bool = true);
    virtual bool accept(QwtPolygon&) const;
}; // class QwtPlotZoomer
%End // (Qwt_5_0_0 - Qwt_5_1_0)

%If (Qwt_5_1_0 - )
class QwtPlotZoomer: QwtPlotPicker
{
%TypeHeaderCode
#include <qwt_plot_zoomer.h>
%End // %TypeHeaderCode

public:
    QwtPlotZoomer(QwtPlotCanvas* /TransferThis/, bool = true);
    QwtPlotZoomer(int, int, QwtPlotCanvas* /TransferThis/, bool = true);
    QwtPlotZoomer(int, int, int, QwtPicker::DisplayMode, QwtPlotCanvas* /TransferThis/, bool = true);
    virtual ~QwtPlotZoomer();
    virtual void setZoomBase(bool = true);
    virtual void setZoomBase(const QwtDoubleRect&);
    QwtDoubleRect zoomBase() const;
    QwtDoubleRect zoomRect() const;
    virtual void setAxis(int, int);
    void setMaxStackDepth(int);
    int maxStackDepth() const;
    const QValueStack<QwtDoubleRect>& zoomStack() const;
    void setZoomStack(const QValueStack<QwtDoubleRect>&, int = -1);
    uint zoomRectIndex() const;
    virtual void setSelectionFlags(int);
public slots:
    void moveBy(double, double);
    virtual void move(double, double);
    virtual void zoom(const QwtDoubleRect&);
    virtual void zoom(int);
signals:
    void zoomed(const QwtDoubleRect&);
protected:
    virtual void rescale();
    virtual QwtDoubleSize minZoomSize() const;
    virtual void widgetMouseReleaseEvent(QMouseEvent*);
    virtual void widgetKeyPressEvent(QKeyEvent*);
    virtual void begin();
    virtual bool end(bool = true);
    virtual bool accept(QwtPolygon&) const;
}; // class QwtPlotZoomer
%End // (Qwt_5_1_0 - )


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
