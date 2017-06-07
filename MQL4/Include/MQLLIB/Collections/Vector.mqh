/// @file   Vector.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLLIB Vector class definition.

//-----------------------------------------------------------------------------
// Copyright 2017 Eneset Group Trust
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//-----------------------------------------------------------------------------

#property strict

#ifndef MQLLIB_COLLECTIONS_VECTOR_MQH
#define MQLLIB_COLLECTIONS_VECTOR_MQH

#include "../Lang/Array.mqh"
#include "../Lang/Pointer.mqh"
#include "Collection.mqh"
#include "Iterator.mqh"

//-----------------------------------------------------------------------------

template<typename T>
class MQLLIB_Collections_Vector : public MQLLIB_Collections_Collection<T> {
private:
    int _buffer;
    T _array[];
public:
    MQLLIB_Collections_Vector(int buffer = 50) : _buffer(buffer) { resize(0); }
    MQLLIB_Collections_Vector(const MQLLIB_Collections_Vector<T>& that);
    ~MQLLIB_Collections_Vector();

    void operator=(const MQLLIB_Collections_Vector<T>& that);  
    T operator [](int index) { return get(index); }
  
    /// @defgroup vectorCollectionImpl Collection<T> interface implementation.
    /// @{
    void clear();
    bool add(T value) { insertAt(size(), value); return true; };
    /// @brief Removes the first element that is equal to value.
    /// @return true if the collection changed because of removing the value
    bool remove(const T value);
    int  size() const { return ArraySize(_array); };
    /// @}
  
    /// @defgroup vectorSequenceImpl Sequence<T> interface implementation.
    /// @{
    void insertAt(int index, T value);
    T removeAt(int index);
    T get(int index) const { return _array[index]; }
    void set(int index, T value) { _array[index] = value; }
    void compact() { MQLLIB_Lang_ArrayCompact(_array); }
    /// @}
  
    /// @defgroup vectorIterableImpl Iterable<T> interface implementation
    /// @{
    MQLLIB_Collections_Iterator<T>* iterator() const {
        return new MQLLIB_Collections_VectorIterator<T>(this);
    };
    /// @}
  
private:
    void resize(int size) { ArrayResize(_array, size, _buffer); }
};

//-----------------------------------------------------------------------------

template<typename T>
class MQLLIB_Collections_VectorIterator
    : public MQLLIB_Collections_Iterator<T> {
private:
    int _index;
    const int _size;
    MQLLIB_Collections_Vector<T>* _vector;
public:
    MQLLIB_Collections_VectorIterator(
        const MQLLIB_Collections_Vector<T>& vector
    ) : _index(0), _size(vector.size()),
        _vector((MQLLIB_Collections_Vector<T>*) GetPointer(vector)) {};
    bool hasNext() const { return _index < _size; };
    void next() { if (hasNext()) { _index++; }; };
    T current() const { return _vector.get(_index); };
};

//-----------------------------------------------------------------------------

template<typename T>
MQLLIB_Collections_Vector::MQLLIB_Collections_Vector(
    const MQLLIB_Collections_Vector<T>& that
) : _buffer(50) {
    resize(0);
    this.addAll(that);
}

//-----------------------------------------------------------------------------

template<typename T>
MQLLIB_Collections_Vector::~MQLLIB_Collections_Vector() {
    clear();
    ArrayFree(_array);
}

//-----------------------------------------------------------------------------

template<typename T>
void MQLLIB_Collections_Vector::operator =(
    const MQLLIB_Collections_Vector<T>& that
) {
    this._buffer = that._buffer;
    resize(0);
    this.addAll(that);
}

//-----------------------------------------------------------------------------

template<typename T>
void MQLLIB_Collections_Vector::clear() {
    int size = size();
    if (size > 0) {
        for (int i = 0; i < size; i++) { MQLLIB_Lang_SafeDelete(_array[i]); }
    }
    ArrayResize(_array, 0, _buffer);
}

//-----------------------------------------------------------------------------

template<typename T>
bool MQLLIB_Collections_Vector::remove(const T value) {
    int index = MQLLIB_Lang_ArrayFind(_array, value);
    if (index < 0) { return false; }
    MQLLIB_Lang_SafeDelete(_array[index]);
    removeAt(index);
    return true;
}

//-----------------------------------------------------------------------------

template<typename T>
void MQLLIB_Collections_Vector::insertAt(int index, T value) {
    MQLLIB_Lang_ArrayInsert(_array, index, value, _buffer);
}

//-----------------------------------------------------------------------------

template<typename T>
T MQLLIB_Collections_Vector::removeAt(int index) {
    T value = _array[index];
    MQLLIB_Lang_ArrayDelete(_array, index);
    return value;
}

//-----------------------------------------------------------------------------

#endif