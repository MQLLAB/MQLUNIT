/// @file   Array.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  Generic functions for working with arrays.

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

#ifndef MQLLIB_LANG_ARRAY_MQH
#define MQLLIB_LANG_ARRAY_MQH

//-----------------------------------------------------------------------------

/// @brief Generic array insert operation.
/// Inserts element at provided index. 
/// @return true on success, false if provided index is out of array bounds.
template<typename T>
bool MQLLIB_Lang_ArrayInsert(T& array[], int index, T value, int buffer = 10) {
    int size = ArraySize(array);
    if (index < 0 || index > size) { return false; }
    ArrayResize(array, size + 1, buffer);
    for(int i = size; i > index; i--) { array[i] = array[i-1]; }
    array[index] = value;
    return true; 
}
  
//-----------------------------------------------------------------------------

/// @brief Generic array delete operation.
/// Delete element at provided sindex.
/// @return true on success, false if provided index is out of array bounds.
template<typename T>
bool MQLLIB_Lang_ArrayDelete(T& array[], int index) {
    int size = ArraySize(array);
    if (index < 0 || index >= size) { return false; }
    for(int i=index; i<size-1; i++) { array[i] = array[i + 1]; }
    ArrayResize(array, size-1);
    return true;
}

//-----------------------------------------------------------------------------

/// @brief Finds the first index of the value in the array.
template<typename T>
int MQLLIB_Lang_ArrayFind(const T& array[], const T value) {
    int size = ArraySize(array);
    int index = -1;
    for(int i = 0; i < size; i++) {
        if (value == array[i]) {
            index = i;
            break;
        }
    }
    return index;
}

//-----------------------------------------------------------------------------

/// @brief Removes all elements equal to the provided value.
template<typename T>
void MQLLIB_Lang_ArrayCompact(T& array[], T value = NULL) {
    int size = ArraySize(array);
    int i = 0;
    while(i < size) {
        if (array[i] != value) { continue; }
        int j = i + 1;
        while (j < size && array[j] == value) { j++; }
        if (j == size) { break; }
        array[i] = array[j];
        array[j] = value;
        i++;
    }
    ArrayResize(array, i);
}

//-----------------------------------------------------------------------------

#endif