// The SIP interface specification for:
//      QwtPanner.
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
class QwtPanner: QWidget
{
%TypeHeaderCode
#include <qwt_panner.h>
%End // %TypeHeaderCode

public:
    QwtPanner(QWidget* /TransferThis/);
    virtual ~QwtPanner();
    virtual void setEnabled(bool);
    bool isEnabled() const;
    void setMouseButton(int, int = Qt::NoButton);
    void getMouseButton(int&, int&) const;
    void setAbortKey(int, int = Qt::NoButton);
    void getAbortKey(int&, int&) const;
    virtual void setCursor(const QCursor&);
    const QCursor cursor() const;
    virtual bool eventFilter(QObject*, QEvent*);
signals:
    void panned(int, int);
    void moved(int, int);
protected:
    virtual void widgetMousePressEvent(QMouseEvent*);
    virtual void widgetMouseReleaseEvent(QMouseEvent*);
    virtual void widgetMouseMoveEvent(QMouseEvent*);
    virtual void widgetKeyPressEvent(QKeyEvent*);
    virtual void widgetKeyReleaseEvent(QKeyEvent*);
    virtual void paintEvent(QPaintEvent*);
}; // class QwtPanner
%End // (Qwt_5_0_0 - Qwt_5_1_0)

%If (Qwt_5_1_0 - )
class QwtPanner: QWidget
{
%TypeHeaderCode
#include <qwt_panner.h>
%End // %TypeHeaderCode

public:
    QwtPanner(QWidget* /TransferThis/);
    virtual ~QwtPanner();
    virtual void setEnabled(bool);
    bool isEnabled() const;
    void setMouseButton(int, int = Qt::NoButton);
    void getMouseButton(int&, int&) const;
    void setAbortKey(int, int = Qt::NoButton);
    void getAbortKey(int&, int&) const;
    virtual void setCursor(const QCursor&);
    const QCursor cursor() const;
    void enableOrientation(Qt::Orientation, bool);
    bool isOrientationEnabled(Qt::Orientation) const;
    virtual bool eventFilter(QObject*, QEvent*);
signals:
    void panned(int, int);
    void moved(int, int);
protected:
    virtual void widgetMousePressEvent(QMouseEvent*);
    virtual void widgetMouseReleaseEvent(QMouseEvent*);
    virtual void widgetMouseMoveEvent(QMouseEvent*);
    virtual void widgetKeyPressEvent(QKeyEvent*);
    virtual void widgetKeyReleaseEvent(QKeyEvent*);
    virtual void paintEvent(QPaintEvent*);
}; // class QwtPanner
%End // (Qwt_5_1_0 - )


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
