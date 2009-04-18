// The SIP interface specification for:
//      QwtDial,
//      QwtDialScaleDraw.
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
class QwtDial: QwtAbstractSlider
{
%TypeHeaderCode
#include <qwt_dial.h>
%End // %TypeHeaderCode

public:
    enum Shadow {
        Plain,
        Raised,
        Sunken
    }; // enum Shadow

    enum ScaleOptions {
        ScaleBackbone,
        ScaleTicks,
        ScaleLabel
    }; // enum ScaleOptions

    enum Mode {
        RotateNeedle,
        RotateScale
    }; // enum Mode

    QwtDial(QWidget* /TransferThis/ = 0);
    QwtDial(QWidget*, const char*);
    virtual ~QwtDial();
    void setFrameShadow(QwtDial::Shadow);
    QwtDial::Shadow frameShadow() const;
    bool hasVisibleBackground() const;
    void showBackground(bool);
    void setLineWidth(int);
    int lineWidth() const;
    void setMode(QwtDial::Mode);
    QwtDial::Mode mode() const;
    virtual void setWrapping(bool);
    bool wrapping() const;
    virtual void setScale(int, int, double = 0.0);
    void setScaleArc(double, double);
    void setScaleOptions(int);
    void setScaleTicks(int, int, int, int = 1);
    double minScaleArc() const;
    double maxScaleArc() const;
    virtual void setOrigin(double);
    double origin() const;
    virtual void setNeedle(QwtDialNeedle* /Transfer/);
    // signature: const QwtDialNeedle* needle() const;
    QwtDialNeedle* needle();
    QRect boundingRect() const;
    QRect contentsRect() const;
    virtual QRect scaleContentsRect() const;
    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;
    virtual void setScaleDraw(QwtDialScaleDraw* /Transfer/);
    QwtDialScaleDraw* scaleDraw();
    // signature: const QwtDialScaleDraw* scaleDraw() const;
protected:
    virtual void paintEvent(QPaintEvent*);
    virtual void resizeEvent(QResizeEvent*);
    virtual void keyPressEvent(QKeyEvent*);
    virtual void updateMask();
    virtual void drawFrame(QPainter*);
    virtual void drawContents(QPainter*) const;
    virtual void drawFocusIndicator(QPainter*) const;
    virtual void drawScale(QPainter*, const QPoint&, int, double, double, double) const;
    virtual void drawScaleContents(QPainter*, const QPoint&, int) const;
    virtual void drawNeedle(QPainter*, const QPoint&, int, double, QPalette::ColorGroup) const;
    virtual QwtText scaleLabel(double) const;
    void updateScale();
    virtual void rangeChange();
    virtual void valueChange();
    virtual double getValue(const QPoint&);
    virtual void getScrollMode(const QPoint&, int& /Out/, int& /Out/);
}; // class QwtDial


class QwtDialScaleDraw: QwtRoundScaleDraw
{
%TypeHeaderCode
#include <qwt_dial.h>
%End // %TypeHeaderCode

public:
    QwtDialScaleDraw(QwtDial*);
    virtual QwtText label(double) const;
    void setPenWidth(uint);
    uint penWidth() const;
}; // class QwtDialScaleDraw
%End // (Qwt_5_0_0 - Qwt_5_2_0)

%If (Qwt_5_2_0 - )
class QwtDial: QwtAbstractSlider
{
%TypeHeaderCode
#include <qwt_dial.h>
%End // %TypeHeaderCode

public:
    enum Shadow {
        Plain,
        Raised,
        Sunken
    }; // enum Shadow

    enum ScaleOptions {
        ScaleBackbone,
        ScaleTicks,
        ScaleLabel
    }; // enum ScaleOptions

    enum Mode {
        RotateNeedle,
        RotateScale
    }; // enum Mode

    enum Direction {
        Clockwise,
        CounterClockwise
    }; // enum Direction

    QwtDial(QWidget* /TransferThis/ = 0);
    QwtDial(QWidget*, const char*);
    virtual ~QwtDial();
    void setFrameShadow(QwtDial::Shadow);
    QwtDial::Shadow frameShadow() const;
    bool hasVisibleBackground() const;
    void showBackground(bool);
    void setLineWidth(int);
    int lineWidth() const;
    void setMode(QwtDial::Mode);
    QwtDial::Mode mode() const;
    virtual void setWrapping(bool);
    bool wrapping() const;
    virtual void setScale(int, int, double = 0.0);
    void setScaleArc(double, double);
    void setScaleOptions(int);
    void setScaleTicks(int, int, int, int = 1);
    double minScaleArc() const;
    double maxScaleArc() const;
    virtual void setOrigin(double);
    double origin() const;
    void setDirection(QwtDial::Direction);
    QwtDial::Direction direction() const;
    virtual void setNeedle(QwtDialNeedle* /Transfer/);
    // signature: const QwtDialNeedle* needle() const;
    QwtDialNeedle* needle();
    QRect boundingRect() const;
    QRect contentsRect() const;
    virtual QRect scaleContentsRect() const;
    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;
    virtual void setScaleDraw(QwtDialScaleDraw* /Transfer/);
    QwtDialScaleDraw* scaleDraw();
    // signature: const QwtDialScaleDraw* scaleDraw() const;
protected:
    virtual void paintEvent(QPaintEvent*);
    virtual void resizeEvent(QResizeEvent*);
    virtual void keyPressEvent(QKeyEvent*);
    virtual void updateMask();
    virtual void drawFrame(QPainter*);
    virtual void drawContents(QPainter*) const;
    virtual void drawFocusIndicator(QPainter*) const;
    virtual void drawScale(QPainter*, const QPoint&, int, double, double, double) const;
    virtual void drawScaleContents(QPainter*, const QPoint&, int) const;
    virtual void drawNeedle(QPainter*, const QPoint&, int, double, QPalette::ColorGroup) const;
    virtual QwtText scaleLabel(double) const;
    void updateScale();
    virtual void rangeChange();
    virtual void valueChange();
    virtual double getValue(const QPoint&);
    virtual void getScrollMode(const QPoint&, int& /Out/, int& /Out/);
}; // class QwtDial


class QwtDialScaleDraw: QwtRoundScaleDraw
{
%TypeHeaderCode
#include <qwt_dial.h>
%End // %TypeHeaderCode

public:
    QwtDialScaleDraw(QwtDial*);
    virtual QwtText label(double) const;
    void setPenWidth(uint);
    uint penWidth() const;
}; // class QwtDialScaleDraw
%End // (Qwt_5_2_0 - )


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
