PyQwt Reference Guide
*********************

.. module:: PyQt4.Qwt5

:mod:`PyQt4.Qwt5`
=================

The reference should be used in conjunction with the
`Qwt manual <http://qwt.sourceforge.net>`_.
Only the differences specific to the Python bindings are documented here.

In this chapter, **is not yet implemented** implies that the feature can
be easily implemented if needed, **is not implemented** implies that the
feature is not easily implemented, and **is not Pythonic** implies that
the feature will not be implemented because it violates the Python philosophy
(e.g. may use dangling pointers).

If a class is described as being **is fully implemented** then all non-private
member functions and all public class variables have been implemented.

Undocumented classes have not yet been implemented or are still experimental.


.. class:: QwtAbstractScale

   is fully implemented.


.. class:: QwtAbstractScaleDraw

   is fully implemented.


.. class:: QwtAbstractSlider

   is fully implemented.


.. class:: QwtAlphaColorMap

   is fully implemented.


.. class:: QwtArrayData

   is fully implemented.


.. class:: QwtArrayDouble

   FIXME.


.. class:: QwtArrayInt

   FIXME.


.. class:: QwtArrayQwtDoubleInterval

   FIXME.


.. class:: QwtArrayQwtDoublePoint

   FIXME.


.. class:: QwtArrowButton

   is fully implemented.


.. class:: QwtClipper

   is fully implemented, but only available when PyQwt wraps Qwt-5.1.x.


.. class:: QwtColorMap

   is fully implemented.


.. class:: QwtCompass

   is fully implemented.


.. class:: QwtCompassMagnetNeedle

   is fully implemented.


.. class:: QwtCompassRose

   is fully implemented.


.. class:: QwtCompassWindArrow

   is fully implemented.


.. class:: QwtCounter

   is fully implemented.


.. class:: QwtCurveFitter

   is fully implemented.


.. class:: QwtData

   is fully implemented.


.. class:: QwtDial

   is fully implemented.


.. class:: QwtDialNeedle

   is fully implemented.


.. class:: QwtDialScaleDraw

   is fully implemented.


.. class:: QwtDialSimpleNeedle

   is fully implemented.


.. class:: QwtDoubleInterval

   is fully implemented.


.. class:: QwtDoublePoint

   is fully implemented, but only available when PyQt wraps Qt-3.
   When PyQt wraps Qt-4, replace this class with `QPointF`
   except for in signals. 
   For example, clicking in the canvas of the plot displayed by the
   following program::

       #!/usr/bin/env python

       import sys
       from PyQt4 import Qt
       import PyQt4.Qwt5 as Qwt

       def aSlot(aQPointF):
           print 'aSlot gets:', aQPointF

       # aSlot()

       def make():
           demo = Qwt.QwtPlot()
           picker = Qwt.QwtPlotPicker(Qwt.QwtPlot.xBottom,
                                      Qwt.QwtPlot.yLeft,
                                      Qwt.QwtPicker.PointSelection,
                                      Qwt.QwtPlotPicker.CrossRubberBand,
                                      Qwt.QwtPicker.AlwaysOn,
                                      demo.canvas())
           picker.connect(
               picker, Qt.SIGNAL('selected(const QwtDoublePoint&)'), aSlot)
           return demo

       # make()

       def main(args):
           app = Qt.QApplication(args)
           demo = make()
           demo.show()
           sys.exit(app.exec_())

       # main()

       if __name__ == '__main__':
           main(sys.argv)

       # Local Variables: ***
       # mode: python ***
       # End: ***

   shows that the signal returns an object of type `QPointF`::

       aSlot gets: <PyQt4.QtCore.QPointF object at 0x2aaaaf73be20>


.. class:: QwtDoubleRange

   is fully implemented.


.. class:: QwtDoubleRect

   FIXME


.. class:: QwtDoubleSize

   FIXME


.. class:: QwtDynGridLayout

   is fully implemented.


.. class:: QwtEventPattern

   is fully implemented.


.. class:: QwtIntervalData

   FIXME


.. class:: QwtKnob

   is fully implemented.


.. class:: QwtLegend

   is fully implemented.


.. class:: QwtLegendItem

   is fully implemented.


.. class:: QwtLegendItemManager

   is fully implemented, but only available when PyQwt wraps Qwt-5.1.x.


.. class:: QwtLinearColorMap

   is fully implemented.


.. class:: QwtLinearScaleEngine

   is fully implemented.


.. class:: QwtLog10ScaleEngine

   is fully implemented.


.. class:: QwtLegendMagnifier

   is fully implemented, but only available when PyQwt wraps Qwt-5.1.x.


.. class:: QwtMetricsMap

   is fully implemented.


.. class:: QwtPaintBuffer

   is fully implemented when PyQt wraps Qt-3.


.. class:: QwtPainter

   is fully implemented.


.. class:: QwtPanner

   is fully implemented.


.. class:: QwtPicker

   is fully implemented.


.. class:: QwtPickerClickPointMachine

   is fully implemented.


.. class:: QwtPickerClickRectMachine

   is fully implemented.


.. class:: QwtPickerDragPointMachine

   is fully implemented.


.. class:: QwtPickerDragRectMachine

   is fully implemented.


.. class:: QwtPickerMachine

   is fully implemented.


.. class:: QwtPickerPolygonMachine

   is fully implemented.


.. class:: QwtPlainTextEngine

   is fully implemented.


.. class:: QwtPlot

   is fully implemented, but:

   .. cfunction:: void print(QPrinter &printer, const QwtPlotPrintFilter &filter) 

      is implemented as::

         plot.print_(printer, filter)

   .. cfunction::  void print(QPainter *painter, const QRect &rect, const QwtPlotPrintFilter &filter)

      is implemented as::

         plot.print_(painter, rect, filter)


.. class:: QwtPlotCanvas

   is fully implemented.


.. class:: QwtPlotCurve

   is fully implemented, but:

   .. cfunction:: void setData(double *x, double *y, int size)
   
      is implemented as::

        curve.setData(x, y)

      where `x` and `y` can be any combination of lists, tuples and
      Numerical Python arrays.  The data is copied to C++ data types.

   .. cfunction:: void setRawData(double *x, double *y, int size)

      is not Pythonic.


.. class:: QwtPlotDict

   is fully implemented. FIXME: is the auto delete feature dangerous?


.. class:: QwtPlotGrid

   is fully implemented.


.. class:: QwtPlotItem

   is fully implemented.


.. class:: QwtPlotLayout

   is fully implemented.


.. class:: QwtPlotMagnifier

   is fully implemented.


.. class:: QwtPlotMarker

   is fully implemented.


.. class:: QwtPlotPanner

   is fully implemented.


.. class:: QwtPlotPicker

   is fully implemented, but:

   .. cfunction:: QwtText trackerText(QwtDoublePoint &point)

      is implemented as::

         qwtText = plotPicker.trackerTextF(point)

      where `point` is a `QwtDoublePoint` when PyQt wraps Qt-3 or a
      `QPointF` when PyQt wraps Qt-4.


.. class:: QwtPlotPrintFilter

   is fully implemented.


.. class:: QwtPlotRasterItem

   is fully implemented.


.. class:: QwtPlotScaleItem

   is fully implemented, but only available when PyQwt wraps Qwt-5.1.x.


.. class:: QwtPlotSpectrogram

   FIXME: protected methods.


.. class:: QwtPlotSvgItem

   is fully implemented.


.. class:: QwtPlotZoomer

   is fully implemented.


.. class:: QwtPolygon

  When PyQwt has been built for Qt-3, replace this class with
  \class{QPointArray} except for in signals. See \class{QwtDoublePoint}.

  When PyQwt has been built for Qt-4, replace this class with \class{QPolygon}
  except for in signals. See \class{QwtDoublePoint}.


.. class:: QwtPolygonFData

   is fully implemented.


.. class:: QwtRasterData

   is fully implemented.


.. class:: QwtRect

   is fully implemented.


.. class:: QwtRichTextEngine

   is fully implemented.


.. class:: QwtRoundScaleDraw

   is fully implemented.


.. class:: QwtScaleArithmic

   is fully implemented.


.. class:: QwtScaleDiv

   .. cfunction:: QwtScaleDiv(const QwtDoubleInterval&, QwtValueList[NTickList])

      is implemented as::

        scaleDiv = QwtScaleDiv(
            qwtDoubleInterval, majorTicks, mediumTicks, minorTicks)

   .. cfunction:: QwtScaleDiv(double, double, QwtTickList[NTickList])

      is implemented as::

        scaleDiv = QwtScaleDiv(
            lower, upper, majorTicks, mediumTicks, minorTicks)


.. class:: QwtScaleDraw

   is fully implemented.


.. class:: QwtScaleEngine

   is fully implemented.


.. class:: QwtScaleMap

   is fully implemented.

   .. cfunction:: QwtScaleMap(int, int, double, double)

      does not exist in C++, but is provided by PyQwt.


.. class:: QwtScaleTransformation

   is fully implemented.


.. class:: QwtScaleWidget

   is fully implemented.


.. class:: QwtSimpleCompassRose

   is fully implemented.


.. class:: QwtSlider

   is fully implemented.


.. class:: QwtSpline

   is fully implemented.


.. class:: QwtSplineCurveFitter

   is fully implemented.


.. class:: QwtSymbol

   is fully implemented.


.. class:: QwtText

   is fully implemented.


.. class:: QwtTextEngine

   is fully implemented.


.. class:: QwtTextLabel

   is fully implemented.


.. class:: QwtThermo

   is fully implemented.


.. class:: QwtWheel

   is fully implemented.


:mod:`PyQt4.Qwt5.qplt`
======================

.. automodule:: PyQt4.Qwt5.qplt

.. autoclass:: Axis
   :members:

.. autoclass:: Curve
   :members:

.. autoclass:: IPlot
   :members:

.. autoclass:: Pen
   :members:

.. autoclass:: Plot
   :members:

.. autoclass:: Symbol
   :members:

:mod:`PyQt4.Qwt5.grace`
=======================

.. automodule:: PyQt4.Qwt5.grace

.. autoclass:: GraceProcess
   :members:
