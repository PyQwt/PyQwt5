// The SIP interface specification for:
//      QwtPlotRescaler.
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


class QwtPlotRescaler: QObject
{
%TypeHeaderCode
#include <qwt_plot_rescaler.h>
%End // %TypeHeaderCode

public:
    enum RescalePolicy {
        Fixed,
        Expanding,
        Fitting
    }; // enum RescalePolicy

    enum ExpandingDirection {
        ExpandUp,
        ExpandDown,
        ExpandBoth
    }; // enum ExpandingDirection

    QwtPlotRescaler(QwtPlotCanvas*, int = QwtPlot::xBottom, QwtPlotRescaler::RescalePolicy = Expanding);
    virtual ~QwtPlotRescaler();
    void setEnabled(bool);
    bool isEnabled() const;
    void setRescalePolicy(QwtPlotRescaler::RescalePolicy);
    QwtPlotRescaler::RescalePolicy rescalePolicy() const;
    void setExpandingDirection(QwtPlotRescaler::ExpandingDirection);
    void setExpandingDirection(int, QwtPlotRescaler::ExpandingDirection);
    QwtPlotRescaler::ExpandingDirection expandingDirection(int) const;
    void setReferenceAxis(int);
    int referenceAxis() const;
    void setAspectRatio(double);
    void setAspectRatio(int, double);
    double aspectRatio(int) const;
    void setIntervalHint(int, const QwtDoubleInterval&);
    QwtDoubleInterval intervalHint(int) const;
    QwtPlotCanvas* canvas();
    // signature: const QwtPlotCanvas* canvas() const;
    QwtPlot* plot();
    // signature: const QwtPlot* plot() const;
    virtual bool eventFilter(QObject*, QEvent*);
    void rescale() const;
protected:
    virtual void canvasResizeEvent(QResizeEvent*);
    virtual void rescale(const QSize&, const QSize&) const;
    virtual QwtDoubleInterval expandScale(int, const QSize&, const QSize&) const;
    virtual QwtDoubleInterval syncScale(int, const QwtDoubleInterval&, const QSize&) const;
    virtual void updateScales(QwtDoubleInterval*) const;
    Qt::Orientation orientation(int) const;
    QwtDoubleInterval interval(int) const;
    QwtDoubleInterval expandInterval(const QwtDoubleInterval&, double, QwtPlotRescaler::ExpandingDirection) const;
}; // class QwtPlotRescaler


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
