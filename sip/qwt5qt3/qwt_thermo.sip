// The SIP interface specification for:
//      QwtThermo.
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


class QwtThermo: QWidget, QwtAbstractScale
{
%TypeHeaderCode
#include <qwt_thermo.h>
%End // %TypeHeaderCode

public:
    enum ScalePos {
        NoScale,
        LeftScale,
        RightScale,
        TopScale,
        BottomScale
    }; // enum ScalePos

    QwtThermo(QWidget* /TransferThis/ = 0);
    QwtThermo(QWidget*, const char*);
    virtual ~QwtThermo();
    void setOrientation(Qt::Orientation, QwtThermo::ScalePos);
    void setScalePosition(QwtThermo::ScalePos);
    QwtThermo::ScalePos scalePosition() const;
    void setBorderWidth(int);
    int borderWidth() const;
    void setFillBrush(const QBrush&);
    const QBrush& fillBrush() const;
    void setFillColor(const QColor&);
    const QColor& fillColor() const;
    void setAlarmBrush(const QBrush&);
    const QBrush& alarmBrush() const;
    void setAlarmColor(const QColor&);
    const QColor& alarmColor() const;
    void setAlarmLevel(double);
    double alarmLevel() const;
    void setAlarmEnabled(bool);
    bool alarmEnabled() const;
    void setPipeWidth(int);
    int pipeWidth() const;
    void setMaxValue(double);
    double maxValue() const;
    void setMinValue(double);
    double minValue() const;
    double value() const;
    void setRange(double, double, bool = false);
    void setMargin(int);
    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;
    void setScaleDraw(QwtScaleDraw* /Transfer/);
    // signature: const QwtScaleDraw* scaleDraw() const;
public slots:
    void setValue(double);
protected:
    void draw(QPainter*, const QRect&);
    void drawThermo(QPainter*);
    void layoutThermo(bool = true);
    virtual void scaleChange();
    virtual void fontChange(const QFont&);
    virtual void paintEvent(QPaintEvent*);
    virtual void resizeEvent(QResizeEvent*);
    QwtScaleDraw* scaleDraw();
}; // class QwtThermo


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
