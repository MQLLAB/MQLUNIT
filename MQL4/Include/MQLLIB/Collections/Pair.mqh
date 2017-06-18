/// @file   Pair.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLLIB Pair class definition.

//-----------------------------------------------------------------------------
// Copyright 2017, Eneset Group Trust
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

#ifndef MQLLIB_COLLECTION_PAIR_MQH
#define MQLLIB_COLLECTION_PAIR_MQH

#include <MQLLIB/Lang/Pointer.mqh>

//-----------------------------------------------------------------------------

template <typename K, typename V>
class MQLLIB_Collection_Pair {
private:
    K _key;
    V _value;

public:
    MQLLIB_Collection_Pair(K key, V value)
        : _key(key), _value(value) {};

    MQLLIB_Collection_Pair(const MQLLIB_Collection_Pair& that)
        : _key(that._key), _value(that._value) {};

    ~MQLLIB_Collection_Pair() {
        MQLLIB_Lang_SafeDelete(_key);
        MQLLIB_Lang_SafeDelete(_value);
    }

    void operator =(const MQLLIB_Collection_Pair& that) {
        this._key = that._key; this._value = that._value;
    };

    K getKey()   const { return _key;   };
    V getValue() const { return _value; };

    bool operator ==(const MQLLIB_Collection_Pair& that) {
        return this._key == that._key && this._value == that._value;
    };

    bool operator !=(const MQLLIB_Collection_Pair& that) {
        return !(this == that);
    };
};

//-----------------------------------------------------------------------------

#endif
