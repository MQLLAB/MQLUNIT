/// @file   TestListener.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLUNIT TestListener interface definition.

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

#ifndef MQLUNIT_TESTLISTENER_MQH
#define MQLUNIT_TESTLISTENER_MQH

#include "Test.mqh"
#include "TestFailure.mqh"

//-----------------------------------------------------------------------------

/// @brief A Listener for test progress.
class MQLUNIT_TestListener {
private:
    // copying of the interface is forbidden
    MQLUNIT_TestListener(const MQLUNIT_TestListener& that) {};
    void operator =(const MQLUNIT_TestListener& that) {};
public:
    /// @brief Constructor
    MQLUNIT_TestListener() {};

    /// @brief Destructor
    virtual ~MQLUNIT_TestListener() {};

    /// @brief Failure occurred event.
    /// @param failure : failure details
    /// @see MQLUNIT_TestFailure
    virtual void addFailure(MQLUNIT_TestFailure* failure) = 0;

    /// @brief Test suite started event.
    /// @param test : test case reference
    virtual void startSuite(MQLUNIT_Test* test) = 0;

    /// @brief Test suite ended event.
    /// @param test : test case reference
    virtual void endSuite(MQLUNIT_Test* test) = 0;

    /// @brief Test started event.
    /// @param test : test case reference
    /// @param name : name of a test
    virtual void startTest(MQLUNIT_Test* test, const string name) = 0;

    /// @brief Test ended event.
    /// @param test : test case reference
    /// @param name : name of a test
    virtual void endTest(MQLUNIT_Test* test, const string name) = 0;
};

//-----------------------------------------------------------------------------

#endif
