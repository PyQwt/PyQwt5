// The SIP interface specification for:
//      QwtText.
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


class QwtText
{
%TypeHeaderCode
#include <qwt_text.h>
%End // %TypeHeaderCode

public:
    enum TextFormat {
        AutoText,
        PlainText,
        RichText,
        MathMLText,
        TeXText,
        OtherFormat
    }; // enum TextFormat

    enum PaintAttribute {
        PaintUsingTextFont,
        PaintUsingTextColor,
        PaintBackground
    }; // enum PaintAttribute

    enum LayoutAttribute {
        MinimumLayout
    }; // enum LayoutAttribute

    QwtText(const QString& = QString::null, QwtText::TextFormat = QwtText::AutoText);
    QwtText(const QwtText&);
    ~QwtText();
    // Not Pythonic: QwtText& operator=(const QwtText&);
    int operator==(const QwtText&) const;
    int operator!=(const QwtText&) const;
    void setText(const QString&, QwtText::TextFormat = QwtText::AutoText);
    QString text() const;
    bool isNull() const;
    bool isEmpty() const;
    void setFont(const QFont&);
    QFont font() const;
    QFont usedFont(const QFont&) const;
    void setRenderFlags(int);
    int renderFlags() const;
    void setColor(const QColor&);
    QColor color() const;
    QColor usedColor(const QColor&) const;
    void setBackgroundPen(const QPen&);
    QPen backgroundPen() const;
    void setBackgroundBrush(const QBrush&);
    QBrush backgroundBrush() const;
    void setPaintAttribute(QwtText::PaintAttribute, bool = true);
    bool testPaintAttribute(QwtText::PaintAttribute) const;
    void setLayoutAttribute(QwtText::LayoutAttribute, bool = true);
    bool testLayoutAttribute(QwtText::LayoutAttribute) const;
    int heightForWidth(int, const QFont& = QFont()) const;
    QSize textSize(const QFont& = QFont()) const;
    void draw(QPainter*, const QRect&) const;
    static const QwtTextEngine* textEngine(const QString&, QwtText::TextFormat = QwtText::AutoText);
    static const QwtTextEngine* textEngine(QwtText::TextFormat);
    static void setTextEngine(QwtText::TextFormat, QwtTextEngine*);
}; // class QwtText


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
