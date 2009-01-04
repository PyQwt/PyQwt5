// The SIP interface specification for:
//      QwtScaleDraw.
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
class QwtScaleDraw: QwtAbstractScaleDraw
{
%TypeHeaderCode
#include <qwt_scale_draw.h>
%End // %TypeHeaderCode

public:
    enum Alignment {
        BottomScale,
        TopScale,
        LeftScale,
        RightScale
    }; // enum Alignment

    QwtScaleDraw();
    QwtScaleDraw(const QwtScaleDraw&);
    virtual ~QwtScaleDraw();
    // Not Pythonic: QwtScaleDraw& operator=(const QwtScaleDraw&);
    void getBorderDistHint(const QFont&, int& /Out/, int& /Out/) const;
    int minLabelDist(const QFont&) const;
    int minLength(const QPen&, const QFont&) const;
    virtual int extent(const QPen&, const QFont&) const;
    void move(int, int);
    void move(const QPoint&);
    void setLength(int);
    QwtScaleDraw::Alignment alignment() const;
    void setAlignment(QwtScaleDraw::Alignment);
    Qt::Orientation orientation() const;
    QPoint pos() const;
    int length() const;
    void setLabelAlignment(Qt::Alignment);
    Qt::Alignment labelAlignment() const;
    void setLabelRotation(double);
    double labelRotation() const;
    int maxLabelHeight(const QFont&) const;
    int maxLabelWidth(const QFont&) const;
    QPoint labelPosition(double) const;
    QRect labelRect(const QFont&, double) const;
    QSize labelSize(const QFont&, double) const;
protected:
    QMatrix labelMatrix(const QPoint&, const QSize&) const;
    virtual void drawTick(QPainter*, double, int) const;
    virtual void drawBackbone(QPainter*) const;
    virtual void drawLabel(QPainter*, double) const;
}; // class QwtScaleDraw
%End // (Qwt_5_0_0 - Qwt_5_1_0)

%If (Qwt_5_1_0 - )
class QwtScaleDraw: QwtAbstractScaleDraw
{
%TypeHeaderCode
#include <qwt_scale_draw.h>
%End // %TypeHeaderCode

public:
    enum Alignment {
        BottomScale,
        TopScale,
        LeftScale,
        RightScale
    }; // enum Alignment

    QwtScaleDraw();
    QwtScaleDraw(const QwtScaleDraw&);
    virtual ~QwtScaleDraw();
    // Not Pythonic: QwtScaleDraw& operator=(const QwtScaleDraw&);
    void getBorderDistHint(const QFont&, int& /Out/, int& /Out/) const;
    int minLabelDist(const QFont&) const;
    int minLength(const QPen&, const QFont&) const;
    virtual int extent(const QPen&, const QFont&) const;
    void move(int, int);
    void move(const QPoint&);
    void setLength(int);
    QwtScaleDraw::Alignment alignment() const;
    void setAlignment(QwtScaleDraw::Alignment);
    Qt::Orientation orientation() const;
    QPoint pos() const;
    int length() const;
    void setLabelAlignment(Qt::Alignment);
    Qt::Alignment labelAlignment() const;
    void setLabelRotation(double);
    double labelRotation() const;
    int maxLabelHeight(const QFont&) const;
    int maxLabelWidth(const QFont&) const;
    QPoint labelPosition(double) const;
    QRect labelRect(const QFont&, double) const;
    QSize labelSize(const QFont&, double) const;
    QRect boundingLabelRect(const QFont&, double) const;
protected:
    QMatrix labelMatrix(const QPoint&, const QSize&) const;
    virtual void drawTick(QPainter*, double, int) const;
    virtual void drawBackbone(QPainter*) const;
    virtual void drawLabel(QPainter*, double) const;
}; // class QwtScaleDraw
%End // (Qwt_5_1_0 - )


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
