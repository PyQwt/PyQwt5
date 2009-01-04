// The SIP interface specification for:
//      QwtEventPattern.
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


class QwtEventPattern
{
%TypeHeaderCode
#include <qwt_event_pattern.h>
%End // %TypeHeaderCode

public:
    enum MousePatternCode {
        MouseSelect1,
        MouseSelect2,
        MouseSelect3,
        MouseSelect4,
        MouseSelect5,
        MouseSelect6,
        MousePatternCount
    }; // enum MousePatternCode

    enum KeyPatternCode {
        KeySelect1,
        KeySelect2,
        KeyAbort,
        KeyLeft,
        KeyRight,
        KeyUp,
        KeyDown,
        KeyRedo,
        KeyUndo,
        KeyHome,
        KeyPatternCount
    }; // enum KeyPatternCode

    class MousePattern
    {
%TypeHeaderCode
#include <qwt_event_pattern.h>
%End // %TypeHeaderCode

    public:
        int button;
        int state;
        MousePattern(int = Qt::NoButton, int = Qt::NoButton);
    }; // class MousePattern

    class KeyPattern
    {
%TypeHeaderCode
#include <qwt_event_pattern.h>
%End // %TypeHeaderCode

    public:
        int key;
        int state;
        KeyPattern(int = 0, int = Qt::NoButton);
    }; // class KeyPattern

    QwtEventPattern();
    virtual ~QwtEventPattern();
    void initMousePattern(int);
    void initKeyPattern();
    void setMousePattern(uint, int, int = Qt::NoButton);
    void setKeyPattern(uint, int, int = Qt::NoButton);
    void setMousePattern(const QVector<QwtEventPattern::MousePattern>&);
    void setKeyPattern(const QVector<QwtEventPattern::KeyPattern>&);
    // signature: const QVector<QwtEventPattern::MousePattern>& mousePattern() const;
    // signature: const QVector<QwtEventPattern::KeyPattern>& keyPattern() const;
    QVector<QwtEventPattern::MousePattern>& mousePattern();
    QVector<QwtEventPattern::KeyPattern>& keyPattern();
    bool mouseMatch(uint, const QMouseEvent*) const;
    bool keyMatch(uint, const QKeyEvent*) const;
protected:
    virtual bool mouseMatch(const QwtEventPattern::MousePattern&, const QMouseEvent*) const;
    virtual bool keyMatch(const QwtEventPattern::KeyPattern&, const QKeyEvent*) const;
}; // class QwtEventPattern


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
