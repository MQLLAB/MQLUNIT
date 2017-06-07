/// @file   TestFailure.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLUNIT TestFailure class definition.

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

#ifndef MQLUNIT_TESTFAILURE_MQH
#define MQLUNIT_TESTFAILURE_MQH

#include "Test.mqh"

//-----------------------------------------------------------------------------

/// @brief Record of a failed Test execution.
class MQLUNIT_TestFailure {
private:
    MQLUNIT_Test* _test;
    string        _file;
    uint          _line;
    string        _method;
    string        _message;
public:
    /// @brief Constructor
    MQLUNIT_TestFailure(
        MQLUNIT_Test* test, string file, uint line, string method,
        string message
     ) : _test(test), _file(file), _line(line), _method(method),
         _message(message) {};
    /// @brief Descructor     
    ~MQLUNIT_TestFailure () {};
    MQLUNIT_Test* getTest() const { return _test; };
    string getFile() const { return _file; };
    uint getLine() const { return _line; };
    string getMethod() const { return _method; };
    string getMessage() const { return _message; };
private: 
    MQLUNIT_TestFailure(const MQLUNIT_TestFailure& that); 
    void operator =(const MQLUNIT_TestFailure& that); 
};

//-----------------------------------------------------------------------------

#endif