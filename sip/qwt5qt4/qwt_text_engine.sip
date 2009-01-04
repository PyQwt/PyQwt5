// The SIP interface specification for:
//      QwtPlainTextEngine,
//      QwtRichTextEngine,
//      QwtTextEngine.
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


class QwtPlainTextEngine: QwtTextEngine
{
%TypeHeaderCode
#include <qwt_text_engine.h>
%End // %TypeHeaderCode

public:
    QwtPlainTextEngine();
    virtual ~QwtPlainTextEngine();
    virtual int heightForWidth(const QFont&, int, const QString&, int) const;
    virtual QSize textSize(const QFont&, int, const QString&) const;
    virtual void draw(QPainter*, const QRect&, int, const QString&) const;
    virtual bool mightRender(const QString&) const;
    virtual void textMargins(const QFont&, const QString&, int&, int&, int&, int&) const;
}; // class QwtPlainTextEngine


class QwtRichTextEngine: QwtTextEngine
{
%TypeHeaderCode
#include <qwt_text_engine.h>
%End // %TypeHeaderCode

public:
    QwtRichTextEngine();
    virtual int heightForWidth(const QFont&, int, const QString&, int) const;
    virtual QSize textSize(const QFont&, int, const QString&) const;
    virtual void draw(QPainter*, const QRect&, int, const QString&) const;
    virtual bool mightRender(const QString&) const;
    virtual void textMargins(const QFont&, const QString&, int&, int&, int&, int&) const;
}; // class QwtRichTextEngine


class QwtTextEngine
{
%TypeHeaderCode
#include <qwt_text_engine.h>
%End // %TypeHeaderCode

public:
    virtual ~QwtTextEngine();
    virtual int heightForWidth(const QFont&, int, const QString&, int) const = 0;
    virtual QSize textSize(const QFont&, int, const QString&) const = 0;
    virtual bool mightRender(const QString&) const = 0;
    virtual void textMargins(const QFont&, const QString&, int&, int&, int&, int&) const = 0;
    virtual void draw(QPainter*, const QRect&, int, const QString&) const = 0;
protected:
    QwtTextEngine();
}; // class QwtTextEngine


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
