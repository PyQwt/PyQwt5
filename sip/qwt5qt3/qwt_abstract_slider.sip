// The SIP interface specification for:
//      QwtAbstractSlider.
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


class QwtAbstractSlider: QWidget, QwtDoubleRange
{
%TypeHeaderCode
#include <qwt_abstract_slider.h>
%End // %TypeHeaderCode

public:
    enum ScrollMode {
        ScrNone,
        ScrMouse,
        ScrTimer,
        ScrDirect,
        ScrPage
    }; // enum ScrollMode

    QwtAbstractSlider(Qt::Orientation, QWidget* /TransferThis/ = 0);
    virtual ~QwtAbstractSlider();
    void setUpdateTime(int);
    void stopMoving();
    void setTracking(bool);
    virtual void setMass(double);
    virtual double mass() const;
    virtual void setOrientation(Qt::Orientation);
    Qt::Orientation orientation() const;
    bool isReadOnly() const;
    bool isValid() const;
    void setValid(bool);
public slots:
    virtual void setValue(double);
    virtual void fitValue(double);
    virtual void incValue(int);
    virtual void setReadOnly(bool);
signals:
    void valueChanged(double);
    void sliderPressed();
    void sliderReleased();
    void sliderMoved(double);
protected:
    virtual void setPosition(const QPoint&);
    virtual void valueChange();
    virtual void timerEvent(QTimerEvent*);
    virtual void mousePressEvent(QMouseEvent*);
    virtual void mouseReleaseEvent(QMouseEvent*);
    virtual void mouseMoveEvent(QMouseEvent*);
    virtual void keyPressEvent(QKeyEvent*);
    virtual void wheelEvent(QWheelEvent*);
    virtual double getValue(const QPoint&) = 0;
    virtual void getScrollMode(const QPoint&, int&, int&) = 0;
    void setMouseOffset(double);
    double mouseOffset() const;
    int scrollMode() const;

// python mksccode PyQt4.Qwt5
%ConvertToSubClassCode
    static struct class_graph {
        const char *name;
        sipWrapperType **type;
        int yes, no;
    } graph[] = {
        {sipName_QwtAbstractSlider, &sipClass_QwtAbstractSlider, 13, 1},
#if QWT_VERSION >= 0x050100
        {sipName_QwtPanner, &sipClass_QwtPanner, 19, 2},
#else
        {0, 0, 19, 2},
#endif
        {sipName_QwtDynGridLayout, &sipClass_QwtDynGridLayout, -1, 3},
        {sipName_QwtCounter, &sipClass_QwtCounter, -1, 4},
        {sipName_QwtLegend, &sipClass_QwtLegend, -1, 5},
        {sipName_QwtArrowButton, &sipClass_QwtArrowButton, -1, 6},
        {sipName_QwtScaleWidget, &sipClass_QwtScaleWidget, -1, 7},
        {sipName_QwtTextLabel, &sipClass_QwtTextLabel, 20, 8},
        {sipName_QwtPlotCanvas, &sipClass_QwtPlotCanvas, -1, 9},
        {sipName_QwtThermo, &sipClass_QwtThermo, -1, 10},
#if QWT_VERSION >= 0x050100
        {sipName_QwtMagnifier, &sipClass_QwtMagnifier, 21, 11},
#else
        {0, 0, 21, 11},
#endif
        {sipName_QwtPlot, &sipClass_QwtPlot, -1, 12},
        {sipName_QwtPicker, &sipClass_QwtPicker, 22, -1},
        {sipName_QwtDial, &sipClass_QwtDial, 17, 14},
        {sipName_QwtSlider, &sipClass_QwtSlider, -1, 15},
        {sipName_QwtWheel, &sipClass_QwtWheel, -1, 16},
        {sipName_QwtKnob, &sipClass_QwtKnob, -1, -1},
        {sipName_QwtAnalogClock, &sipClass_QwtAnalogClock, -1, 18},
        {sipName_QwtCompass, &sipClass_QwtCompass, -1, -1},
        {sipName_QwtPlotPanner, &sipClass_QwtPlotPanner, -1, -1},
        {sipName_QwtLegendItem, &sipClass_QwtLegendItem, -1, -1},
        {sipName_QwtPlotMagnifier, &sipClass_QwtPlotMagnifier, -1, -1},
        {sipName_QwtPlotPicker, &sipClass_QwtPlotPicker, 23, -1},
        {sipName_QwtPlotZoomer, &sipClass_QwtPlotZoomer, -1, -1},
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
%End

}; // class QwtAbstractSlider


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
