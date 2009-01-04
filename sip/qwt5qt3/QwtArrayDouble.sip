// The SIP interface specification for:
//      QwtArrayDouble.
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


class QwtArrayDouble
{

%TypeHeaderCode
#include <qwt_array.h>
typedef QwtArray<double> QwtArrayDouble;
%End // %TypeHeaderCode

public:
    QwtArrayDouble();
    QwtArrayDouble(int);
    QwtArrayDouble(const QwtArrayDouble &);
    QwtArrayDouble(SIP_PYOBJECT); 
%MethodCode
    QwtArray<double> array;
    // Numeric is not thread-safe
    if (-1 == try_PyObject_to_QwtArray(a0, array))
        return 0;

    sipCpp = new QwtArrayDouble(array);
%End // QwtArrayDouble()
    ~QwtArrayDouble(); 
    // not possible: QwtArray<type> &operator=(const QArray<type> &); 
    // not Pythonic: type *data() const;
    // not Pythonic: uint nrefs() const; 
    uint size() const;
    uint count() const;
    bool isEmpty() const;
    bool isNull() const;
    bool resize(uint);
    bool truncate(uint);
    bool fill(const double, int = -1);
    void detach();
    QwtArrayDouble copy() const;
    QwtArrayDouble & assign(const QwtArrayDouble &);
    // not Pythonic: QwtArray<type> & assign(const type *, uint); 
    QwtArrayDouble & duplicate(const QwtArrayDouble &);
    // not Pythonic: QwtArray<type> & duplicate(const type *, uint); 
    // not Pythonic: QwtArray<type> & setRawData(const type *, uint);
    // not Pythonic: void resetRawData(const type *, uint);
    int find(const double &, uint = 0) const;
    int contains(const double &) const;
    void sort();
    int bsearch(const double &) const;
    // see __getitem__: type & operator[](int) const;
    double /* & */ at(uint) const;
    // pulls in unwanted operators: bool operator==(const QwtArrayDouble &) const;
    // pulls in unwanted operators: bool operator!=(const QwtArrayDouble &) const;
    // No iterators, yet: Iterator begin();
    // No iterators, yet: Iterator end();
    // No iterators, yet: ConstIterator begin() const;
    // No iterators, yet: ConstIterator end() const;

    double __getitem__(int);
%MethodCode
    int len = sipCpp -> size();
    
    if (0 > (a0 = sipConvertFromSequenceIndex(a0, len)))
        sipIsErr = 1;
    else
        sipRes = (*sipCpp)[a0];
%End // __getitem__()

    int __len__() const;
%MethodCode
    sipRes = sipCpp -> size();
%End // __len__()

    void __setitem__(int, double);
%MethodCode
    int len = sipCpp -> size();

    if (0 > (a0 = sipConvertFromSequenceIndex(a0, len)))
        sipIsErr = 1;
    else
        (*sipCpp)[a0] = a1;
%End // __setitem__()

    void __setitem__(SIP_PYSLICE, const QwtArrayDouble &);
%MethodCode
    int len = sipCpp -> size();
    Py_ssize_t start, stop, step, slicelength;

    if (0 > sipConvertFromSliceObject(a0, len,
                                      &start, &stop, &step, &slicelength))
        sipIsErr = 1;
    else {
        int vlen = a1 -> size();

        if (vlen != slicelength) {
            sipBadLengthForSlice(vlen, slicelength);
            sipIsErr = 1;
        } else {
            QwtArrayDouble::ConstIterator it = a1 -> begin();

            for (int i = 0; i < slicelength; ++i) {
                (*sipCpp)[int(start)] = *it;
                start += step;
                ++it;
            }
        }
    }
%End // __setitem__()

}; // class QwtArrayDouble

// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:

