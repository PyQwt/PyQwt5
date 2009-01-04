// The SIP interface specification for:
//      QwtKnob.
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


class QwtKnob: QwtAbstractSlider, QwtAbstractScale
{
%TypeHeaderCode
#include <qwt_knob.h>
%End // %TypeHeaderCode

public:
    enum Symbol {
        Line,
        Dot
    }; // enum Symbol

    QwtKnob(QWidget* /TransferThis/ = 0);
    QwtKnob(QWidget*, const char*);
    virtual ~QwtKnob();
    void setKnobWidth(int);
    int knobWidth() const;
    void setTotalAngle(double);
    double totalAngle() const;
    void setBorderWidth(int);
    int borderWidth() const;
    void setSymbol(QwtKnob::Symbol);
    QwtKnob::Symbol symbol() const;
    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;
    void setScaleDraw(QwtRoundScaleDraw* /Transfer/);
    // signature: const QwtRoundScaleDraw* scaleDraw() const;
    QwtRoundScaleDraw* scaleDraw();
protected:
    virtual void paintEvent(QPaintEvent*);
    virtual void resizeEvent(QResizeEvent*);
    void draw(QPainter*, const QRect&);
    void drawKnob(QPainter*, const QRect&);
    void drawMarker(QPainter*, double, const QColor&);
private:
    virtual double getValue(const QPoint&);
    virtual void getScrollMode(const QPoint&, int& /Out/, int& /Out/);
    virtual void valueChange();
    virtual void rangeChange();
    virtual void scaleChange();
    virtual void fontChange(const QFont&);
}; // class QwtKnob


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
