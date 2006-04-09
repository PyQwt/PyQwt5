// The SIP interface specification for:
//      QwtLegend.
//
// Copyright (C) 2001-2006 Gerard Vermeulen
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


class QwtLegend: QFrame
{
%TypeHeaderCode
#include <qwt_legend.h>
%End // %TypeHeaderCode

public:
    enum LegendDisplayPolicy {
        None,
        Fixed,
        Auto
    }; // enum LegendDisplayPolicy

    enum LegendItemMode {
        ReadOnlyItem,
        ClickableItem,
        CheckableItem
    }; // enum LegendItemMode

    QwtLegend(QWidget* /TransferThis/ = 0);
    virtual ~QwtLegend();
    void setDisplayPolicy(QwtLegend::LegendDisplayPolicy, int = -1);
    QwtLegend::LegendDisplayPolicy displayPolicy() const;
    void setItemMode(QwtLegend::LegendItemMode);
    QwtLegend::LegendItemMode itemMode() const;
    int identifierMode() const;
    QWidget* contentsWidget();
    // signature: const QWidget* contentsWidget() const;
    void insert(const QwtPlotItem*, QWidget* /Transfer/);
    void remove(const QwtPlotItem*);
    QWidget* find(const QwtPlotItem*) const;
    QwtPlotItem* find(const QWidget*) const;
    virtual QList<QWidget*> legendItems() const;
    void clear();
    bool isEmpty() const;
    uint itemCount() const;
    virtual bool eventFilter(QObject*, QEvent*);
    virtual QSize sizeHint() const;
    virtual int heightForWidth(int) const;
    QScrollBar* horizontalScrollBar() const;
    QScrollBar* verticalScrollBar() const;
protected:
    virtual void resizeEvent(QResizeEvent*);
    virtual void layoutContents();
}; // class QwtLegend


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
