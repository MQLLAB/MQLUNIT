/// @file   Cast.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  Casting functions a-la C++.

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

#ifndef MQLLIB_LANG_CASE_MQH
#define MQLLIB_LANG_CAST_MQH

//-----------------------------------------------------------------------------

/// @brief Cast any value type to another value type.
/// @param f : value to convert from
/// @param t : value to convert to
template<typename F, typename T>
void reinterpret_cast(const F& f, T& t) {
    union _u {
      F from;
      const T to;
    } u;
    u.from = f;
    t = u.to;
}

//-----------------------------------------------------------------------------

/// @brief Convert any value type to byte array.
/// @param value : value to convert
/// @param a     : destination array
/// @param start : index starting from which to copy
template<typename T>
void byte_cast(const T& value, uchar& a[], int start = 0) {
    union _u {
      T from;
      const uchar to[sizeof(T)];
    } u;
    u.from = value;
    ArrayCopy(a, u.to, start);
}

//-----------------------------------------------------------------------------

#endif
