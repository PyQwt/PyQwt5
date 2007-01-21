// The SIP interface specification for:
//      QwtSlider.
//
// Copyright (C) 2001-2007 Gerard Vermeulen
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

%If (HAS_QWT4)
%ConvertToSubClassCode
    static struct class_graph {
        char *name;
        sipWrapperType **type;
        int yes, no;
    } graph[] = {
        {sipName_QwtArrowButton, &sipClass_QwtArrowButton, -1, 1},
        {sipName_QwtLegend, &sipClass_QwtLegend, -1, 2},
        {sipName_QwtPicker, &sipClass_QwtPicker, 12, 3},
        {sipName_QwtDynGridLayout, &sipClass_QwtDynGridLayout, -1, 4},
        {sipName_QwtPlot, &sipClass_QwtPlot, -1, 5},
        {sipName_QwtThermo, &sipClass_QwtThermo, -1, 6},
        {sipName_QwtPushButton, &sipClass_QwtPushButton, 14, 7},
        {sipName_QwtSliderBase, &sipClass_QwtSliderBase, 15, 8},
        {sipName_QwtPlotCanvas, &sipClass_QwtPlotCanvas, -1, 9},
        {sipName_QwtScale, &sipClass_QwtScale, -1, 10},
        {sipName_QwtCounter, &sipClass_QwtCounter, -1, 11},
        {sipName_QwtLegendLabel, &sipClass_QwtLegendLabel, -1, -1},
        {sipName_QwtPlotPicker, &sipClass_QwtPlotPicker, 13, -1},
        {sipName_QwtPlotZoomer, &sipClass_QwtPlotZoomer, -1, -1},
        {sipName_QwtLegendButton, &sipClass_QwtLegendButton, -1, -1},
        {sipName_QwtWheel, &sipClass_QwtWheel, -1, 16},
        {sipName_QwtDial, &sipClass_QwtDial, 19, 17},
        {sipName_QwtKnob, &sipClass_QwtKnob, -1, 18},
        {sipName_QwtSlider, &sipClass_QwtSlider, -1, -1},
        {sipName_QwtAnalogClock, &sipClass_QwtAnalogClock, -1, 20},
        {sipName_QwtCompass, &sipClass_QwtCompass, -1, -1},
    };
    int i = 0;
    sipClass = NULL;
    do {
        struct class_graph *cg = &graph[i];
        if (cg->name != NULL && sipCpp->inherits(cg->name)) {
            sipClass = *cg->type;
            i = cg->yes;
        } else {
            i = cg->no;
        }
    } while (i >= 0);
%End // %ConvertToSubClassCode
%End // HAS_QWT4

%If (HAS_QWT5)
%ConvertToSubClassCode
    static struct class_graph {
        char *name;
        sipWrapperType **type;
        int yes, no;
    } graph[] = {
        {sipName_QwtAbstractSlider, &sipClass_QwtAbstractSlider, 12, 1},
        {sipName_QwtPanner, &sipClass_QwtPanner, 18, 2},
        {sipName_QwtLegend, &sipClass_QwtLegend, -1, 3},
        {sipName_QwtCounter, &sipClass_QwtCounter, -1, 4},
        {sipName_QwtPicker, &sipClass_QwtPicker, 19, 5},
        {sipName_QwtScaleWidget, &sipClass_QwtScaleWidget, -1, 6},
        {sipName_QwtPlot, &sipClass_QwtPlot, -1, 7},
        {sipName_QwtThermo, &sipClass_QwtThermo, -1, 8},
        {sipName_QwtDynGridLayout, &sipClass_QwtDynGridLayout, -1, 9},
        {sipName_QwtTextLabel, &sipClass_QwtTextLabel, 21, 10},
        {sipName_QwtPlotCanvas, &sipClass_QwtPlotCanvas, -1, 11},
        {sipName_QwtArrowButton, &sipClass_QwtArrowButton, -1, -1},
        {sipName_QwtDial, &sipClass_QwtDial, 16, 13},
        {sipName_QwtSlider, &sipClass_QwtSlider, -1, 14},
        {sipName_QwtWheel, &sipClass_QwtWheel, -1, 15},
        {sipName_QwtKnob, &sipClass_QwtKnob, -1, -1},
        {sipName_QwtCompass, &sipClass_QwtCompass, -1, 17},
        {sipName_QwtAnalogClock, &sipClass_QwtAnalogClock, -1, -1},
        {sipName_QwtPlotPanner, &sipClass_QwtPlotPanner, -1, -1},
        {sipName_QwtPlotPicker, &sipClass_QwtPlotPicker, 20, -1},
        {sipName_QwtPlotZoomer, &sipClass_QwtPlotZoomer, -1, -1},
        {sipName_QwtLegendItem, &sipClass_QwtLegendItem, -1, -1},
    };
    int i = 0;
    sipClass = NULL;
    do {
        struct class_graph *cg = &graph[i];
        if (cg->name != NULL && sipCpp->inherits(cg->name)) {
            sipClass = *cg->type;
            i = cg->yes;
        } else {
            i = cg->no;
        }
    } while (i >= 0);
%End // %ConvertToSubClassCode
%End // HAS_QWT5

}; // class QwtSlider


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
