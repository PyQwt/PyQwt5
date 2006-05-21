#!/usr/bin/env python

try:
    import Qwt5.iqt
except ImportError:
    raise SystemExit, 'Grab.py requires the Qwt5.iqt module'

from qt import QPixmap

# a list of .py files defining a function make()
# make() must initialize, show and return:
#       a QWidget
# or:
#       a tuple of QWidgets
jobs = [
    'BarPlotDemo',
    'BodeDemo',
#    'CPUplot',
    'CliDemo',
    'CurveDemo1',
#    'CurveDemo2',
#    'CurveDemo3',
#    'DataDemo',
#    'DialDemo',
    'ErrorBarDemo',
#    'EventFilterDemo',
    'ImagePlotDemo',
    'MapDemo',
    'MultiDemo',
    'RadioDemo',
    'ReallySimpleDemo',
    'SimpleDemo',
    'SliderDemo',
    ]


def expose(jobs, cache = {}):
    for job in jobs:
        result = __import__(job).make()
        if type(result) == type(()):
            for i in range(len(result)):
                cache['%s%s' % (job, i)] = result[i]
        else:
            cache[job] = result
    return cache

# expose()


def save(cache):
    for name, widget in cache.items():
        pixmap = QPixmap.grabWidget(widget)
        pixmap.save(name+'.png', 'PNG')

# save()


def main():
    cache = expose(jobs)
    raw_input("Are all widgets looking HAPPY? ")
    save(cache)

# main()


if __name__ == '__main__':
    main()

# Local Variables: ***
# mode: python ***
# End: ***
