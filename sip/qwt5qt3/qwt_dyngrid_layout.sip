// The SIP interface specification for:
//      QwtDynGridLayout.
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


class QwtDynGridLayout: QLayout
{
%TypeHeaderCode
#include <qwt_dyngrid_layout.h>
%End // %TypeHeaderCode

public:
    QwtDynGridLayout(QWidget* /TransferThis/, int = 0, int = -1);
    QwtDynGridLayout(QLayout*, int = -1);
    QwtDynGridLayout(int = -1);
    virtual ~QwtDynGridLayout();
    virtual void invalidate();
    void setMaxCols(uint);
    uint maxCols() const;
    uint numRows() const;
    uint numCols() const;
    virtual void addItem(QLayoutItem* /Transfer/);
    virtual QLayoutIterator iterator();
    void setExpanding(QSizePolicy::ExpandData);
    virtual QSizePolicy::ExpandData expanding() const;
    QValueList<QRect> layoutItems(const QRect&, uint) const;
    virtual int maxItemWidth() const;
    virtual void setGeometry(const QRect&);
    virtual bool hasHeightForWidth() const;
    virtual int heightForWidth(int) const;
    virtual QSize sizeHint() const;
    virtual bool isEmpty() const;
    uint itemCount() const;
    virtual uint columnsForWidth(int) const;
protected:
    void layoutGrid(uint, QwtArrayInt&, QwtArrayInt&) const;
    void stretchGrid(const QRect&, uint, QwtArrayInt&, QwtArrayInt&) const;
}; // class QwtDynGridLayout


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
