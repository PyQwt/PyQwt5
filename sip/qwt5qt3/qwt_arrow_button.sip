// The SIP interface specification for:
//      QwtArrowButton.
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


class QwtArrowButton: QPushButton
{
%TypeHeaderCode
#include <qwt_arrow_button.h>
%End // %TypeHeaderCode

public:
    QwtArrowButton(int, Qt::ArrowType, QWidget* /TransferThis/ = 0);
    virtual ~QwtArrowButton();
    Qt::ArrowType arrowType() const;
    int num() const;
    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;
protected:
    virtual void drawButtonLabel(QPainter*);
    virtual void drawArrow(QPainter*, const QRect&, Qt::ArrowType) const;
    virtual QRect labelRect() const;
    virtual QSize arrowSize(Qt::ArrowType, const QSize&) const;
    virtual void keyPressEvent(QKeyEvent*);
}; // class QwtArrowButton


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
