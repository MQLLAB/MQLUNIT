/// @file   TestSuiteTest.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  Test case for MQLUNIT_TestSuite class.

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

#ifndef SCRIPTS_MQLUNIT_TESTS_TESTSUITETEST_MQH
#define SCRIPTS_MQLUNIT_TESTS_TESTSUITETEST_MQH

#include <MQLLIB/Lang/Pointer.mqh>
#include <MQLUNIT/MQLUNIT.mqh>

#include "TestData.mqh"

//-----------------------------------------------------------------------------

class MQLUNIT_Tests_TestSuiteTest : public MQLUNIT_TestCase {
private:
    MQLUNIT_TestResult* _result;
public:
    MQLUNIT_Tests_TestSuiteTest() : MQLUNIT_TestCase(typename(this)) {};
    MQLUNIT_Tests_TestSuiteTest(string name) : MQLUNIT_TestCase(name) {};

    void setUp() {
        _result = new MQLUNIT_TestResult();
    }

    void tearDown() {
        MQLLIB_Lang_SafeDelete(_result);
    }

    MQLUNIT_START

    //----------------------------------------

    TEST_START(OneTestCase) {
        MQLUNIT_TestSuite suite;
        suite.addTest(new __Success__());
        suite.run(_result);
        ASSERT_EQUALS("", (uint) 1, _result.runCount());
        ASSERT_EQUALS("", (uint) 0, _result.failureCount());
    }
    TEST_END

    //----------------------------------------

    TEST_START(InheritedTests) {
        MQLUNIT_TestSuite suite;
        suite.addTest(new __InheritedTestCase__());
        suite.run(_result);
        ASSERT_EQUALS("", (uint) 2, _result.runCount());
        ASSERT_EQUALS("", (uint) 0, _result.failureCount());
    }
    TEST_END

    //----------------------------------------

    TEST_START(NoTestCases) {
        MQLUNIT_TestSuite suite;
        suite.addTest(new __NoTestCases__());
        suite.run(_result);
        ASSERT_EQUALS("", (uint) 0, _result.runCount());
        ASSERT_EQUALS("", (uint) 0, _result.failureCount());
    }
    TEST_END

    //----------------------------------------

    TEST_START(AddTestSuite) {
        MQLUNIT_TestSuite suite1;
        suite1.addTest(new __Success__());

        MQLUNIT_TestSuite suite2;
        suite2.addTest(new __Failure__());
        suite2.addTest(&suite1);

        suite2.run(_result);
        ASSERT_EQUALS("", (uint) 2, _result.runCount());
        ASSERT_EQUALS("", (uint) 1, _result.failureCount());
    }
    TEST_END

    MQLUNIT_END
};

//-----------------------------------------------------------------------------

#endif
