// The SIP interface specification for:
//      QwtWheel.
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


class QwtWheel: QwtAbstractSlider
{
%TypeHeaderCode
#include <qwt_wheel.h>
%End // %TypeHeaderCode

public:
    QwtWheel(QWidget* /TransferThis/ = 0);
    QwtWheel(QWidget*, const char*);
    virtual ~QwtWheel();
    virtual void setOrientation(Qt::Orientation);
    double totalAngle() const;
    double viewAngle() const;
    int tickCnt() const;
    int internalBorder() const;
    virtual double mass() const;
    void setTotalAngle(double);
    void setTickCnt(int);
    void setViewAngle(double);
    void setInternalBorder(int);
    virtual void setMass(double);
    void setWheelWidth(int);
    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;
protected:
    virtual void resizeEvent(QResizeEvent*);
    virtual void paintEvent(QPaintEvent*);
    void layoutWheel(bool = true);
    void draw(QPainter*, const QRect&);
    void drawWheel(QPainter*, const QRect&);
    void drawWheelBackground(QPainter*, const QRect&);
    void setColorArray();
    virtual void valueChange();
    virtual void paletteChange(const QPalette&);
    virtual double getValue(const QPoint&);
    virtual void getScrollMode(const QPoint&, int& /Out/, int& /Out/);
}; // class QwtWheel


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
