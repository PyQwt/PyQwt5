// The SIP interface specification for:
//      QwtSlider.
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


class QwtSlider: QwtAbstractSlider, QwtAbstractScale
{
%TypeHeaderCode
#include <qwt_slider.h>
%End // %TypeHeaderCode

public:
    enum ScalePos {
        NoScale,
        LeftScale,
        RightScale,
        TopScale,
        BottomScale
    }; // enum ScalePos

    enum BGSTYLE {
        BgTrough,
        BgSlot,
        BgBoth
    }; // enum BGSTYLE

    QwtSlider(QWidget* /TransferThis/, Qt::Orientation = Qt::Horizontal, QwtSlider::ScalePos = NoScale, QwtSlider::BGSTYLE = BgTrough);
    QwtSlider(QWidget* /TransferThis/, const char*);
    virtual ~QwtSlider();
    virtual void setOrientation(Qt::Orientation);
    void setBgStyle(QwtSlider::BGSTYLE);
    QwtSlider::BGSTYLE bgStyle() const;
    void setScalePosition(QwtSlider::ScalePos);
    QwtSlider::ScalePos scalePosition() const;
    int thumbLength() const;
    int thumbWidth() const;
    int borderWidth() const;
    void setThumbLength(int);
    void setThumbWidth(int);
    void setBorderWidth(int);
    void setMargins(int, int);
    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;
    void setScaleDraw(QwtScaleDraw* /Transfer/);
    // signature: const QwtScaleDraw* scaleDraw() const;
protected:
    virtual double getValue(const QPoint&);
    virtual void getScrollMode(const QPoint&, int& /Out/, int& /Out/);
    void draw(QPainter*, const QRect&);
    virtual void drawSlider(QPainter*, const QRect&);
    virtual void drawThumb(QPainter*, const QRect&, int);
    virtual void resizeEvent(QResizeEvent*);
    virtual void paintEvent(QPaintEvent*);
    virtual void valueChange();
    virtual void rangeChange();
    virtual void scaleChange();
    virtual void fontChange(const QFont&);
    void layoutSlider(bool = true);
    int xyPosition(double) const;
    QwtScaleDraw* scaleDraw();
}; // class QwtSlider


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
