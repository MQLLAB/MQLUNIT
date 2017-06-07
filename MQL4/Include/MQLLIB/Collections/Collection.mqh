/// @file   Collection.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLLIB Collection interface definition.

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

#ifndef MQLLIB_COLLECTIONS_COLLECTION_MQH
#define MQLLIB_COLLECTIONS_COLLECTION_MQH

#include "Iterator.mqh"

//-----------------------------------------------------------------------------

/// @brief Base class for collections.
template<typename T>
class MQLLIB_Collections_Collection : public MQLLIB_Collections_Iterable<T> {
public:
    // @brief Remove all elements of the collection.
    virtual void clear() = 0;
    
    /// @brief Add element to the collection.
    /// @return true if the collection changed because of adding the value
    virtual bool add(T value) = 0;
    
    /// @brief Removes the first element that is equal to value.
    /// @return true if the collection changed because of removing the value
    virtual bool remove(const T value) = 0;
  
    virtual int  size() const = 0;
    virtual bool addAll(T &array[]);
    virtual bool addAll(const MQLLIB_Collections_Collection<T>& that);
    virtual bool contains(const T value) const;
    virtual bool isEmpty() const { return size() == 0; }
    virtual void toArray(T& array[]) const;
};

//-----------------------------------------------------------------------------

/// @brief Standard (but ineffective) implementation using iterators.
/// Derived classes should override it with a more efficient implemetation
/// based on the type of the collection.
template<typename T>
bool MQLLIB_Collections_Collection::contains(const T value) const {
    MQLLIB_FOREACH(T, this) {
        if(it.current() == value) { return true; };
    }
    return false;
}

//-----------------------------------------------------------------------------

/// @brief Standard (but ineffective) implementation using add.
/// Derived classes should override it with a more efficient implemetation
/// based on the type of the collection.
template<typename T>
bool MQLLIB_Collections_Collection::addAll(T& array[]) {
    const int s = ArraySize(array);
    bool added = false;
    for(int i = 0; i < s; i++) {
        bool tmp = add(array[i]);
        if (!added) { added = tmp; };
    }
    return added;
}
  
//-----------------------------------------------------------------------------

/// @brief Standard (but ineffective) implementation using add.
/// Derived classes should override it with a more efficient implemetation
/// based on the type of the collection.
template<typename T>
bool MQLLIB_Collections_Collection::addAll(
    const MQLLIB_Collections_Collection<T>& that
) {
    bool added = false;
    MQLLIB_FOREACH(T, that) {
        bool tmp = add(it.current());
        if (!added) { added = tmp; }
    }
    return added;
}
  
//-----------------------------------------------------------------------------

/// @brief Standard (but ineffective) implementation using iterators.
/// Derived classes should override it with a more efficient implemetation
/// based on the type of the collection.
template<typename T>
void MQLLIB_Collections_Collection::toArray(T& array[]) const {
    int s = size();
    if (s > 0) {
        ArrayResize(array, s);
        int i = 0;
        MQLLIB_FOREACH(T, this) {
            array[i++] = it.current();
        }
    }   
}
//-----------------------------------------------------------------------------

#endif