/// @file   TestImplementorTest.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  Test case for MQLUNIT_Test class.

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

#ifndef SCRIPTS_MQLUNIT_TESTS_TESTIMPLEMENTORTEST_MQH
#ifndef SCRIPTS_MQLUNIT_TESTS_TESTIMPLEMENTORTEST_MQH

#include <MQLLIB/Lang/Pointer.mqh>
#include <MQLUNIT/MQLUNIT.mqh>

#include "TestData.mqh"

//-----------------------------------------------------------------------------

class MQLUNIT_Tests_TestImplementorTest : public MQLUNIT_TestCase {
public:
    MQLUNIT_Tests_TestImplementorTest() : MQLUNIT_TestCase(typename(this)) {};
    MQLUNIT_Tests_TestImplementorTest(string name) : MQLUNIT_TestCase(name) {};

    MQLUNIT_START

    //----------------------------------------

    TEST_START(SuccessfulRun) {
        __Test__ test;
        MQLUNIT_TestResult result;
        test.run(&result);
        ASSERT_EQUALS("", (uint) 0, result.runCount());
        ASSERT_EQUALS("", (uint) 0, result.failureCount());
        ASSERT_TRUE("", test.wasRun());
    }
    TEST_END

    MQLUNIT_END
};

//-----------------------------------------------------------------------------

#endif
