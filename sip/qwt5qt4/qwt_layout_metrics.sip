// The SIP interface specification for:
//      QwtMetricsMap.
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


class QwtMetricsMap
{
%TypeHeaderCode
#include <qwt_layout_metrics.h>
%End // %TypeHeaderCode

public:
    QwtMetricsMap();
    bool isIdentity() const;
    void setMetrics(const QPaintDevice*, const QPaintDevice*);
    int layoutToDeviceX(int) const;
    int deviceToLayoutX(int) const;
    int screenToLayoutX(int) const;
    int layoutToScreenX(int) const;
    int layoutToDeviceY(int) const;
    int deviceToLayoutY(int) const;
    int screenToLayoutY(int) const;
    int layoutToScreenY(int) const;
    QPoint layoutToDevice(const QPoint&, const QPainter* = 0) const;
    QPoint deviceToLayout(const QPoint&, const QPainter* = 0) const;
    QPoint screenToLayout(const QPoint&) const;
    QPoint layoutToScreen(const QPoint&) const;
    QSize layoutToDevice(const QSize&) const;
    QSize deviceToLayout(const QSize&) const;
    QSize screenToLayout(const QSize&) const;
    QSize layoutToScreen(const QSize&) const;
    QRect layoutToDevice(const QRect&, const QPainter* = 0) const;
    QRect deviceToLayout(const QRect&, const QPainter* = 0) const;
    QRect screenToLayout(const QRect&) const;
    QRect layoutToScreen(const QRect&) const;
    QwtPolygon layoutToDevice(const QwtPolygon&, const QPainter* = 0) const;
    QwtPolygon deviceToLayout(const QwtPolygon&, const QPainter* = 0) const;
    static QwtPolygon translate(const QMatrix&, const QwtPolygon&);
    static QRect translate(const QMatrix&, const QRect&);
}; // class QwtMetricsMap


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
