/// @file   TestRunnerTest.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  Test case for classes that implement MQLUNIT_TestRunner.

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

#ifndef SCRIPTS_MQLUNIT_TESTS_TESTRUNNERTEST_MQH
#define SCRIPTS_MQLUNIT_TESTS_TESTRUNNERTEST_MQH

#include <MQLLIB/Lang/Pointer.mqh>
#include <MQLUNIT/MQLUNIT.mqh>

#include "TestData.mqh"

//-----------------------------------------------------------------------------

template<typename T>
class MQLUNIT_Tests_TestRunnerTest : public MQLUNIT_TestCase {
private:
    T* _runner;
public:
    MQLUNIT_Tests_TestRunnerTest() : MQLUNIT_TestCase(typename(this)) {};
    MQLUNIT_Tests_TestRunnerTest(string name) : MQLUNIT_TestCase(name) {};


    void setUp() {
        _runner = new T("MQLUNIT/Tests/MQLUNIT_Tests_TestRunnerTest.out");
    };

    void tearDown() {
        MQLLIB_Lang_SafeDelete(_runner);
        FileDelete("MQLUNIT/Tests/MQLUNIT_Tests_TestRunnerTest.out");
        FolderDelete("MQLUNIT/Tests");
    };

    MQLUNIT_START

    //----------------------------------------

    TEST_START(TestSuccess) {
        __Success__ test;
        ASSERT_TRUE("Test must succeed", _runner.run(&test));
    }
    TEST_END

    //----------------------------------------

    TEST_START(TestFailiure) {
        __Failure__ test;
        ASSERT_TRUE("Test must fail", !_runner.run(&test));
    }
    TEST_END

    MQLUNIT_END
};

//-----------------------------------------------------------------------------

#endif
