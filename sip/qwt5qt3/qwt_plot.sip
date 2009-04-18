// The SIP interface specification for:
//      QwtPlot.
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
class QwtPlot: QFrame, QwtPlotDict
{
%TypeHeaderCode
#include <qwt_plot.h>
%End // %TypeHeaderCode

public:
    enum Axis {
        yLeft,
        yRight,
        xBottom,
        xTop,
        axisCnt
    }; // enum Axis

    enum LegendPosition {
        LeftLegend,
        RightLegend,
        BottomLegend,
        TopLegend,
        ExternalLegend
    }; // enum LegendPosition

    QwtPlot(QWidget* /TransferThis/ = 0);
    QwtPlot(const QwtText&, QWidget* /TransferThis/ = 0);
    QwtPlot(QWidget*, const char*);
    virtual ~QwtPlot();
    void applyProperties(const QString&);
    QString grabProperties() const;
    void setAutoReplot(bool = true);
    bool autoReplot() const;
    void print(QPaintDevice&, const QwtPlotPrintFilter& = QwtPlotPrintFilter()) const /PyName=print_/;
    virtual void print(QPainter*, const QRect&, const QwtPlotPrintFilter& = QwtPlotPrintFilter()) const /PyName=print_/;
    QwtPlotLayout* plotLayout();
    // signature: const QwtPlotLayout* plotLayout() const;
    virtual void setMargin(int);
    int margin() const;
    void setTitle(const QString&);
    void setTitle(const QwtText&);
    QwtText title() const;
    QwtTextLabel* titleLabel();
    // signature: const QwtTextLabel* titleLabel() const;
    QwtPlotCanvas* canvas();
    // signature: const QwtPlotCanvas* canvas() const;
    void setCanvasBackground(const QColor&);
    const QColor& canvasBackground() const;
    void setCanvasLineWidth(int);
    int canvasLineWidth() const;
    virtual QwtScaleMap canvasMap(int) const;
    double invTransform(int, int) const;
    int transform(int, double) const;
    QwtScaleEngine* axisScaleEngine(int);
    // signature: const QwtScaleEngine* axisScaleEngine(int) const;
    void setAxisScaleEngine(int, QwtScaleEngine* /Transfer/);
    void setAxisAutoScale(int);
    bool axisAutoScale(int) const;
    void enableAxis(int, bool = true);
    bool axisEnabled(int) const;
    void setAxisFont(int, const QFont&);
    QFont axisFont(int) const;
    void setAxisScale(int, double, double, double = 0);
    void setAxisScaleDiv(int, const QwtScaleDiv&);
    void setAxisScaleDraw(int, QwtScaleDraw* /Transfer/);
    // signature: const QwtScaleDiv* axisScaleDiv(int) const;
    QwtScaleDiv* axisScaleDiv(int);
    // signature: const QwtScaleDraw* axisScaleDraw(int) const;
    QwtScaleDraw* axisScaleDraw(int);
    // signature: const QwtScaleWidget* axisWidget(int) const;
    QwtScaleWidget* axisWidget(int);
    void setAxisLabelAlignment(int, int);
    void setAxisLabelRotation(int, double);
    void setAxisTitle(int, const QString&);
    void setAxisTitle(int, const QwtText&);
    QwtText axisTitle(int) const;
    void setAxisMaxMinor(int, int);
    int axisMaxMajor(int) const;
    void setAxisMaxMajor(int, int);
    int axisMaxMinor(int) const;
    void insertLegend(QwtLegend* /Transfer/, QwtPlot::LegendPosition = QwtPlot::RightLegend, double = -1);
    QwtLegend* legend();
    // signature: const QwtLegend* legend() const;
    virtual void polish();
    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;
    virtual void updateLayout();
    virtual bool event(QEvent*);
signals:
    void legendClicked(QwtPlotItem*);
    void legendChecked(QwtPlotItem*, bool);
public slots:
    void clear();
    virtual void replot();
    void autoRefresh();
protected slots:
    virtual void legendItemClicked();
    virtual void legendItemChecked(bool);
protected:
    static bool axisValid(int);
    virtual void drawCanvas(QPainter*);
    virtual void drawItems(QPainter*, const QRect&, SIP_PYLIST, const QwtPlotPrintFilter&) const [
        void (QPainter*, const QRect&, const QwtScaleMap*, const QwtPlotPrintFilter&)];
%MethodCode
        // PyQwt takes a list with QwtScaleMap objects in the first
        // QwtPlot::axisCnt elements.
        
        QwtScaleMap maps[QwtPlot::axisCnt];

        sipIsErr = QwtPlot::axisCnt > PyList_GET_SIZE(a2);

        if (!sipIsErr) {
            for (int i=0; i<QwtPlot::axisCnt; ++i) {
                void *cpp = sipForceConvertToInstance(
                    PyList_GET_ITEM(a2, i), sipClass_QwtScaleMap,
                    0, SIP_NO_CONVERTORS, 0, &sipIsErr);
                maps[i] = *reinterpret_cast<QwtScaleMap*>(cpp);
            }
        }

        if (!sipIsErr) {
            Py_BEGIN_ALLOW_THREADS
            sipCpp->sipProtectVirt_drawItems(sipSelfWasArg, a0, *a1, maps, *a3);
            Py_END_ALLOW_THREADS
        }
%End

%VirtualCatcherCode
        PyObject *maps = PyList_New(QwtPlot::axisCnt);

        sipIsErr = !maps;

        if (!sipIsErr) {
            for (int i=0; i<QwtPlot::axisCnt; ++i) {
                PyObject *object = sipConvertFromInstance(
                    const_cast<QwtScaleMap*>(&a2[i]), sipClass_QwtScaleMap, 0);
                if (!object) {
                    sipIsErr = true;
                    break;
                }
                PyList_SET_ITEM(maps, i, object);
            }
        }

        if (!sipIsErr) {
            PyObject *result = sipCallMethod(
                &sipIsErr, sipMethod, "CCSC",
                a0, sipClass_QPainter, 0,
                &a1, sipClass_QRect, 0,
                maps,
                &a3, sipClass_QwtPlotPrintFilter, 0);

            if (result)
            {
                sipParseResult(&sipIsErr, sipMethod, result, "Z");
                Py_DECREF(result);
            }
        }

        Py_XDECREF(maps);
%End

    virtual void updateTabOrder();
    void updateAxes();
    virtual void resizeEvent(QResizeEvent*);
    virtual void printLegendItem(QPainter*, const QWidget*, const QRect&) const;
    virtual void printTitle(QPainter*, const QRect&) const;
    virtual void printScale(QPainter*, int, int, int, int, const QRect&) const;
    virtual void printCanvas(QPainter*, const QRect&, SIP_PYLIST, const QwtPlotPrintFilter&) const [
     void (QPainter*, const QRect&, const QwtScaleMap*, const QwtPlotPrintFilter&)];
%MethodCode
        // PyQwt takes a list with QwtScaleMap objects in the first
        // QwtPlot::axisCnt elements.
        
        QwtScaleMap maps[QwtPlot::axisCnt];

        sipIsErr = QwtPlot::axisCnt > PyList_GET_SIZE(a2);

        if (!sipIsErr) {
            for (int i=0; i<QwtPlot::axisCnt; ++i) {
                void *cpp = sipForceConvertToInstance(
                    PyList_GET_ITEM(a2, i), sipClass_QwtScaleMap,
                    0, SIP_NO_CONVERTORS, 0, &sipIsErr);
                maps[i] = *reinterpret_cast<QwtScaleMap*>(cpp);
            }
        }

        if (!sipIsErr) {
            Py_BEGIN_ALLOW_THREADS
            sipCpp->sipProtectVirt_printCanvas(
                sipSelfWasArg, a0, *a1, maps, *a3);
            Py_END_ALLOW_THREADS
        }
End

%VirtualCatcherCode
        PyObject *maps = PyList_New(QwtPlot::axisCnt);

        sipIsErr = !maps;

        if (!sipIsErr) {
            for (int i=0; i<QwtPlot::axisCnt; ++i) {
                PyObject *object = sipConvertFromInstance(
                    const_cast<QwtScaleMap*>(&a2[i]), sipClass_QwtScaleMap, 0);
                if (!object) {
                    sipIsErr = true;
                    break;
                }
                PyList_SET_ITEM(maps, i, object);
            }
        }

        if (!sipIsErr) {
            PyObject *result = sipCallMethod(
                &sipIsErr, sipMethod, "CCSC",
                a0, sipClass_QPainter, 0,
                &a1, sipClass_QRect, 0,
                maps,
                &a3, sipClass_QwtPrintFilter, 0);

            if (result)
            {
                sipParseResult(&sipIsErr, sipMethod, result, "Z");
                Py_DECREF(result);
            }
        }

        Py_XDECREF(maps);
%End

    virtual void printLegend(QPainter*, const QRect&) const;
}; // class QwtPlot
%End // (Qwt_5_0_0 - Qwt_5_1_0)

%If (Qwt_5_1_0 - Qwt_5_2_0)
class QwtPlot: QFrame, QwtPlotDict
{
%TypeHeaderCode
#include <qwt_plot.h>
%End // %TypeHeaderCode

public:
    enum Axis {
        yLeft,
        yRight,
        xBottom,
        xTop,
        axisCnt
    }; // enum Axis

    enum LegendPosition {
        LeftLegend,
        RightLegend,
        BottomLegend,
        TopLegend,
        ExternalLegend
    }; // enum LegendPosition

    QwtPlot(QWidget* /TransferThis/ = 0);
    QwtPlot(const QwtText&, QWidget* /TransferThis/ = 0);
    QwtPlot(QWidget*, const char*);
    virtual ~QwtPlot();
    void applyProperties(const QString&);
    QString grabProperties() const;
    void setAutoReplot(bool = true);
    bool autoReplot() const;
    void print(QPaintDevice&, const QwtPlotPrintFilter& = QwtPlotPrintFilter()) const /PyName=print_/;
    virtual void print(QPainter*, const QRect&, const QwtPlotPrintFilter& = QwtPlotPrintFilter()) const /PyName=print_/;
    QwtPlotLayout* plotLayout();
    // signature: const QwtPlotLayout* plotLayout() const;
    virtual void setMargin(int);
    int margin() const;
    void setTitle(const QString&);
    void setTitle(const QwtText&);
    QwtText title() const;
    QwtTextLabel* titleLabel();
    // signature: const QwtTextLabel* titleLabel() const;
    QwtPlotCanvas* canvas();
    // signature: const QwtPlotCanvas* canvas() const;
    void setCanvasBackground(const QColor&);
    const QColor& canvasBackground() const;
    void setCanvasLineWidth(int);
    int canvasLineWidth() const;
    virtual QwtScaleMap canvasMap(int) const;
    double invTransform(int, int) const;
    int transform(int, double) const;
    QwtScaleEngine* axisScaleEngine(int);
    // signature: const QwtScaleEngine* axisScaleEngine(int) const;
    void setAxisScaleEngine(int, QwtScaleEngine* /Transfer/);
    void setAxisAutoScale(int);
    bool axisAutoScale(int) const;
    void enableAxis(int, bool = true);
    bool axisEnabled(int) const;
    void setAxisFont(int, const QFont&);
    QFont axisFont(int) const;
    void setAxisScale(int, double, double, double = 0);
    void setAxisScaleDiv(int, const QwtScaleDiv&);
    void setAxisScaleDraw(int, QwtScaleDraw* /Transfer/);
    double axisStepSize(int) const;
    // signature: const QwtScaleDiv* axisScaleDiv(int) const;
    QwtScaleDiv* axisScaleDiv(int);
    // signature: const QwtScaleDraw* axisScaleDraw(int) const;
    QwtScaleDraw* axisScaleDraw(int);
    // signature: const QwtScaleWidget* axisWidget(int) const;
    QwtScaleWidget* axisWidget(int);
    void setAxisLabelAlignment(int, int);
    void setAxisLabelRotation(int, double);
    void setAxisTitle(int, const QString&);
    void setAxisTitle(int, const QwtText&);
    QwtText axisTitle(int) const;
    void setAxisMaxMinor(int, int);
    int axisMaxMajor(int) const;
    void setAxisMaxMajor(int, int);
    int axisMaxMinor(int) const;
    void insertLegend(QwtLegend* /Transfer/, QwtPlot::LegendPosition = QwtPlot::RightLegend, double = -1);
    QwtLegend* legend();
    // signature: const QwtLegend* legend() const;
    virtual void polish();
    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;
    virtual void updateLayout();
    virtual bool event(QEvent*);
signals:
    void legendClicked(QwtPlotItem*);
    void legendChecked(QwtPlotItem*, bool);
public slots:
    virtual void clear();
    virtual void replot();
    void autoRefresh();
protected slots:
    virtual void legendItemClicked();
    virtual void legendItemChecked(bool);
protected:
    static bool axisValid(int);
    virtual void drawCanvas(QPainter*);
    virtual void drawItems(QPainter*, const QRect&, SIP_PYLIST, const QwtPlotPrintFilter&) const [
        void (QPainter*, const QRect&, const QwtScaleMap*, const QwtPlotPrintFilter&)];
%MethodCode
        // PyQwt takes a list with QwtScaleMap objects in the first
        // QwtPlot::axisCnt elements.
        
        QwtScaleMap maps[QwtPlot::axisCnt];

        sipIsErr = QwtPlot::axisCnt > PyList_GET_SIZE(a2);

        if (!sipIsErr) {
            for (int i=0; i<QwtPlot::axisCnt; ++i) {
                void *cpp = sipForceConvertToInstance(
                    PyList_GET_ITEM(a2, i), sipClass_QwtScaleMap,
                    0, SIP_NO_CONVERTORS, 0, &sipIsErr);
                maps[i] = *reinterpret_cast<QwtScaleMap*>(cpp);
            }
        }

        if (!sipIsErr) {
            Py_BEGIN_ALLOW_THREADS
            sipCpp->sipProtectVirt_drawItems(sipSelfWasArg, a0, *a1, maps, *a3);
            Py_END_ALLOW_THREADS
        }
%End

%VirtualCatcherCode
        PyObject *maps = PyList_New(QwtPlot::axisCnt);

        sipIsErr = !maps;

        if (!sipIsErr) {
            for (int i=0; i<QwtPlot::axisCnt; ++i) {
                PyObject *object = sipConvertFromInstance(
                    const_cast<QwtScaleMap*>(&a2[i]), sipClass_QwtScaleMap, 0);
                if (!object) {
                    sipIsErr = true;
                    break;
                }
                PyList_SET_ITEM(maps, i, object);
            }
        }

        if (!sipIsErr) {
            PyObject *result = sipCallMethod(
                &sipIsErr, sipMethod, "CCSC",
                a0, sipClass_QPainter, 0,
                &a1, sipClass_QRect, 0,
                maps,
                &a3, sipClass_QwtPlotPrintFilter, 0);

            if (result)
            {
                sipParseResult(&sipIsErr, sipMethod, result, "Z");
                Py_DECREF(result);
            }
        }

        Py_XDECREF(maps);
%End

    virtual void updateTabOrder();
    void updateAxes();
    virtual void resizeEvent(QResizeEvent*);
    virtual void printLegendItem(QPainter*, const QWidget*, const QRect&) const;
    virtual void printTitle(QPainter*, const QRect&) const;
    virtual void printScale(QPainter*, int, int, int, int, const QRect&) const;
    virtual void printCanvas(QPainter*, const QRect&, const QRect&, const QwtScaleMap*, const QwtPlotPrintFilter&) const;
    virtual void printLegend(QPainter*, const QRect&) const;
}; // class QwtPlot
%End // (Qwt_5_1_0 - Qwt_5_2_0)

%If (Qwt_5_2_0 - )
class QwtPlot: QFrame, QwtPlotDict
{
%TypeHeaderCode
#include <qwt_plot.h>
%End // %TypeHeaderCode

public:
    enum Axis {
        yLeft,
        yRight,
        xBottom,
        xTop,
        axisCnt
    }; // enum Axis

    enum LegendPosition {
        LeftLegend,
        RightLegend,
        BottomLegend,
        TopLegend,
        ExternalLegend
    }; // enum LegendPosition

    QwtPlot(QWidget* /TransferThis/ = 0);
    QwtPlot(const QwtText&, QWidget* /TransferThis/ = 0);
    QwtPlot(QWidget*, const char*);
    virtual ~QwtPlot();
    void applyProperties(const QString&);
    QString grabProperties() const;
    void setAutoReplot(bool = true);
    bool autoReplot() const;
    void print(QPaintDevice&, const QwtPlotPrintFilter& = QwtPlotPrintFilter()) const /PyName=print_/;
    virtual void print(QPainter*, const QRect&, const QwtPlotPrintFilter& = QwtPlotPrintFilter()) const /PyName=print_/;
    QwtPlotLayout* plotLayout();
    // signature: const QwtPlotLayout* plotLayout() const;
    virtual void setMargin(int);
    int margin() const;
    void setTitle(const QString&);
    void setTitle(const QwtText&);
    QwtText title() const;
    QwtTextLabel* titleLabel();
    // signature: const QwtTextLabel* titleLabel() const;
    QwtPlotCanvas* canvas();
    // signature: const QwtPlotCanvas* canvas() const;
    void setCanvasBackground(const QColor&);
    const QColor& canvasBackground() const;
    void setCanvasLineWidth(int);
    int canvasLineWidth() const;
    virtual QwtScaleMap canvasMap(int) const;
    double invTransform(int, int) const;
    int transform(int, double) const;
    QwtScaleEngine* axisScaleEngine(int);
    // signature: const QwtScaleEngine* axisScaleEngine(int) const;
    void setAxisScaleEngine(int, QwtScaleEngine* /Transfer/);
    void setAxisAutoScale(int);
    bool axisAutoScale(int) const;
    void enableAxis(int, bool = true);
    bool axisEnabled(int) const;
    void setAxisFont(int, const QFont&);
    QFont axisFont(int) const;
    void setAxisScale(int, double, double, double = 0);
    void setAxisScaleDiv(int, const QwtScaleDiv&);
    void setAxisScaleDraw(int, QwtScaleDraw* /Transfer/);
    double axisStepSize(int) const;
    // signature: const QwtScaleDiv* axisScaleDiv(int) const;
    QwtScaleDiv* axisScaleDiv(int);
    // signature: const QwtScaleDraw* axisScaleDraw(int) const;
    QwtScaleDraw* axisScaleDraw(int);
    // signature: const QwtScaleWidget* axisWidget(int) const;
    QwtScaleWidget* axisWidget(int);
    void setAxisLabelAlignment(int, int);
    void setAxisLabelRotation(int, double);
    void setAxisTitle(int, const QString&);
    void setAxisTitle(int, const QwtText&);
    QwtText axisTitle(int) const;
    void setAxisMaxMinor(int, int);
    int axisMaxMajor(int) const;
    void setAxisMaxMajor(int, int);
    int axisMaxMinor(int) const;
    void insertLegend(QwtLegend* /Transfer/, QwtPlot::LegendPosition = QwtPlot::RightLegend, double = -1);
    QwtLegend* legend();
    // signature: const QwtLegend* legend() const;
    virtual void polish();
    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;
    virtual void updateLayout();
    virtual void drawCanvas(QPainter*);
    void updateAxes();
    virtual bool event(QEvent*);
signals:
    void legendClicked(QwtPlotItem*);
    void legendChecked(QwtPlotItem*, bool);
public slots:
    virtual void clear();
    virtual void replot();
    void autoRefresh();
protected slots:
    virtual void legendItemClicked();
    virtual void legendItemChecked(bool);
protected:
    static bool axisValid(int);
    virtual void drawItems(QPainter*, const QRect&, SIP_PYLIST, const QwtPlotPrintFilter&) const [
        void (QPainter*, const QRect&, const QwtScaleMap*, const QwtPlotPrintFilter&)];
%MethodCode
        // PyQwt takes a list with QwtScaleMap objects in the first
        // QwtPlot::axisCnt elements.
        
        QwtScaleMap maps[QwtPlot::axisCnt];

        sipIsErr = QwtPlot::axisCnt > PyList_GET_SIZE(a2);

        if (!sipIsErr) {
            for (int i=0; i<QwtPlot::axisCnt; ++i) {
                void *cpp = sipForceConvertToInstance(
                    PyList_GET_ITEM(a2, i), sipClass_QwtScaleMap,
                    0, SIP_NO_CONVERTORS, 0, &sipIsErr);
                maps[i] = *reinterpret_cast<QwtScaleMap*>(cpp);
            }
        }

        if (!sipIsErr) {
            Py_BEGIN_ALLOW_THREADS
            sipCpp->sipProtectVirt_drawItems(sipSelfWasArg, a0, *a1, maps, *a3);
            Py_END_ALLOW_THREADS
        }
%End

%VirtualCatcherCode
        PyObject *maps = PyList_New(QwtPlot::axisCnt);

        sipIsErr = !maps;

        if (!sipIsErr) {
            for (int i=0; i<QwtPlot::axisCnt; ++i) {
                PyObject *object = sipConvertFromInstance(
                    const_cast<QwtScaleMap*>(&a2[i]), sipClass_QwtScaleMap, 0);
                if (!object) {
                    sipIsErr = true;
                    break;
                }
                PyList_SET_ITEM(maps, i, object);
            }
        }

        if (!sipIsErr) {
            PyObject *result = sipCallMethod(
                &sipIsErr, sipMethod, "CCSC",
                a0, sipClass_QPainter, 0,
                &a1, sipClass_QRect, 0,
                maps,
                &a3, sipClass_QwtPlotPrintFilter, 0);

            if (result)
            {
                sipParseResult(&sipIsErr, sipMethod, result, "Z");
                Py_DECREF(result);
            }
        }

        Py_XDECREF(maps);
%End

    virtual void updateTabOrder();
    virtual void resizeEvent(QResizeEvent*);
    virtual void printLegendItem(QPainter*, const QWidget*, const QRect&) const;
    virtual void printTitle(QPainter*, const QRect&) const;
    virtual void printScale(QPainter*, int, int, int, int, const QRect&) const;
    virtual void printCanvas(QPainter*, const QRect&, const QRect&, const QwtScaleMap*, const QwtPlotPrintFilter&) const;
    virtual void printLegend(QPainter*, const QRect&) const;
}; // class QwtPlot
%End // (Qwt_5_2_0 - )


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
