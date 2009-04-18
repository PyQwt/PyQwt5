// The SIP interface specification for:
//      QwtPainter.
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
class QwtPainter
{
%TypeHeaderCode
#include <qwt_painter.h>
%End // %TypeHeaderCode

public:
    static void setMetricsMap(const QPaintDevice*, const QPaintDevice*);
    static void setMetricsMap(const QwtMetricsMap&);
    static void resetMetricsMap();
    static const QwtMetricsMap& metricsMap();
    static void setDeviceClipping(bool);
    static bool deviceClipping();
    static void setClipRect(QPainter*, const QRect&);
    static void drawText(QPainter*, int, int, const QString&);
    static void drawText(QPainter*, const QPoint&, const QString&);
    static void drawText(QPainter*, int, int, int, int, int, const QString&);
    static void drawText(QPainter*, const QRect&, int, const QString&);
    static void drawSimpleRichText(QPainter*, const QRect&, int, QSimpleRichText&);
    static void drawRect(QPainter*, int, int, int, int);
    static void drawRect(QPainter*, const QRect&);
    static void fillRect(QPainter*, const QRect&, const QBrush&);
    static void drawEllipse(QPainter*, const QRect&);
    static void drawPie(QPainter*, const QRect&, int, int);
    static void drawLine(QPainter*, int, int, int, int);
    static void drawLine(QPainter*, const QPoint&, const QPoint&);
    static void drawPolygon(QPainter*, const QwtPolygon&);
    static void drawPolyline(QPainter*, const QwtPolygon&);
    static void drawPoint(QPainter*, int, int);
    static void drawRoundFrame(QPainter*, const QRect&, int, const QColorGroup&, bool);
    static void drawFocusRect(QPainter*, QWidget*);
    static void drawFocusRect(QPainter*, QWidget*, const QRect&);
    static QwtPolygon clip(const QwtPolygon&);
    static void drawColorBar(QPainter*, const QwtColorMap&, const QwtDoubleInterval&, const QwtScaleMap&, Qt::Orientation, const QRect&);
    static void setSVGMode(bool);
    static bool isSVGMode();
}; // class QwtPainter
%End // (Qwt_5_0_0 - Qwt_5_2_0)

%If (Qwt_5_2_0 - )
class QwtPainter
{
%TypeHeaderCode
#include <qwt_painter.h>
%End // %TypeHeaderCode

public:
    static void setMetricsMap(const QPaintDevice*, const QPaintDevice*);
    static void setMetricsMap(const QwtMetricsMap&);
    static void resetMetricsMap();
    static const QwtMetricsMap& metricsMap();
    static void setDeviceClipping(bool);
    static bool deviceClipping();
    static const QRect& deviceClipRect();
    static void setClipRect(QPainter*, const QRect&);
    static void drawText(QPainter*, int, int, const QString&);
    static void drawText(QPainter*, const QPoint&, const QString&);
    static void drawText(QPainter*, int, int, int, int, int, const QString&);
    static void drawText(QPainter*, const QRect&, int, const QString&);
    static void drawSimpleRichText(QPainter*, const QRect&, int, QSimpleRichText&);
    static void drawRect(QPainter*, int, int, int, int);
    static void drawRect(QPainter*, const QRect&);
    static void fillRect(QPainter*, const QRect&, const QBrush&);
    static void drawEllipse(QPainter*, const QRect&);
    static void drawPie(QPainter*, const QRect&, int, int);
    static void drawLine(QPainter*, int, int, int, int);
    static void drawLine(QPainter*, const QPoint&, const QPoint&);
    static void drawPolygon(QPainter*, const QwtPolygon&);
    static void drawPolyline(QPainter*, const QwtPolygon&);
    static void drawPoint(QPainter*, int, int);
    static void drawRoundFrame(QPainter*, const QRect&, int, const QColorGroup&, bool);
    static void drawFocusRect(QPainter*, QWidget*);
    static void drawFocusRect(QPainter*, QWidget*, const QRect&);
    static void drawColorBar(QPainter*, const QwtColorMap&, const QwtDoubleInterval&, const QwtScaleMap&, Qt::Orientation, const QRect&);
    static void setSVGMode(bool);
    static bool isSVGMode();
    static QPen scaledPen(const QPen&);
}; // class QwtPainter
%End // (Qwt_5_2_0 - )


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
