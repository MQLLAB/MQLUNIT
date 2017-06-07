/// @file   Pointer.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  Object pointer manipulation functions.

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

#ifndef MQLLIB_LANG_POINTER_MQH
#define MQLLIB_LANG_POINTER_MQH

//-----------------------------------------------------------------------------

/// @brief Generic pointer check.
/// @param pointer : object pointer
/// @return true, if pointer is valid and can be deleted
template<typename T> bool MQLLIB_Lang_IsValidPointer(T *pointer) {
    return CheckPointer(pointer) == POINTER_DYNAMIC;
}

//-----------------------------------------------------------------------------

/// @brief Generic safe pointer delete.
/// Deletes the referenced object only if the pointer is valid.
/// @param pointer : object pointer
template<typename T> void MQLLIB_Lang_SafeDelete(T *pointer) {
    if (MQLLIB_Lang_IsValidPointer(pointer)) { delete pointer; }
}

//-----------------------------------------------------------------------------

/// @brief Generic safe pointer delete.
/// When pointer is actually a value type, delete operation should not be
/// attempted.
/// @param pointer : value object
template<typename T> void MQLLIB_Lang_SafeDelete(T pointer) {}

//-----------------------------------------------------------------------------

/// @brief Get numerical value of a pointer  .
/// Mainly used by the Hash function on pointers. According to official
/// documentation, MQL4 pointer is a 8 byte value, not the actual pointer
/// address of objects. But numeric values of different pointers have to be
/// distinct.
/// @param pointer : object pointer
/// @return numerical value of a pointer
long MQLLIB_Lang_GetAddress(const void *pointer) {
    return long(StringFormat("%I64d", pointer));
}

//-----------------------------------------------------------------------------

/// @brief Generic simple smart pointer.
template<typename T> class MQLLIB_Lang_AutoPtr {
public:
    T* p;
    MQLLIB_Lang_AutoPtr(T* pointer = NULL) : p(pointer) {}
    MQLLIB_Lang_AutoPtr(const MQLLIB_Lang_AutoPtr<T>& that) : p(that.p) {}
    /// @brief Destructor : responsible for deletion of the resource.
    ~MQLLIB_Lang_AutoPtr() { MQLLIB_Lang_SafeDelete(p); }
    bool operator ==(const MQLLIB_Lang_AutoPtr& that) const {
        return that.p == p;
    }
    bool operator ==(const T* that) const { return p == that; }
    bool operator !=(const MQLLIB_Lang_AutoPtr &that) const {
        return that.p != p;
    }
    bool operator !=(const T* that) const { return p != that; }
    T* operator =(MQLLIB_Lang_AutoPtr& that) { p = that.p; return p; }
    T* operator =(T* that) { p = that; return p; }
};

//-----------------------------------------------------------------------------

#endif