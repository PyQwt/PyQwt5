// The code for the interface PyQwt <-> N-D array interface
// See: http://numpy.scipy.org/array_interface.shtml.
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


#ifndef HAS_NUMPY

#include <Python.h>
#include <qwt_ndarray.h>


// The NumPy Array Interface
typedef struct {
    int two;       
    int nd;            
    char typekind;     
    int itemsize;      
    int flags;         
    Py_intptr_t *shape; 
    Py_intptr_t *strides;
    void *data;
    PyObject *descr;
} PyArrayInterface;


void trace(PyArrayInterface *source)
{
    fprintf(stderr, "two: %i\n", source->two);
    fprintf(stderr, "nd: %i\n", source->nd);
    fprintf(stderr, "typekind: '%c'\n", source->typekind);
    fprintf(stderr, "itemsize: %i\n", source->itemsize);
    fprintf(stderr, "flags:");
    if (source->flags & 0x1) {
        fprintf(stderr, " CONTIGUOUS");
    }
    if (source->flags & 0x2) {
        fprintf(stderr, " FORTRAN");
    }
    if (source->flags & 0x100) {
        fprintf(stderr, " ALIGNED");
    }
    if (source->flags & 0x200) {
        fprintf(stderr, " NOTSWAPPED");
    }
    if (source->flags & 0x400) {
        fprintf(stderr, " WRITABLE");
    }
    if (source->flags & 0x800) {
        fprintf(stderr, " ARR_HAS_DESCR");
    }
    fprintf(stderr, "\n");
    fprintf(stderr, "shape: (");    
    if (source->nd==1) {
        fprintf(stderr, "%i,", int(source->shape[0]));
    } else if (source->nd>1) {
        fprintf(stderr, "%i", int(source->shape[0]));
    }
    for (int i=1; i<source->nd; ++i) {
        fprintf(stderr, ", %i", int(source->shape[0]));
    }
    fprintf(stderr, ")\n");
    fprintf(stderr, "strides: (");
    if (source->nd==1) {
        fprintf(stderr, "%i,", int(source->strides[0]));
    } else if (source->nd>1) {
        fprintf(stderr, "%i", int(source->strides[0]));
    }
    for (int i=1; i<source->nd; ++i) {
        fprintf(stderr, ", %i", int(source->strides[i]));
    }
    fprintf(stderr, ")\n");
}


int try_NDArray_to_QwtArray(PyObject *in, QwtArray<double> &out)
{
#ifdef TRACE_PYQWT
    fprintf(stderr, "Qwt: try_NDArray_to_QwtArray()\n");
#endif

    PyObject *csource = PyObject_GetAttrString(in, "__array_struct__");
    if (!csource) {
        return 0;
    }

    PyArrayInterface *source = 
        reinterpret_cast<PyArrayInterface *>(PyCObject_AsVoidPtr(csource));
    if (!source) {
        return 0;
    }

#ifdef TRACE_PYQWT
    trace(source);
#endif
        
    if ((source->two != 2)
        || (source->nd != 1)
        || (source->typekind != 'f')
        || (source->itemsize != sizeof(double))) {
        Py_DECREF(csource);
        PyErr_SetString(
            PyExc_RuntimeError,
            "The array is no contiguous 1D-array of double");
        return -1;
        }

    double *data = reinterpret_cast<double *>(source->data);
    out.resize(source->shape[0]);
    for (double *it = out.begin(); it != out.end();) {
        *it++ = *data++;
    }
    Py_DECREF(csource);

    return 1;
}


int try_NDArray_to_QwtArray(PyObject *in, QwtArray<int> &out)
{
#ifdef TRACE_PYQWT
    fprintf(stderr, "Qwt: try_NDArray_to_QwtArray()\n");
#endif

    PyObject *csource = PyObject_GetAttrString(in, "__array_struct__");
    if (!csource) {
        return 0;
    }

    PyArrayInterface *source = 
        reinterpret_cast<PyArrayInterface *>(PyCObject_AsVoidPtr(csource));
    if (!source) {
        return 0;
    }

#ifdef TRACE_PYQWT
    trace(source);
#endif
        
    if ((source->two != 2)
        || (source->nd != 1)
        || (source->typekind != 'f')
        || (source->itemsize != sizeof(double))) {
        Py_DECREF(csource);
        PyErr_SetString(
            PyExc_RuntimeError,
            "The array is no contiguous 1D-array of double");
        return -1;
    }

    int *data = reinterpret_cast<int *>(source->data);
    out.resize(source->shape[0]);
    for (int *it = out.begin(); it != out.end();) {
        *it++ = *data++;
    }
    Py_DECREF(csource);

    return 1;
}

int try_NDArray_to_QwtArray(PyObject *in, QwtArray<long> &out)
{
#ifdef TRACE_PYQWT
    fprintf(stderr, "Qwt: try_NumPyArray_to_QwtArray()\n");
#endif

    PyObject *csource = PyObject_GetAttrString(in, "__array_struct__");
    if (!csource) {
        return 0;
    }

    PyArrayInterface *source = 
        reinterpret_cast<PyArrayInterface *>(PyCObject_AsVoidPtr(csource));
    if (!source) {
        return 0;
    }
        
#ifdef TRACE_PYQWT
    trace(source);
#endif
        
    if ((source->two != 2)
        || (source->nd != 1)
        || (source->typekind != 'f')
        || (source->itemsize != sizeof(double))) {
        Py_DECREF(csource);
        PyErr_SetString(
            PyExc_RuntimeError,
            "The array is no contiguous 1D-array of double");
        return -1;
        }

    long *data = reinterpret_cast<long *>(source->data);
    out.resize(source->shape[0]);
    for (long *it = out.begin(); it != out.end();) {
        *it++ = *data++;
    }
    Py_DECREF(csource);

    return 1;
}


int try_NDArray_to_QImage(PyObject *in, QImage **out)
{
#ifdef TRACE_PYQWT
    fprintf(stderr, "Qwt: try_NDArray_to_QImage()\n");
#endif

    PyObject *csource = PyObject_GetAttrString(in, "__array_struct__");
    if (!csource) {
        return 0;
    }

    PyArrayInterface *source = 
        reinterpret_cast<PyArrayInterface *>(PyCObject_AsVoidPtr(csource));
    if (!source) {
        return 0;
    }

#ifdef TRACE_PYQWT
    trace(source);
#endif
        
    if ((source->two != 2) || (source->nd != 2)) {
        Py_DECREF(csource);
        PyErr_SetString(PyExc_RuntimeError,
                        "Image array must be 2-dimensional");
        return -1;
        }

    const int nx = source->shape[0];
    const int ny = source->shape[1];
    const int xstride = source->strides[0];
    const int ystride = source->strides[1];

    //  8 bit data
    if ((source->typekind =='u') && (source->itemsize==1)) {
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
            char *data = (char *)(source->data) + j*ystride;  
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

    // 32 bit data.
    // FIXME: what does it do on a 64 bit platform?
    // FIXME: endianness
    if ((source->typekind=='u') && (source->itemsize==4)) {
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
            char *data = (char *)(source->data) + j*ystride;  
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
    
    PyErr_SetString(PyExc_RuntimeError,
                    "Data type must be UnsignedInt8, or UnsignedInt32");

    return -1;
}

#endif // HAS_NUMPY

// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
