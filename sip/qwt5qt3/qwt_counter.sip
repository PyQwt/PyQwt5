// The SIP interface specification for:
//      QwtCounter.
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


class QwtCounter: QWidget, QwtDoubleRange
{
%TypeHeaderCode
#include <qwt_counter.h>
%End // %TypeHeaderCode

public:
    enum Button {
        Button1,
        Button2,
        Button3,
        ButtonCnt
    }; // enum Button

    QwtCounter(QWidget* /TransferThis/ = 0);
    QwtCounter(QWidget*, const char*);
    virtual ~QwtCounter();
    bool editable() const;
    void setEditable(bool);
    void setNumButtons(int);
    int numButtons() const;
    void setIncSteps(QwtCounter::Button, int);
    int incSteps(QwtCounter::Button) const;
    virtual void setValue(double);
    virtual QSize sizeHint() const;
    virtual void polish();
    double step() const;
    void setStep(double);
    double minVal() const;
    void setMinValue(double);
    double maxVal() const;
    void setMaxValue(double);
    void setStepButton1(int);
    int stepButton1() const;
    void setStepButton2(int);
    int stepButton2() const;
    void setStepButton3(int);
    int stepButton3() const;
    virtual double value() const;
signals:
    void buttonReleased(double);
    void valueChanged(double);
protected:
    virtual bool event(QEvent*);
    virtual void wheelEvent(QWheelEvent*);
    virtual void keyPressEvent(QKeyEvent*);
    virtual void rangeChange();
private slots:
    void btnReleased();
    void btnClicked();
    void textChanged();
private:
    virtual void valueChange();
}; // class QwtCounter


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
