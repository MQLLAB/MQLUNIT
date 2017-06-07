/// @file   Iterator.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLLIB Iterator interface definitions.

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

#ifndef MQLLIB_COLLECTIONS_ITERATOR_MQH
#define MQLLIB_COLLECTIONS_ITERATOR_MQH

#include "../Lang/Pointer.mqh"

//-----------------------------------------------------------------------------

/// @brief An iterator over a collection.
template <typename T>
class MQLLIB_Collections_Iterator {
private:
    // copying of the interface is forbidden
    MQLLIB_Collections_Iterator(const MQLLIB_Collections_Iterator<T>& that) {};
    void operator =(const MQLLIB_Collections_Iterator<T>& that) {};
protected:
    MQLLIB_Collections_Iterator() {};
public:
    virtual ~MQLLIB_Collections_Iterator() {};
    
    /// @brief Returns true if the iteration has more elements.
    /// @return true if the iteration has more elements
    virtual bool hasNext() const = 0;
    
    /// @brief Returns the current element in the iteration.
    /// @return the current element in the iteration
    virtual T current() const = 0;
    
    /// @brief Moves to the next element of the collection.
    /// When reached the end of the collection, does nothing.
    virtual void next() = 0;
  
    /// @brief Moves to the next element of the collection.
    /// When reached the end of the collection, does nothing.
    /// @note This is simply a syntactic sugar for the ::next method.
    MQLLIB_Collections_Iterator<T>* operator++(int) {
        next();
        return GetPointer(this);
    };
};

//-----------------------------------------------------------------------------

/// @brief Implementing this interface allows an object to be the iterated
/// using #MQLLIB_FOREACH and #MQLLIB_FOREACHV macros.
template <typename T>
class MQLLIB_Collections_Iterable {
private:
    // copying of the interface is forbidden
    MQLLIB_Collections_Iterable(const MQLLIB_Collections_Iterable<T>& that) {};
    void operator =(const MQLLIB_Collections_Iterable<T>& that) {};
protected:
    MQLLIB_Collections_Iterable() {};
public:
    /// @brief Returns an iterator over elements.
    /// @return an Iterator
    virtual MQLLIB_Collections_Iterator<T>* iterator() const = 0;
    virtual ~MQLLIB_Collections_Iterable() {};
};

//-----------------------------------------------------------------------------

/// @brief This is the utility class for implementing iterator RAII assign and
/// singular access is for implementing #MQLLIB_FOREACH and #MQLLIB_FOREACHV.
/// @note This class is not intended for direct consumption. Use
/// #MQLLIB_FOREACH and #MQLLIB_FOREACHV macros instead.
template<typename T>
class __MQLLIB_Collections_Iterator : public MQLLIB_Collections_Iterator<T> {
private:
    MQLLIB_Collections_Iterator<T>* _iterator;
    bool _locked;
public:
    __MQLLIB_Collections_Iterator(
        const MQLLIB_Collections_Iterable<T>& it
    ) : _iterator (it.iterator()), _locked(false) {};
    ~__MQLLIB_Collections_Iterator() { MQLLIB_Lang_SafeDelete(_iterator); }
    void next() { _iterator.next(); }
    bool hasNext() const { return _iterator.hasNext(); };
    T current() const { return _iterator.current(); }

    bool testLock() {
        if (_locked) {
            return false;
        } else {
            _locked = true;
            return true;
        }
    };

    bool assign(T& var) { 
        if (!_iterator.hasNext()) {
            return false;
        } else {
            var = _iterator.current();
            return true;
        }
    }
};

//-----------------------------------------------------------------------------

/// @brief Iterate over each element of the collection.
/// Variable <pre>it</pre> can be used to access the iterator inside the loop.
#define MQLLIB_FOREACH(Type, Iterable)                                       \
    for(                                                                     \
        __MQLLIB_Collections_Iterator<Type> it(Iterable);                    \
        it.hasNext();                                                        \
        it.next()                                                            \
    )

//-----------------------------------------------------------------------------

/// @brief Iterate over each element of the collection.
/// Similar to #FOREACH macro but allows you to specify a variable name
/// for an accumulator.
#define MQLLIB_FOREACHV(Type, Var, Iterable)                                 \
    for (__MQLLIB_Collections_Iterator<Type> it(Iterable); it.testLock();)   \
        for (Type Var; it.assign(Var); it.next())

//-----------------------------------------------------------------------------

#endif
