/// @file   TestListenerTest.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  Test case for MQLUNIT_TestListener class.

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

#ifndef SCRIPTS_MQLUNIT_TESTS_TESTLISTENERTEST_MQH
#define SCRIPTS_MQLUNIT_TESTS_TESTLISTENERTEST_MQH

#include <MQLLIB/Lang/Pointer.mqh>
#include <MQLUNIT/MQLUNIT.mqh>

#include "TestData.mqh"

//-----------------------------------------------------------------------------

class MQLUNIT_Tests_TestListenerTest : public MQLUNIT_TestCase {
private:
    __TestListener__*   _listener;
    MQLUNIT_TestResult* _result;
public:
    MQLUNIT_Tests_TestListenerTest() : MQLUNIT_TestCase(typename(this)) {};
    MQLUNIT_Tests_TestListenerTest(string name) : MQLUNIT_TestCase(name) {};

    void setUp() {
        _result = new MQLUNIT_TestResult();
        _listener = new __TestListener__();
        _result.addListener(_listener);
    }

    void tearDown() {
        MQLLIB_Lang_SafeDelete(_result);
    }

    MQLUNIT_START

    //----------------------------------------

    TEST_START(Failure) {
        __Failure__ test;
        test.run(_result);
        ASSERT_EQUALS("", (uint) 1, _listener.failureCount);
        ASSERT_EQUALS("", (uint) 1, _listener.endCount);
    }
    TEST_END

    //----------------------------------------

    TEST_START(StartStop) {
        __Success__ test;
        test.run(_result);
        ASSERT_TRUE("", _listener.suiteStarted);
        ASSERT_TRUE("", _listener.suiteEnded);
        ASSERT_EQUALS("", (uint) 1, _listener.startCount);
        ASSERT_EQUALS("", (uint) 1, _listener.endCount);
    }
    TEST_END

    //----------------------------------------

    TEST_START(StartStop2) {
        __Success__ test;
        test.run(_result);
        test.run(_result);
        ASSERT_TRUE("", _listener.suiteStarted);
        ASSERT_TRUE("", _listener.suiteEnded);
        ASSERT_EQUALS("", (uint) 2, _listener.startCount);
        ASSERT_EQUALS("", (uint) 2, _listener.endCount);
    }
    TEST_END

    //----------------------------------------

    MQLUNIT_END
};

#endif
