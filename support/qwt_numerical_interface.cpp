// The code for the interface PyQwt <-> Numerical Python extensions.
//
// Copyright (C) 2001-2009 Gerard Vermeulen
// Copyright (C) 2000 Mark Colclough
//
// This file is part of PyQwt.
//
// PyQwt is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
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


#include <qwt_ndarray.h>
#include <qwt_numerical_interface.h>
#include <qwt_numarray.h>
#include <qwt_numeric.h>
#include <qwt_numpy.h>


static int try_PySequence_to_QwtArray(PyObject *in, QwtArray<double> &out)
{
    if (!PyList_Check(in) && !PyTuple_Check(in))
        return 0;

    // MSVC-6.0 chokes on passing an uint in QwtArray<double>::operator[](int)
    int size = PySequence_Size(in);
    out.resize(size);

    for (int i=0; i<size; i++) {
        PyObject *element = PySequence_Fast_GET_ITEM(in, i);
        if (PyFloat_Check(element)) {
            out[i] = PyFloat_AsDouble(element);
#if PY_MAJOR_VERSION < 3
        } else if (PyInt_Check(element)) {
            out[i] = double(PyInt_AsLong(element));
#endif
        } else if (PyLong_Check(element)) {
            out[i] = PyLong_AsDouble(element);
        } else {
            PyErr_SetString(
                PyExc_TypeError,
                "The sequence may only contain float, int, or long types.");

            return -1;
        }
    }

    return 1;
}

int try_PyObject_to_QwtArray(PyObject *in, QwtArray<double> &out)
{
    int result;

#ifdef HAS_NUMPY
    if ((result = try_NumPyArray_to_QwtArray(in, out)))
        return result;
#endif

#ifdef HAS_NUMERIC
    if ((result = try_NumericArray_to_QwtArray(in, out)))
        return result;
#endif

#ifdef HAS_NUMARRAY
    if ((result = try_NumarrayArray_to_QwtArray(in, out)))
        return result;
#endif

    if ((result = try_NDArray_to_QwtArray(in, out)))
        return result;

    if ((result = try_PySequence_to_QwtArray(in, out)))
        return result;

    PyErr_SetString(PyExc_TypeError, "expected is\n"
                    "(*) a list or tuple of Python numbers.\n"
                    "(*) an array with the N-D array interface.\n"
#ifdef HAS_NUMPY
                    "(*) a NumPy array coercible to PyArray_DOUBLE.\n"
#else
                    "(!) rebuild PyQwt to support NumPy arrays.\n"
#endif
#ifdef HAS_NUMERIC
                    "(*) a Numeric array coercible to PyArray_DOUBLE.\n"
#else
                    "(!) rebuild PyQwt to support Numeric arrays.\n"
#endif
#ifdef HAS_NUMARRAY
                    "(*) a numarray array coercible to PyArray_DOUBLE.\n"
#else
                    "(!) rebuild PyQwt to support numarray arrays.\n"
#endif
        );

    return -1;
}


static int try_PySequence_to_QwtArray(PyObject *in, QwtArray<int> &out)
{
    if (!PyList_Check(in) && !PyTuple_Check(in))
        return 0;

    // MSVC-6.0 chokes on passing an uint in QwtArray<double>::operator[](int)
    int size = PySequence_Size(in);
    out.resize(size);

    for (int i=0; i<size; i++) {
        PyObject *element = PySequence_Fast_GET_ITEM(in, i);
        if (PyFloat_Check(element)) {
            out[i] = int(PyFloat_AsDouble(element));
#if PY_MAJOR_VERSION < 3
        } else if (PyInt_Check(element)) {
            out[i] = int(PyInt_AsLong(element));
#endif
        } else if (PyLong_Check(element)) {
            out[i] = int(PyLong_AsLong(element));
        } else {
            PyErr_SetString(
                PyExc_TypeError,
                "The sequence may only contain float, int, or long types.");

            return -1;
        }
    }

    return 1;
}


int try_PyObject_to_QwtArray(PyObject *in, QwtArray<int> &out)
{
    int result;

#ifdef HAS_NUMPY
    if ((result = try_NumPyArray_to_QwtArray(in, out)))
        return result;
#endif

#ifdef HAS_NUMERIC
    if ((result = try_NumericArray_to_QwtArray(in, out)))
        return result;
#endif

#ifdef HAS_NUMARRAY
    if ((result = try_NumarrayArray_to_QwtArray(in, out)))
        return result;
#endif

    if ((result = try_NDArray_to_QwtArray(in, out)))
        return result;

    if ((result = try_PySequence_to_QwtArray(in, out)))
        return result;

    PyErr_SetString(PyExc_TypeError, "expected is\n"
                    "(*) a list or tuple of Python numbers.\n"
                    "(*) an array with the N-D array interface.\n"
#ifdef HAS_NUMPY
                    "(*) a NumPy array coercible to PyArray_INT.\n"
#else
                    "(!) rebuild PyQwt to support NumPy arrays.\n"
#endif
#ifdef HAS_NUMERIC
                    "(*) a Numeric array coercible to PyArray_INT.\n"
#else
                    "(!) rebuild PyQwt to support Numeric arrays.\n"
#endif
#ifdef HAS_NUMARRAY
                    "(*) a numarray array coercible to PyArray_INT.\n"
#else
                    "(!) rebuild PyQwt to support numarray arrays.\n"
#endif
        );

    return -1;
}


static int try_PySequence_to_QwtArray(PyObject *in, QwtArray<long> &out)
{
    if (!PyList_Check(in) && !PyTuple_Check(in))
        return 0;

    // MSVC-6.0 chokes on passing an uint in QwtArray<double>::operator[](int)
    int size = PySequence_Size(in);
    out.resize(size);

    for (int i=0; i<size; i++) {
        PyObject *element = PySequence_Fast_GET_ITEM(in, i);
        if (PyFloat_Check(element)) {
            out[i] = long(PyFloat_AsDouble(element));
#if PY_MAJOR_VERSION < 3
        } else if (PyInt_Check(element)) {
            out[i] = PyInt_AsLong(element);
#endif
        } else if (PyLong_Check(element)) {
            out[i] = PyLong_AsLong(element);
        } else {
            PyErr_SetString(
                PyExc_TypeError,
                "The sequence may only contain float, int, or long types.");

            return -1;
        }
    }

    return 1;
}


int try_PyObject_to_QwtArray(PyObject *in, QwtArray<long> &out)
{
    int result;

#ifdef HAS_NUMPY
    if ((result = try_NumPyArray_to_QwtArray(in, out)))
        return result;
#endif

#ifdef HAS_NUMERIC
    if ((result = try_NumericArray_to_QwtArray(in, out)))
        return result;
#endif

#ifdef HAS_NUMARRAY
    if ((result = try_NumarrayArray_to_QwtArray(in, out)))
        return result;
#endif

    if ((result = try_NDArray_to_QwtArray(in, out)))
        return result;

    if ((result = try_PySequence_to_QwtArray(in, out)))
        return result;

    PyErr_SetString(PyExc_TypeError, "expected is\n"
                    "(*) a list or tuple of Python numbers.\n"
                    "(*) an array with the N-D array interface.\n"
#ifdef HAS_NUMPY
                    "(*) a NumPy array coercible to PyArray_INT.\n"
#else
                    "(!) rebuild PyQwt to support NumPy arrays.\n"
#endif
#ifdef HAS_NUMERIC
                    "(*) a Numeric array coercible to PyArray_INT.\n"
#else
                    "(!) rebuild PyQwt to support Numeric arrays.\n"
#endif
#ifdef HAS_NUMARRAY
                    "(*) a numarray array coercible to PyArray_INT.\n"
#else
                    "(!) rebuild PyQwt to support numarray arrays.\n"
#endif
        );

    return -1;
}


int try_PyObject_to_QImage(PyObject *in, QImage **out)
{
    int result;

#ifdef HAS_NUMPY
    if ((result = try_NumPyArray_to_QImage(in, out)))
        return result;
#endif

#ifdef HAS_NUMERIC
    if ((result = try_NumericArray_to_QImage(in, out)))
        return result;
#endif

#ifdef HAS_NUMARRAY
    if ((result = try_NumarrayArray_to_QImage(in, out)))
        return result;
#endif

    if ((result = try_NDArray_to_QImage(in, out)))
        return result;

    PyErr_SetString(PyExc_TypeError, "expected is\n"
                    "(*) an array with the N-D array interface.\n"
#ifdef HAS_NUMPY
                    "(*) a NumPy array.\n"
#else
                    "(!) rebuild PyQwt to support NumPy arrays.\n"
#endif
#ifdef HAS_NUMERIC
                    "(*) a Numeric array.\n"
#else
                    "(!) rebuild PyQwt to support Numeric arrays.\n"
#endif
#ifdef HAS_NUMARRAY
                    "(*) a numarray array.\n"
#else
                    "(!) rebuild PyQwt to support numarray arrays.\n"
#endif
        );

    return -1;
}

// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
