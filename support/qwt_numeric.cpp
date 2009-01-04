// The code for the interface PyQwt <-> Numeric.
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


#ifdef HAS_NUMERIC

#include <Python.h>
#include <Numeric/arrayobject.h>
#include <qwt_numeric.h>

// steal those handy macro's from numpy
#define PyArray_NDIM(obj) (((PyArrayObject *)(obj))->nd)
#define PyArray_DATA(obj) ((void *)(((PyArrayObject *)(obj))->data))
#define PyArray_BYTES(obj) (((PyArrayObject *)(obj))->data)
#define PyArray_DIMS(obj) (((PyArrayObject *)(obj))->dimensions)
#define PyArray_STRIDES(obj) (((PyArrayObject *)(obj))->strides)
#define PyArray_DIM(obj,n) (PyArray_DIMS(obj)[n])
#define PyArray_STRIDE(obj,n) (PyArray_STRIDES(obj)[n])
#define PyArray_TYPE(obj) (((PyArrayObject *)(obj))->descr->type_num)


void qwt_import_numeric() {
    import_array();
}


int try_NumericArray_to_QwtArray(PyObject *in, QwtArray<double> &out)
{
#ifdef TRACE_PYQWT
    fprintf(stderr, "Qwt: try_NumericArray_to_QwtArray()\n");
#endif

    if (!PyArray_Check(in))
        return 0;

    PyObject *array = PyArray_ContiguousFromObject(in, PyArray_DOUBLE, 1, 0);

    if (!array) {
        PyErr_SetString(PyExc_RuntimeError,
                        "Failed to make contiguous array of PyArray_DOUBLE");
        return -1;
    }

    double *data = (double *) PyArray_DATA(array);
    out.resize(PyArray_DIM(array, 0));
    for (double *it = out.begin(); it != out.end();) {
        *it++ = *data++;
    }

    Py_DECREF(array);

    return 1;
}


int try_NumericArray_to_QwtArray(PyObject *in, QwtArray<int> &out)
{
#ifdef TRACE_PYQWT
    fprintf(stderr, "Qwt: try_NumericArray_to_QwtArray()\n");
#endif

    if (!PyArray_Check(in))
        return 0;

    PyObject *array = PyArray_ContiguousFromObject(in, PyArray_INT, 1, 0);

    if (!array) {
        PyErr_SetString(PyExc_RuntimeError,
                        "Failed to make contiguous array of PyArray_INT");
        return -1;
    }

    int *data = (int *) PyArray_DATA(array);
    out.resize(PyArray_DIM(array, 0));
    for (int *it = out.begin(); it != out.end();) {
        *it++ = *data++;
    }

    Py_DECREF(array);

    return 1;
}


int try_NumericArray_to_QwtArray(PyObject *in, QwtArray<long> &out)
{
#ifdef TRACE_PYQWT
    fprintf(stderr, "Qwt: try_NumericArray_to_QwtArray()\n");
#endif

    if (!PyArray_Check(in))
        return 0;

    PyObject *array = PyArray_ContiguousFromObject(in, PyArray_LONG, 1, 0);

    if (!array) {
        PyErr_SetString(PyExc_RuntimeError,
                        "Failed to make contiguous array of PyArray_LONG");
        return -1;
    }

    long *data = (long *) PyArray_DATA(array);
    out.resize(PyArray_DIM(array, 0));
    for (long *it = out.begin(); it != out.end();) {
        *it++ = *data++;
    }

    Py_DECREF(array);

    return 1;
}

int try_NumericArray_to_QImage(PyObject *in, QImage **out)
{
#ifdef TRACE_PYQWT
    fprintf(stderr, "Qwt: try_NumericArray_to_QImage()\n");
#endif

    if (!PyArray_Check(in))
        return 0;
    
    if (2 != PyArray_NDIM(in)) {
        PyErr_SetString(PyExc_RuntimeError, "Array must be 2-dimensional");
        return -1;
    }
    
    const int ny = PyArray_DIM(in, 0);
    const int nx = PyArray_DIM(in, 1);
    const int stride = PyArray_STRIDE(in, 0);
    
    //  8 bit data
    if (PyArray_TYPE(in) == PyArray_UBYTE) {
#if QT_VERSION < 0x040000
        if (!(*out = new QImage(nx, ny, 8, 256))) {
#else
        if (!(*out = new QImage(nx, ny, QImage::Format_Indexed8))) {
#endif
            PyErr_SetString(PyExc_RuntimeError, "failed to create a QImage");
            return -1;
        }
        char *data = PyArray_BYTES(in);
        for (int i=0; i<ny; i++) {
            memcpy((*out)->scanLine(i), data, stride);
            data += stride;
        }
        // initialize the palette as all gray
        (*out)->setNumColors(256);
        for (int i = 0; i<(*out)->numColors(); i++)
            (*out)->setColor(i, qRgb(i, i, i));
        return 1;
    }

    // 32 bit data.
    if (PyArray_TYPE(in) == PyArray_UINT) {
#if QT_VERSION < 0x040000
        if (!(*out = new QImage(nx, ny, 32))) {
#else
        if (!(*out = new QImage(nx, ny, QImage::Format_ARGB32))) {
#endif
            PyErr_SetString(PyExc_RuntimeError, "failed to create a QImage");
            return -1;
        }
        char *data = PyArray_BYTES(in);
        for (int i=0; i<ny; i++) {
            memcpy((*out)->scanLine(i), data, stride);
            data += stride;
        }        
        return 1;
    }
    
    PyErr_SetString(PyExc_RuntimeError, "Data type must be uint8, or uint32");
    
    return -1;
}


PyObject *toNumeric(const QImage &image)
{
    PyObject *result = 0;
    const int ny = image.height();
    const int nx = image.width();
    int dimensions[2] = {ny, nx};

    if (image.depth() == 8) { // 8 bit data
        if (0 == (result = PyArray_FromDims(2, dimensions, PyArray_UBYTE))) {
            PyErr_SetString(PyExc_MemoryError, "failed to allocate array");
            return 0;
        }
    } else if (image.depth() == 32) { // 32 bit data
        if (0 == (result = PyArray_FromDims(2, dimensions, PyArray_UINT))) {
            PyErr_SetString(PyExc_MemoryError, "failed to allocate array");
            return 0;
        }
    } else {
        PyErr_SetString(PyExc_RuntimeError, "Image depth must be 8 or 32");
        return 0;        
    }

    char *data = PyArray_BYTES(result);
    const int stride = PyArray_STRIDE(result, 0);
    for (int i=0; i<ny; i++) {
        memcpy(data, image.scanLine(i), stride);
        data += stride;
    }

    return PyArray_Return((PyArrayObject *)result);
}

#endif // HAS_NUMERIC

// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
