// The SIP interface specification for:
//      QwtPicker.
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


%If (Qwt_5_0_0 - Qwt_5_0_3)
class QwtPicker: QObject, QwtEventPattern
{
%TypeHeaderCode
#include <qwt_picker.h>
%End // %TypeHeaderCode

public:
    enum SelectionType {
        NoSelection,
        PointSelection,
        RectSelection,
        PolygonSelection
    }; // enum SelectionType

    enum RectSelectionType {
        CornerToCorner,
        CenterToCorner,
        CenterToRadius
    }; // enum RectSelectionType

    enum SelectionMode {
        ClickSelection,
        DragSelection
    }; // enum SelectionMode

    enum RubberBand {
        NoRubberBand,
        HLineRubberBand,
        VLineRubberBand,
        CrossRubberBand,
        RectRubberBand,
        EllipseRubberBand,
        PolygonRubberBand,
        UserRubberBand
    }; // enum RubberBand

    enum DisplayMode {
        AlwaysOff,
        AlwaysOn,
        ActiveOnly
    }; // enum DisplayMode

    enum ResizeMode {
        Stretch,
        KeepSize
    }; // enum ResizeMode

    QwtPicker(QWidget* /TransferThis/);
    QwtPicker(int, QwtPicker::RubberBand, QwtPicker::DisplayMode, QWidget* /TransferThis/);
    virtual ~QwtPicker();
    virtual void setSelectionFlags(int);
    int selectionFlags() const;
    virtual void setRubberBand(QwtPicker::RubberBand);
    QwtPicker::RubberBand rubberBand() const;
    virtual void setTrackerMode(QwtPicker::DisplayMode);
    QwtPicker::DisplayMode trackerMode() const;
    virtual void setResizeMode(QwtPicker::ResizeMode);
    QwtPicker::ResizeMode resizeMode() const;
    virtual void setRubberBandPen(const QPen&);
    QPen rubberBandPen() const;
    virtual void setTrackerPen(const QPen&);
    QPen trackerPen() const;
    virtual void setTrackerFont(const QFont&);
    QFont trackerFont() const;
    bool isEnabled() const;
    virtual void setEnabled(bool);
    bool isActive() const;
    virtual bool eventFilter(QObject*, QEvent*);
    QWidget* parentWidget();
    // signature: const QWidget* parentWidget() const;
    virtual QRect pickRect() const;
    const QwtPolygon& selection() const;
    virtual void drawRubberBand(QPainter*) const;
    virtual void drawTracker(QPainter*) const;
signals:
    void selected(const QwtPolygon&);
    void appended(const QPoint&);
    void moved(const QPoint&);
    void changed(const QwtPolygon&);
protected:
    virtual bool accept(QwtPolygon&) const;
    virtual void transition(const QEvent*);
    virtual void begin();
    virtual void append(const QPoint&);
    virtual void move(const QPoint&);
    virtual bool end(bool = true);
    virtual void widgetMousePressEvent(QMouseEvent*);
    virtual void widgetMouseReleaseEvent(QMouseEvent*);
    virtual void widgetMouseDoubleClickEvent(QMouseEvent*);
    virtual void widgetMouseMoveEvent(QMouseEvent*);
    virtual void widgetWheelEvent(QWheelEvent*);
    virtual void widgetKeyPressEvent(QKeyEvent*);
    virtual void widgetKeyReleaseEvent(QKeyEvent*);
    virtual void widgetLeaveEvent(QEvent*);
    QRect trackerRect(QPainter*) const;
    virtual void stretchSelection(const QSize&, const QSize&);
    virtual QwtText trackerText(const QPoint&) const;
    virtual QwtPickerMachine* stateMachine(int) const /Factory/;
    virtual void updateDisplay();
    const QWidget* rubberBandWidget() const;
    const QWidget* trackerWidget() const;
}; // class QwtPicker
%End // (Qwt_5_0_0 - Qwt_5_0_3)

%If (Qwt_5_0_3 - Qwt_5_1_0)
class QwtPicker: QObject, QwtEventPattern
{
%TypeHeaderCode
#include <qwt_picker.h>
%End // %TypeHeaderCode

public:
    enum SelectionType {
        NoSelection,
        PointSelection,
        RectSelection,
        PolygonSelection
    }; // enum SelectionType

    enum RectSelectionType {
        CornerToCorner,
        CenterToCorner,
        CenterToRadius
    }; // enum RectSelectionType

    enum SelectionMode {
        ClickSelection,
        DragSelection
    }; // enum SelectionMode

    enum RubberBand {
        NoRubberBand,
        HLineRubberBand,
        VLineRubberBand,
        CrossRubberBand,
        RectRubberBand,
        EllipseRubberBand,
        PolygonRubberBand,
        UserRubberBand
    }; // enum RubberBand

    enum DisplayMode {
        AlwaysOff,
        AlwaysOn,
        ActiveOnly
    }; // enum DisplayMode

    enum ResizeMode {
        Stretch,
        KeepSize
    }; // enum ResizeMode

    QwtPicker(QWidget* /TransferThis/);
    QwtPicker(int, QwtPicker::RubberBand, QwtPicker::DisplayMode, QWidget* /TransferThis/);
    virtual ~QwtPicker();
    virtual void setSelectionFlags(int);
    int selectionFlags() const;
    virtual void setRubberBand(QwtPicker::RubberBand);
    QwtPicker::RubberBand rubberBand() const;
    virtual void setTrackerMode(QwtPicker::DisplayMode);
    QwtPicker::DisplayMode trackerMode() const;
    virtual void setResizeMode(QwtPicker::ResizeMode);
    QwtPicker::ResizeMode resizeMode() const;
    virtual void setRubberBandPen(const QPen&);
    QPen rubberBandPen() const;
    virtual void setTrackerPen(const QPen&);
    QPen trackerPen() const;
    virtual void setTrackerFont(const QFont&);
    QFont trackerFont() const;
    bool isEnabled() const;
    virtual void setEnabled(bool);
    bool isActive() const;
    virtual bool eventFilter(QObject*, QEvent*);
    QWidget* parentWidget();
    // signature: const QWidget* parentWidget() const;
    virtual QRect pickRect() const;
    const QwtPolygon& selection() const;
    virtual void drawRubberBand(QPainter*) const;
    virtual void drawTracker(QPainter*) const;
    virtual QwtText trackerText(const QPoint&) const;
    QRect trackerRect(QPainter*) const;
signals:
    void selected(const QwtPolygon&);
    void appended(const QPoint&);
    void moved(const QPoint&);
    void changed(const QwtPolygon&);
protected:
    virtual bool accept(QwtPolygon&) const;
    virtual void transition(const QEvent*);
    virtual void begin();
    virtual void append(const QPoint&);
    virtual void move(const QPoint&);
    virtual bool end(bool = true);
    virtual void widgetMousePressEvent(QMouseEvent*);
    virtual void widgetMouseReleaseEvent(QMouseEvent*);
    virtual void widgetMouseDoubleClickEvent(QMouseEvent*);
    virtual void widgetMouseMoveEvent(QMouseEvent*);
    virtual void widgetWheelEvent(QWheelEvent*);
    virtual void widgetKeyPressEvent(QKeyEvent*);
    virtual void widgetKeyReleaseEvent(QKeyEvent*);
    virtual void widgetLeaveEvent(QEvent*);
    virtual void stretchSelection(const QSize&, const QSize&);
    virtual QwtPickerMachine* stateMachine(int) const /Factory/;
    virtual void updateDisplay();
    const QWidget* rubberBandWidget() const;
    const QWidget* trackerWidget() const;
}; // class QwtPicker
%End // (Qwt_5_0_3 - Qwt_5_1_0)

%If (Qwt_5_1_0 - )
class QwtPicker: QObject, QwtEventPattern
{
%TypeHeaderCode
#include <qwt_picker.h>
%End // %TypeHeaderCode

public:
    enum SelectionType {
        NoSelection,
        PointSelection,
        RectSelection,
        PolygonSelection
    }; // enum SelectionType

    enum RectSelectionType {
        CornerToCorner,
        CenterToCorner,
        CenterToRadius
    }; // enum RectSelectionType

    enum SelectionMode {
        ClickSelection,
        DragSelection
    }; // enum SelectionMode

    enum RubberBand {
        NoRubberBand,
        HLineRubberBand,
        VLineRubberBand,
        CrossRubberBand,
        RectRubberBand,
        EllipseRubberBand,
        PolygonRubberBand,
        UserRubberBand
    }; // enum RubberBand

    enum DisplayMode {
        AlwaysOff,
        AlwaysOn,
        ActiveOnly
    }; // enum DisplayMode

    enum ResizeMode {
        Stretch,
        KeepSize
    }; // enum ResizeMode

    QwtPicker(QWidget* /TransferThis/);
    QwtPicker(int, QwtPicker::RubberBand, QwtPicker::DisplayMode, QWidget* /TransferThis/);
    virtual ~QwtPicker();
    virtual void setSelectionFlags(int);
    int selectionFlags() const;
    virtual void setRubberBand(QwtPicker::RubberBand);
    QwtPicker::RubberBand rubberBand() const;
    virtual void setTrackerMode(QwtPicker::DisplayMode);
    QwtPicker::DisplayMode trackerMode() const;
    virtual void setResizeMode(QwtPicker::ResizeMode);
    QwtPicker::ResizeMode resizeMode() const;
    virtual void setRubberBandPen(const QPen&);
    QPen rubberBandPen() const;
    virtual void setTrackerPen(const QPen&);
    QPen trackerPen() const;
    virtual void setTrackerFont(const QFont&);
    QFont trackerFont() const;
    bool isEnabled() const;
    virtual void setEnabled(bool);
    bool isActive() const;
    virtual bool eventFilter(QObject*, QEvent*);
    QWidget* parentWidget();
    // signature: const QWidget* parentWidget() const;
    virtual QRect pickRect() const;
    const QwtPolygon& selection() const;
    virtual void drawRubberBand(QPainter*) const;
    virtual void drawTracker(QPainter*) const;
    virtual QwtText trackerText(const QPoint&) const;
    QPoint trackerPosition() const;
    QRect trackerRect(const QFont&) const;
signals:
    void selected(const QwtPolygon&);
    void appended(const QPoint&);
    void moved(const QPoint&);
    void changed(const QwtPolygon&);
protected:
    virtual bool accept(QwtPolygon&) const;
    virtual void transition(const QEvent*);
    virtual void begin();
    virtual void append(const QPoint&);
    virtual void move(const QPoint&);
    virtual bool end(bool = true);
    virtual void reset();
    virtual void widgetMousePressEvent(QMouseEvent*);
    virtual void widgetMouseReleaseEvent(QMouseEvent*);
    virtual void widgetMouseDoubleClickEvent(QMouseEvent*);
    virtual void widgetMouseMoveEvent(QMouseEvent*);
    virtual void widgetWheelEvent(QWheelEvent*);
    virtual void widgetKeyPressEvent(QKeyEvent*);
    virtual void widgetKeyReleaseEvent(QKeyEvent*);
    virtual void widgetLeaveEvent(QEvent*);
    virtual void stretchSelection(const QSize&, const QSize&);
    virtual QwtPickerMachine* stateMachine(int) const /Factory/;
    virtual void updateDisplay();
    const QWidget* rubberBandWidget() const;
    const QWidget* trackerWidget() const;
}; // class QwtPicker
%End // (Qwt_5_1_0 - )


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
