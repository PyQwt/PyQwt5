// The SIP interface specification for:
//      QwtPlotPicker.
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
class QwtPlotPicker: QwtPicker
{
%TypeHeaderCode
#include <qwt_plot_picker.h>
%End // %TypeHeaderCode

public:
    QwtPlotPicker(QwtPlotCanvas* /TransferThis/);
    QwtPlotPicker(int, int, QwtPlotCanvas* /TransferThis/);
    QwtPlotPicker(int, int, int, QwtPicker::RubberBand, QwtPicker::DisplayMode, QwtPlotCanvas* /TransferThis/);
    virtual void setAxis(int, int);
    int xAxis() const;
    int yAxis() const;
    QwtPlot* plot();
    // signature: const QwtPlot* plot() const;
    QwtPlotCanvas* canvas();
    // signature: const QwtPlotCanvas* canvas() const;
signals:
    void selected(const QwtDoublePoint&);
    void selected(const QwtDoubleRect&);
    void selected(const QwtArrayQwtDoublePoint&);
    void appended(const QwtDoublePoint&);
    void moved(const QwtDoublePoint&);
protected:
    QwtDoubleRect scaleRect() const;
    QwtDoubleRect invTransform(const QRect&) const;
    QRect transform(const QwtDoubleRect&) const;
    QwtDoublePoint invTransform(const QPoint&) const;
    QPoint transform(const QwtDoublePoint&) const;
    virtual QwtText trackerText(const QPoint&) const;
    virtual QwtText trackerText(const QwtDoublePoint&) const /PyName=trackerTextF/;
    virtual void move(const QPoint&);
    virtual void append(const QPoint&);
    virtual bool end(bool = true);
}; // class QwtPlotPicker
%End // (Qwt_5_0_0 - Qwt_5_2_0)

%If (Qwt_5_2_0 - )
class QwtPlotPicker: QwtPicker
{
%TypeHeaderCode
#include <qwt_plot_picker.h>
%End // %TypeHeaderCode

public:
    QwtPlotPicker(QwtPlotCanvas* /TransferThis/);
    virtual ~QwtPlotPicker();
    QwtPlotPicker(int, int, QwtPlotCanvas* /TransferThis/);
    QwtPlotPicker(int, int, int, QwtPicker::RubberBand, QwtPicker::DisplayMode, QwtPlotCanvas* /TransferThis/);
    virtual void setAxis(int, int);
    int xAxis() const;
    int yAxis() const;
    QwtPlot* plot();
    // signature: const QwtPlot* plot() const;
    QwtPlotCanvas* canvas();
    // signature: const QwtPlotCanvas* canvas() const;
signals:
    void selected(const QwtDoublePoint&);
    void selected(const QwtDoubleRect&);
    void selected(const QwtArrayQwtDoublePoint&);
    void appended(const QwtDoublePoint&);
    void moved(const QwtDoublePoint&);
protected:
    QwtDoubleRect scaleRect() const;
    QwtDoubleRect invTransform(const QRect&) const;
    QRect transform(const QwtDoubleRect&) const;
    QwtDoublePoint invTransform(const QPoint&) const;
    QPoint transform(const QwtDoublePoint&) const;
    virtual QwtText trackerText(const QPoint&) const;
    virtual QwtText trackerText(const QwtDoublePoint&) const /PyName=trackerTextF/;
    virtual void move(const QPoint&);
    virtual void append(const QPoint&);
    virtual bool end(bool = true);
}; // class QwtPlotPicker
%End // (Qwt_5_2_0 - )


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
