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
    const MQLUNIT_Test* _test;
    const string        _file;
    const uint          _line;
    const string        _method;
    const string        _message;

public:
    /// @brief Constructor : create a record of a failed test execution.
    /// @param test    : a test that failed
    /// @param file    : a name of a file that contains a failed test
    /// @param line    : a line in a file that triggered a failure
    /// @param method  : a name of an assertion that failed (test method)
    /// @param message : a failure description
    /// @see MQLUNIT_Test
    MQLUNIT_TestFailure(
        const MQLUNIT_Test* test, const string file, const uint line,
        const string method, const string message
     ) : _test(test), _file(file), _line(line), _method(method),
         _message(message) {};

    /// @brief Descructor     
    ~MQLUNIT_TestFailure () {};

    /// @brief Returns a failed test.
    /// @return a test that failed
    const MQLUNIT_Test* getTest() const { return _test; };

    /// @brief Returns a name of a file that contains a failed test.
    /// @return a name of a file that contains a failed test
    string getFile() const { return _file; };

    /// @brief Returns a line in a file that triggered a failure.
    /// @return a line in a file that triggered a failure
    uint getLine() const { return _line; };
    
    /// @brief Returns a name of an assertion that failed (test method).
    /// @return a name of an assertion that failed (test method)
    string getMethod() const { return _method; };
    
    /// @brief Returns a failure description
    /// @return a failure description
    string getMessage() const { return _message; };

private: 
    // Although copying of the test failure makes sense, we didn't implement
    // it yes and, therefore, we disable it for now.
    MQLUNIT_TestFailure(const MQLUNIT_TestFailure& that); 
    void operator =(const MQLUNIT_TestFailure& that); 
};

//-----------------------------------------------------------------------------

#endif