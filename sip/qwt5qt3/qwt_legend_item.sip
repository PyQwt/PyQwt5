// The SIP interface specification for:
//      QwtLegendItem.
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


%If (Qwt_5_0_0 - Qwt_5_2_0)
class QwtLegendItem: QwtTextLabel
{
%TypeHeaderCode
#include <qwt_legend_item.h>
%End // %TypeHeaderCode

public:
    enum IdentifierMode {
        NoIdentifier,
        ShowLine,
        ShowSymbol,
        ShowText
    }; // enum IdentifierMode

    QwtLegendItem(QWidget* /TransferThis/ = 0);
    QwtLegendItem(const QwtSymbol&, const QPen&, const QwtText&, QWidget* /TransferThis/ = 0);
    virtual ~QwtLegendItem();
    virtual void setText(const QwtText&);
    void setItemMode(QwtLegend::LegendItemMode);
    QwtLegend::LegendItemMode itemMode() const;
    void setIdentifierMode(int);
    int identifierMode() const;
    void setIdentfierWidth(int);
    int identifierWidth() const;
    void setSpacing(int);
    int spacing() const;
    void setSymbol(const QwtSymbol&);
    const QwtSymbol& symbol() const;
    void setCurvePen(const QPen&);
    const QPen& curvePen() const;
    virtual void drawIdentifier(QPainter*, const QRect&) const;
    virtual void drawItem(QPainter*, const QRect&) const;
    virtual QSize sizeHint() const;
    bool isChecked() const;
public slots:
    void setChecked(bool);
signals:
    void clicked();
    void pressed();
    void released();
    void checked(bool);
protected:
    void setDown(bool);
    bool isDown() const;
    virtual void paintEvent(QPaintEvent*);
    virtual void mousePressEvent(QMouseEvent*);
    virtual void mouseReleaseEvent(QMouseEvent*);
    virtual void keyPressEvent(QKeyEvent*);
    virtual void keyReleaseEvent(QKeyEvent*);
    virtual void drawText(QPainter*, const QRect&);
}; // class QwtLegendItem
%End // (Qwt_5_0_0 - Qwt_5_2_0)

%If (Qwt_5_2_0 - )
class QwtLegendItem: QwtTextLabel
{
%TypeHeaderCode
#include <qwt_legend_item.h>
%End // %TypeHeaderCode

public:
    enum IdentifierMode {
        NoIdentifier,
        ShowLine,
        ShowSymbol,
        ShowText
    }; // enum IdentifierMode

    QwtLegendItem(QWidget* /TransferThis/ = 0);
    QwtLegendItem(const QwtSymbol&, const QPen&, const QwtText&, QWidget* /TransferThis/ = 0);
    virtual ~QwtLegendItem();
    virtual void setText(const QwtText&);
    void setItemMode(QwtLegend::LegendItemMode);
    QwtLegend::LegendItemMode itemMode() const;
    void setIdentifierMode(int);
    int identifierMode() const;
    void setIdentifierWidth(int);
    int identifierWidth() const;
    void setSpacing(int);
    int spacing() const;
    void setSymbol(const QwtSymbol&);
    const QwtSymbol& symbol() const;
    void setCurvePen(const QPen&);
    const QPen& curvePen() const;
    virtual void drawIdentifier(QPainter*, const QRect&) const;
    virtual void drawItem(QPainter*, const QRect&) const;
    virtual QSize sizeHint() const;
    bool isChecked() const;
public slots:
    void setChecked(bool);
signals:
    void clicked();
    void pressed();
    void released();
    void checked(bool);
protected:
    void setDown(bool);
    bool isDown() const;
    virtual void paintEvent(QPaintEvent*);
    virtual void mousePressEvent(QMouseEvent*);
    virtual void mouseReleaseEvent(QMouseEvent*);
    virtual void keyPressEvent(QKeyEvent*);
    virtual void keyReleaseEvent(QKeyEvent*);
    virtual void drawText(QPainter*, const QRect&);
}; // class QwtLegendItem
%End // (Qwt_5_2_0 - )


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
