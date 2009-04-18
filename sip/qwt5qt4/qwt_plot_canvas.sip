// The SIP interface specification for:
//      QwtPlotCanvas.
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
class QwtPlotCanvas: QFrame
{
%TypeHeaderCode
#include <qwt_plot_canvas.h>
%End // %TypeHeaderCode

public:
    enum PaintAttribute {
        PaintCached,
        PaintPacked
    }; // enum PaintAttribute

    enum FocusIndicator {
        NoFocusIndicator,
        CanvasFocusIndicator,
        ItemFocusIndicator
    }; // enum FocusIndicator

    void setFocusIndicator(QwtPlotCanvas::FocusIndicator);
    QwtPlotCanvas::FocusIndicator focusIndicator() const;
    void setPaintAttribute(QwtPlotCanvas::PaintAttribute, bool = true);
    bool testPaintAttribute(QwtPlotCanvas::PaintAttribute) const;
    QPixmap* paintCache();
    // signature: const QPixmap* paintCache() const;
    void invalidatePaintCache();
protected:
    QwtPlotCanvas(QwtPlot* /TransferThis/);
    virtual ~QwtPlotCanvas();
    virtual void hideEvent(QHideEvent*);
    virtual void paintEvent(QPaintEvent*);
    virtual void drawContents(QPainter*);
    virtual void drawFocusIndicator(QPainter*);
    void drawCanvas(QPainter* = 0);
}; // class QwtPlotCanvas
%End // (Qwt_5_0_0 - Qwt_5_1_0)

%If (Qwt_5_1_0 - Qwt_5_2_0)
class QwtPlotCanvas: QFrame
{
%TypeHeaderCode
#include <qwt_plot_canvas.h>
%End // %TypeHeaderCode

public:
    enum PaintAttribute {
        PaintCached,
        PaintPacked
    }; // enum PaintAttribute

    enum FocusIndicator {
        NoFocusIndicator,
        CanvasFocusIndicator,
        ItemFocusIndicator
    }; // enum FocusIndicator

    QwtPlotCanvas(QwtPlot* /TransferThis/);
    virtual ~QwtPlotCanvas();
    QwtPlot* plot();
    // signature: const QwtPlot* plot() const;
    void setFocusIndicator(QwtPlotCanvas::FocusIndicator);
    QwtPlotCanvas::FocusIndicator focusIndicator() const;
    void setPaintAttribute(QwtPlotCanvas::PaintAttribute, bool = true);
    bool testPaintAttribute(QwtPlotCanvas::PaintAttribute) const;
    QPixmap* paintCache();
    // signature: const QPixmap* paintCache() const;
    void invalidatePaintCache();
protected:
    virtual void hideEvent(QHideEvent*);
    virtual void paintEvent(QPaintEvent*);
    virtual void drawContents(QPainter*);
    virtual void drawFocusIndicator(QPainter*);
    void drawCanvas(QPainter* = 0);
}; // class QwtPlotCanvas
%End // (Qwt_5_1_0 - Qwt_5_2_0)

%If (Qwt_5_2_0 - )
class QwtPlotCanvas: QFrame
{
%TypeHeaderCode
#include <qwt_plot_canvas.h>
%End // %TypeHeaderCode

public:
    enum PaintAttribute {
        PaintCached,
        PaintPacked
    }; // enum PaintAttribute

    enum FocusIndicator {
        NoFocusIndicator,
        CanvasFocusIndicator,
        ItemFocusIndicator
    }; // enum FocusIndicator

    QwtPlotCanvas(QwtPlot* /TransferThis/);
    virtual ~QwtPlotCanvas();
    QwtPlot* plot();
    // signature: const QwtPlot* plot() const;
    void setFocusIndicator(QwtPlotCanvas::FocusIndicator);
    QwtPlotCanvas::FocusIndicator focusIndicator() const;
    void setPaintAttribute(QwtPlotCanvas::PaintAttribute, bool = true);
    bool testPaintAttribute(QwtPlotCanvas::PaintAttribute) const;
    QPixmap* paintCache();
    // signature: const QPixmap* paintCache() const;
    void invalidatePaintCache();
    void replot();
protected:
    virtual void hideEvent(QHideEvent*);
    virtual void paintEvent(QPaintEvent*);
    virtual void drawContents(QPainter*);
    virtual void drawFocusIndicator(QPainter*);
    void drawCanvas(QPainter* = 0);
}; // class QwtPlotCanvas
%End // (Qwt_5_2_0 - )


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
