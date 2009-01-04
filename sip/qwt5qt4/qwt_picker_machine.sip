// The SIP interface specification for:
//      QwtPickerClickPointMachine,
//      QwtPickerClickRectMachine,
//      QwtPickerDragPointMachine,
//      QwtPickerDragRectMachine,
//      QwtPickerMachine,
//      QwtPickerPolygonMachine.
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


class QwtPickerClickPointMachine: QwtPickerMachine
{
%TypeHeaderCode
#include <qwt_picker_machine.h>
%End // %TypeHeaderCode

public:
    virtual QList<QwtPickerMachine::Command> transition(const QwtEventPattern&, const QEvent*);
}; // class QwtPickerClickPointMachine


class QwtPickerClickRectMachine: QwtPickerMachine
{
%TypeHeaderCode
#include <qwt_picker_machine.h>
%End // %TypeHeaderCode

public:
    virtual QList<QwtPickerMachine::Command> transition(const QwtEventPattern&, const QEvent*);
}; // class QwtPickerClickRectMachine


class QwtPickerDragPointMachine: QwtPickerMachine
{
%TypeHeaderCode
#include <qwt_picker_machine.h>
%End // %TypeHeaderCode

public:
    virtual QList<QwtPickerMachine::Command> transition(const QwtEventPattern&, const QEvent*);
}; // class QwtPickerDragPointMachine


class QwtPickerDragRectMachine: QwtPickerMachine
{
%TypeHeaderCode
#include <qwt_picker_machine.h>
%End // %TypeHeaderCode

public:
    virtual QList<QwtPickerMachine::Command> transition(const QwtEventPattern&, const QEvent*);
}; // class QwtPickerDragRectMachine


class QwtPickerMachine
{
%TypeHeaderCode
#include <qwt_picker_machine.h>
%End // %TypeHeaderCode

public:
    enum Command {
        Begin,
        Append,
        Move,
        End
    }; // enum Command

    virtual ~QwtPickerMachine();
    virtual QList<QwtPickerMachine::Command> transition(const QwtEventPattern&, const QEvent*) = 0;
    void reset();
    int state() const;
    void setState(int);
protected:
    QwtPickerMachine();

%If (CXX_DYNAMIC_CAST)
%ConvertToSubClassCode
    // Walk the inheritance tree depth first in alphabetical order
#ifdef sipClass_QwtPickerClickPointMachine
    if (dynamic_cast<const QwtPickerClickPointMachine *>(sipCpp))
        sipClass = sipClass_QwtPickerClickPointMachine;
    else
#endif
#ifdef sipClass_QwtPickerClickRectMachine 
    if (dynamic_cast<const QwtPickerClickRectMachine *>(sipCpp))
        sipClass = sipClass_QwtPickerClickRectMachine;
    else
#endif
#ifdef sipClass_QwtPickerDragPointMachine
    if (dynamic_cast<const QwtPickerDragPointMachine *>(sipCpp))
        sipClass = sipClass_QwtPickerDragPointMachine;
    else
#endif
#ifdef sipClass_QwtPickerDragRectMachine 
    if (dynamic_cast<const QwtPickerDragRectMachine *>(sipCpp))
        sipClass = sipClass_QwtPickerDragRectMachine;
    else
#endif
#ifdef sipClass_QwtPickerPolygonMachine
    if (dynamic_cast<const QwtPickerPolygonMachine *>(sipCpp))
        sipClass = sipClass_QwtPickerPolygonMachine;
    else
#endif
#ifdef sipClass_QwtPickerMachine
    if (dynamic_cast<const QwtPickerMachine *>(sipCpp))
        sipClass = sipClass_QwtPickerMachine;
    else
#endif
        sipClass = 0;
%End
%End

}; // class QwtPickerMachine


class QwtPickerPolygonMachine: QwtPickerMachine
{
%TypeHeaderCode
#include <qwt_picker_machine.h>
%End // %TypeHeaderCode

public:
    virtual QList<QwtPickerMachine::Command> transition(const QwtEventPattern&, const QEvent*);
}; // class QwtPickerPolygonMachine


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
