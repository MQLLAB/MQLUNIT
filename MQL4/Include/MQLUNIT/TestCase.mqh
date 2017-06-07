/// @file   TestCase.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLUNIT TestCase class definition.

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

#ifndef MQLUNIT_TESTCASE_MQH
#define MQLUNIT_TESTCASE_MQH

#include "Test.mqh"
#include "TestResult.mqh"

//-----------------------------------------------------------------------------

/// @brief Test case.
class MQLUNIT_TestCase : public MQLUNIT_Test {
public:
    MQLUNIT_TestCase() : MQLUNIT_Test(typename(this)) {};
    MQLUNIT_TestCase(const string name) : MQLUNIT_Test(name) {};
    virtual ~MQLUNIT_TestCase() {};
    /// @brief Set up context before running a test.
    virtual void setUp() {};
    /// @brief Clean up after the test run.
    virtual void tearDown() {};
    /// @brief Runs the tests.
    virtual void run(MQLUNIT_TestResult* result) = 0;
};

//-----------------------------------------------------------------------------

#endif
