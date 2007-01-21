// The code for the interface PyQwt <-> numarray.
//
// Copyright (C) 2001-2007 Gerard Vermeulen
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


#ifdef HAS_NUMARRAY

#include <Python.h>
#include <numarray/arrayobject.h>
#include <qwt_numarray.h>


void qwt_import_numarray() {
    import_array();
}


int try_Contiguous_1D_NumarrayArray_of_double(
    PyObject *in, PyObject **out, double **doubles, int *n0)
{
#ifdef TRACE_PYQWT
    fprintf(
        stderr,
        "Qwt: try_Contiguous_1D_NumarrayArray_of_double()\n");
#endif

    if (!(PyArray_Check(in) || PyList_Check(in) || PyTuple_Check(in)))
        return 0;

    if ((*out = PyArray_ContiguousFromObject(in, PyArray_DOUBLE, 1, 1))) {
        *doubles = reinterpret_cast<double *>(
            reinterpret_cast<PyArrayObject *>(*out)->data);
        *n0 = reinterpret_cast<PyArrayObject *>(*out)->dimensions[0];

#ifdef TRACE_PYQWT
        fprintf(
            stderr,
            "Qwt: returning a 1D-array of PyArray_DOUBLE (%d,)\n",
            *n0);
#endif

        return 1;
    }

    PyErr_SetString(
        PyExc_RuntimeError,
        "Failed to make contiguous 1D-array of PyArray_DOUBLE");

    return -1;
}


int try_NumarrayArray_to_QwtArray(PyObject *in, QwtArray<double> &out)
{
#ifdef TRACE_PYQWT
    fprintf(stderr, "Qwt: try_NumarrayArray_to_QwtArray()\n");
#endif

    if (!PyArray_Check(in))
        return 0;

    PyArrayObject *array = (PyArrayObject *)PyArray_ContiguousFromObject(
        in, PyArray_DOUBLE, 1, 0);

    if (!array) {
        PyErr_SetString(PyExc_RuntimeError,
                        "Failed to make a contiguous array of PyArray_DOUBLE");
        return -1;
    }

    double *data = (double *) array->data;
    out.resize(array->dimensions[0]);
    for (double *it = out.begin(); it != out.end();) {
        *it++ = *data++;
    }

    Py_DECREF(array);

    return 1;
}


int try_NumarrayArray_to_QwtArray(PyObject *in, QwtArray<int> &out)
{
#ifdef TRACE_PYQWT
    fprintf(stderr, "Qwt: try_NumarrayArray_to_QwtArray()\n");
#endif

    if (!PyArray_Check(in))
        return 0;

    PyArrayObject *array = (PyArrayObject *)PyArray_ContiguousFromObject(
        in, PyArray_INT, 1, 0);

    if (!array) {
        PyErr_SetString(PyExc_RuntimeError,
                        "Failed to make a contiguous array of PyArray_INT");
        return -1;
    }

    int *data = (int *) array->data;
    out.resize(array->dimensions[0]);
    for (int *it = out.begin(); it != out.end();) {
        *it++ = *data++;
    }

    Py_DECREF(array);

    return 1;
}


int try_NumarrayArray_to_QwtArray(PyObject *in, QwtArray<long> &out)
{
#ifdef TRACE_PYQWT
    fprintf(stderr, "Qwt: try_NumarrayArray_to_QwtArray()\n");
#endif

    if (!PyArray_Check(in))
        return 0;

    PyArrayObject *array = (PyArrayObject *)PyArray_ContiguousFromObject(
        in, PyArray_LONG, 1, 0);

    if (!array) {
        PyErr_SetString(PyExc_RuntimeError,
                        "Failed to make a contiguous array of PyArray_LONG");
        return -1;
    }

    long *data = (long *) array->data;
    out.resize(array->dimensions[0]);
    for (long *it = out.begin(); it != out.end();) {
        *it++ = *data++;
    }

    Py_DECREF(array);

    return 1;
}

int try_NumarrayArray_to_QImage(PyObject *in, QImage **out)
{
    if (!PyArray_Check(in))
        return 0;

    if (2 != ((PyArrayObject *)in)->nd) {
        PyErr_SetString(PyExc_RuntimeError,
                        "Image array must be 2-dimensional");
        return -1;
    }

    int nx = ((PyArrayObject *)in)->dimensions[0];
    int ny = ((PyArrayObject *)in)->dimensions[1];
    int xstride = ((PyArrayObject *)in)->strides[0];
    int ystride = ((PyArrayObject *)in)->strides[1];

    //  8 bit data
    if (((PyArrayObject *)in)->descr->type_num == tUInt8) {
#if QT_VERSION < 0x040000
        if (!(*out = new QImage(nx, ny, 8, 256))) {
#else
        if (!(*out = new QImage(nx, ny, QImage::Format_Indexed8))) {
#endif
            PyErr_SetString(PyExc_RuntimeError,
                            "failed to create a 8 bit image");
            return -1;
        }
        for (int j=0; j<ny; j++) {
            char *line = (char *)((*out)->scanLine(j));
            char *data = ((PyArrayObject *)in)->data + j*ystride;
            for (int i=0; i<nx; i++) {
                *line++ = data[0];
                data += xstride;
            }
        }
        // initialize the palette as all gray
        (*out)->setNumColors(256);
        for (int i = 0; i<(*out)->numColors(); i++)
            (*out)->setColor(i, qRgb(i, i, i));
        return 1;
    }

    // 32 bit data
    // FIXME: what does it do on a 64 bit platform?
    // FIXME: endianness
    if (((PyArrayObject *)in)->descr->type_num == tUInt32) {
#if QT_VERSION < 0x040000
        if (!(*out = new QImage(nx, ny, 32))) {
#else
        if (!(*out = new QImage(nx, ny, QImage::Format_ARGB32))) {
#endif
            PyErr_SetString(PyExc_RuntimeError,
                            "failed to create a 32 bit image");
            return -1;
        }
        for (int j=0; j<ny; j++) {
            char *line = (char *)((*out)->scanLine(j));
            char *data = ((PyArrayObject *)in)->data + j*ystride;
            for (int i=0; i<nx; i++) {
                *line++ = data[0];
                *line++ = data[1];
                *line++ = data[2];
                *line++ = data[3];
                data += xstride;
            }
        }
        return 1;
    }

    PyErr_SetString(
        PyExc_RuntimeError, "Data type must be UInt8, or UInt32");

    return -1;
}


PyObject *toNumarray(const QImage &image)
{
    PyArrayObject *result = 0;
    const int nx = image.width();
    const int ny = image.height();

    // 8 bit data
    if (image.depth() == 8) {
        int dimensions[2] = { nx, ny };

        if (0 == (result = (PyArrayObject *)PyArray_FromDims(
                      2, dimensions, tUInt8))) {
            PyErr_SetString(PyExc_MemoryError,
                            "failed to allocate memory for array");
            return 0;
        }

        const int xstride = result->strides[0];
        const int ystride = result->strides[1];

        for (int j=0; j<ny; j++) {
            unsigned char *line = (unsigned char *)image.scanLine(j);
            unsigned char *data = (unsigned char *)(result->data + j*ystride);
            for (int i=0; i<nx; i++) {
                data[0] = *line++;
                data += xstride;
            }
        }
        return PyArray_Return(result);
    }

    // 32 bit data.
    if (image.depth() == 32) {
        int dimensions[2] = { nx, ny };

        if (0 == (result = (PyArrayObject *)PyArray_FromDims(
                      2, dimensions, tUInt32))) {
            PyErr_SetString(PyExc_MemoryError,
                            "failed to allocate memory for array");
            return 0;
        }

        const int xstride = result->strides[0];
        const int ystride = result->strides[1];

        for (int j=0; j<ny; j++) {
            unsigned char *line = (unsigned char *)image.scanLine(j);
            unsigned char *data = (unsigned char *)(result->data + j*ystride);
            for (int i=0; i<nx; i++) {
                data[0] = *line++;
                data[1] = *line++;
                data[2] = *line++;
                data[3] = *line++;
                data += xstride;
            }
        }
        return PyArray_Return(result);
    }
    return 0;
}


#endif // HAS_NUMARRAY

// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
