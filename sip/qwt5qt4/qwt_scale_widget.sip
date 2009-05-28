// The SIP interface specification for:
//      QwtScaleWidget.
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


class QwtScaleWidget: QWidget
{
%TypeHeaderCode
#include <qwt_scale_widget.h>
%End // %TypeHeaderCode

public:
    QwtScaleWidget(QWidget* = 0);
    QwtScaleWidget(QwtScaleDraw::Alignment, QWidget* /TransferThis/ = 0);
    virtual ~QwtScaleWidget();
signals:
    void scaleDivChanged();
public:
    void setTitle(const QString&);
    void setTitle(const QwtText&);
    QwtText title() const;
    void setBorderDist(int, int);
    int startBorderDist() const;
    int endBorderDist() const;
    void getBorderDistHint(int&, int&) const;
    void getMinBorderDist(int& /Out/, int& /Out/) const;
    void setMinBorderDist(int, int);
    void setMargin(int);
    int margin() const;
    void setSpacing(int);
    int spacing() const;
    void setPenWidth(int);
    int penWidth() const;
    void setScaleDiv(QwtScaleTransformation*, const QwtScaleDiv&);
    void setScaleDraw(QwtScaleDraw*);
    // signature: const QwtScaleDraw* scaleDraw() const;
    QwtScaleDraw* scaleDraw();
    void setLabelAlignment(Qt::Alignment);
    void setLabelRotation(double);
    void setColorBarEnabled(bool);
    bool isColorBarEnabled() const;
    void setColorBarWidth(int);
    int colorBarWidth() const;
    void setColorMap(const QwtDoubleInterval&, const QwtColorMap&);
    QwtDoubleInterval colorBarInterval() const;
    const QwtColorMap& colorMap() const;
    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;
    int titleHeightForWidth(int) const;
    int dimForLength(int, const QFont&) const;
    void drawColorBar(QPainter*, const QRect&) const;
    void drawTitle(QPainter*, QwtScaleDraw::Alignment, const QRect&) const;
    void setAlignment(QwtScaleDraw::Alignment);
    QwtScaleDraw::Alignment alignment() const;
    QRect colorBarRect(const QRect&) const;
protected:
    virtual void paintEvent(QPaintEvent*);
    virtual void resizeEvent(QResizeEvent*);
    void draw(QPainter*) const;
    void scaleChange();
    void layoutScale(bool = true);
}; // class QwtScaleWidget


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
