// The code for the interface PyQwt <-> N-D array interface
// See: http://numpy.scipy.org/array_interface.shtml.
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


enum {
    CONTIGUOUS = 0x1,
    FORTRAN = 0x2,
    ALIGNED = 0x100,
    NOTSWAPPED = 0x200,
    WRITABLE = 0x400,
    ARR_HAS_DESCR = 0x800,
};


void trace(PyArrayInterface *source)
{
    fprintf(stderr, "two: %i\n", source->two);
    fprintf(stderr, "nd: %i\n", source->nd);
    fprintf(stderr, "typekind: '%c'\n", source->typekind);
    fprintf(stderr, "itemsize: %i\n", source->itemsize);
    fprintf(stderr, "flags:");
    if (source->flags & CONTIGUOUS) {
        fprintf(stderr, " CONTIGUOUS");
    }
    if (source->flags & FORTRAN) {
        fprintf(stderr, " FORTRAN");
    }
    if (source->flags & ALIGNED) {
        fprintf(stderr, " ALIGNED");
    }
    if (source->flags & NOTSWAPPED) {
        fprintf(stderr, " NOTSWAPPED");
    }
    if (source->flags & WRITABLE) {
        fprintf(stderr, " WRITABLE");
    }
    if (source->flags & ARR_HAS_DESCR) {
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
    fprintf(stderr, "Qwt: try_NDArray_to_QwtArray() // QwtArray<double>\n");
#endif

    if (!PyObject_HasAttrString(in, "__array_struct__")) {
        return 0;
    }

    PyObject *csource = PyObject_GetAttrString(in, "__array_struct__");
    if (!csource) { // FIXME
        return 0;
    }

    PyArrayInterface *source = 
        reinterpret_cast<PyArrayInterface *>(PyCObject_AsVoidPtr(csource));
    if (!source) { // FIXME
        return 0;
    }

#ifdef TRACE_PYQWT
    trace(source);
#endif
    
    int stride;

    if ((source->two != 2)|| (source->nd != 1)) {
        goto error;
    }

    stride = source->strides[0]/source->itemsize;
    out.resize(source->shape[0]);
    if (source->typekind == 'f') {
        if (source->itemsize == sizeof(double)) {
            double *data = reinterpret_cast<double *>(source->data);
            for (double *it = out.begin(); it != out.end();) {
                *it++ = *data;
                data += stride;
            }
        } else if (source->itemsize == sizeof(float)) {
            float *data = reinterpret_cast<float *>(source->data);
            for (double *it = out.begin(); it != out.end();) {
                *it++ = *data;
                data += stride;
            }
        } else {
            goto error;
        }
    } else if (source->typekind == 'i') {
        if (source->itemsize == sizeof(char)) {
            char *data = reinterpret_cast<char *>(source->data);
            for (double *it = out.begin(); it != out.end();) {
                *it++ = *data;
                data += stride;
            }
        } else if (source->itemsize == sizeof(short)) {
            short *data = reinterpret_cast<short *>(source->data);
            for (double *it = out.begin(); it != out.end();) {
                *it++ = *data;
                data += stride;
            }
        } else if (source->itemsize == sizeof(int)) {
            int *data = reinterpret_cast<int *>(source->data);
            for (double *it = out.begin(); it != out.end();) {
                *it++ = *data;
                data += stride;
            }
        } else if (source->itemsize == sizeof(long)) {
            long *data = reinterpret_cast<long *>(source->data);
            for (double *it = out.begin(); it != out.end();) {
                *it++ = *data;
                data += stride;
            }
        } else if (source->itemsize == sizeof(long long)) {
            long long *data = reinterpret_cast<long long *>(source->data);
            for (double *it = out.begin(); it != out.end();) {
                *it++ = *data;
                data += stride;
            }
        } else {
            goto error;
        }
    } else {
        goto error;
    }
 
    Py_DECREF(csource);
    return 1;

error:
    Py_DECREF(csource);
    PyErr_SetString(
        PyExc_RuntimeError,
        "The array is no 1D array containing real or signed integer types");
    return -1;
}


int try_NDArray_to_QwtArray(PyObject *in, QwtArray<int> &out)
{
#ifdef TRACE_PYQWT
    fprintf(stderr, "Qwt: try_NDArray_to_QwtArray() // QwtArray<int>\n");
#endif

    if (!PyObject_HasAttrString(in, "__array_struct__")) {
        return 0;
    }

    PyObject *csource = PyObject_GetAttrString(in, "__array_struct__");
    if (!csource) { // FIXME
        return 0;
    }

    PyArrayInterface *source = 
        reinterpret_cast<PyArrayInterface *>(PyCObject_AsVoidPtr(csource));
    if (!source) { // FIXME
        return 0;
    }

#ifdef TRACE_PYQWT
    trace(source);
#endif

    int stride;

    if ((source->two != 2) || (source->nd != 1)) {
        goto error;
    }

    out.resize(source->shape[0]);
    stride = source->strides[0]/source->itemsize;
    if (source->typekind == 'i') {
        if (source->itemsize == sizeof(char)) {
            char *data = reinterpret_cast<char *>(source->data);
            for (int *it = out.begin(); it != out.end();) {
                *it++ = *data;
                data += stride;
            }
        } else if (source->itemsize == sizeof(short)) {
            short *data = reinterpret_cast<short *>(source->data);
            for (int *it = out.begin(); it != out.end();) {
                *it++ = *data;
                data += stride;
            }
        } else if (source->itemsize == sizeof(int)) {
            int *data = reinterpret_cast<int *>(source->data);
            for (int *it = out.begin(); it != out.end();) {
                *it++ = *data;
                data += stride;
            }
        } else if (source->itemsize == sizeof(long)) {
            long *data = reinterpret_cast<long *>(source->data);
            for (int *it = out.begin(); it != out.end();) {
                *it++ = *data;
                data += stride;
            }
        } else if (source->itemsize == sizeof(long long)) {
            long long *data = reinterpret_cast<long long *>(source->data);
            for (int *it = out.begin(); it != out.end();) {
                *it++ = *data;
                data += stride;
            }
        } else {
            goto error;
        }
    } else {
        goto error;
    }

    Py_DECREF(csource);
    return 1;

error:
    Py_DECREF(csource);
    PyErr_SetString(
        PyExc_RuntimeError,
        "The array is no 1D array containing signed integer types");
    return -1;
}

int try_NDArray_to_QwtArray(PyObject *in, QwtArray<long> &out)
{
#ifdef TRACE_PYQWT
    fprintf(stderr, "Qwt: try_NumPyArray_to_QwtArray() // QwtArray<long>\n");
#endif

    if (!PyObject_HasAttrString(in, "__array_struct__")) {
        return 0;
    }

    PyObject *csource = PyObject_GetAttrString(in, "__array_struct__");
    if (!csource) { // FIXME
        return 0;
    }

    PyArrayInterface *source = 
        reinterpret_cast<PyArrayInterface *>(PyCObject_AsVoidPtr(csource));
    if (!source) { // FIXME
        return 0;
    }
        
#ifdef TRACE_PYQWT
    trace(source);
#endif
        
    int stride;

    if ((source->two != 2) || (source->nd != 1)) {
        goto error;
    }

    out.resize(source->shape[0]);
    stride = source->strides[0]/source->itemsize;
    if (source->typekind == 'i') {
        if (source->itemsize == sizeof(char)) {
            char *data = reinterpret_cast<char *>(source->data);
            for (long *it = out.begin(); it != out.end();) {
                *it++ = *data;
                data += stride;
            }
        } else if (source->itemsize == sizeof(short)) {
            short *data = reinterpret_cast<short *>(source->data);
            for (long *it = out.begin(); it != out.end();) {
                *it++ = *data;
                data += stride;
            }
        } else if (source->itemsize == sizeof(int)) {
            int *data = reinterpret_cast<int *>(source->data);
            for (long *it = out.begin(); it != out.end();) {
                *it++ = *data;
                data += stride;
            }
        } else if (source->itemsize == sizeof(long)) {
            long *data = reinterpret_cast<long *>(source->data);
            for (long *it = out.begin(); it != out.end();) {
                *it++ = *data;
                data += stride;
            }
        } else if (source->itemsize == sizeof(long long)) {
            long long *data = reinterpret_cast<long long *>(source->data);
            for (long *it = out.begin(); it != out.end();) {
                *it++ = *data;
                data += stride;
            }
        } else {
            goto error;
        }
    } else {
        goto error;
    }

    Py_DECREF(csource);
    return 1;

error:
    Py_DECREF(csource);
    PyErr_SetString(
        PyExc_RuntimeError,
        "The array is no 1D array containing signed integer types");
    return -1;
}


int try_NDArray_to_QImage(PyObject *in, QImage **out)
{
#ifdef TRACE_PYQWT
    fprintf(stderr, "Qwt: try_NDArray_to_QImage()\n");
#endif

    if (!PyObject_HasAttrString(in, "__array_struct__")) {
        return 0;
    }

    PyObject *csource = PyObject_GetAttrString(in, "__array_struct__");
    if (!csource) { // FIXME
        return 0;
    }

    PyArrayInterface *source = 
        reinterpret_cast<PyArrayInterface *>(PyCObject_AsVoidPtr(csource));
    if (!source) { // FIXME
        return 0;
    }

#ifdef TRACE_PYQWT
    trace(source);
#endif
        
    if (!((source->two==2) && (source->nd==2) && (source->flags&CONTIGUOUS))) {
        Py_DECREF(csource);
        PyErr_SetString(PyExc_RuntimeError, "Array must be contiguous and 2-D");
        return -1;
        }

    const Py_intptr_t ny = source->shape[0];
    const Py_intptr_t nx = source->shape[1];
    const Py_intptr_t stride = source->strides[0];

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
        char *data = static_cast<char *>(source->data);  
        for (int i=0; i<ny; i++) {
            memcpy((*out)->scanLine(i), data, stride);
            data += stride;
        }
        // initialize the palette as all gray
        (*out)->setNumColors(256);
        for (int i = 0; i<(*out)->numColors(); i++) {
            (*out)->setColor(i, qRgb(i, i, i));
        }
        Py_DECREF(csource);
        return 1;
    }

    // 32 bit data
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
        
        char *data = static_cast<char *>(source->data);  
        for (int i=0; i<ny; i++) {
            memcpy((*out)->scanLine(i), data, stride);
            data += stride;
        }
        Py_DECREF(csource);
        return 1;
    }
    
    PyErr_SetString(PyExc_RuntimeError, "Data type must be uint8 or uint32");
    Py_DECREF(csource);

    return -1;
}

// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
