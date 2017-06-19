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

/// @brief A test case defines the fixture to run multiple tests.
///
/// To define a test case:<br>
/// 1) implement a subclass of MQLUNIT_TestCase<br>
/// 2) define instance variables that store the state of the fixture<br>
/// 3) initialize the fixture state by overriding MQLUNIT_TestCase::setUp<br>
/// 4) clean-up after a test by overriding MQLUNIT_TestCase::tearDown<br>
/// <br>
/// Each test runs in its own fixture so there can be no side effects among
/// test runs.<br><br>
/// For example:<br>
/// @code
/// class MathTest : public MQLUNIT_TestCase {
/// private:
///     double a, b;
/// public:
///     MathTest() : MQLUNIT_TestCase(typename(this)) {};
///     MathTest(string name) : MQLUNIT_TestCase(name) {};
///
///     void setUp() { a = 1.0; b = 2.0; };
///
///     MQLUNIT_START
///
///     TEST_START(Add) {
///         double result = a + b;
///         ASSERT_TRUE("Must add doubles", result == 4.0);
///     }
///     TEST_END
///
///     MQLUNIT_END
/// };
/// @endcode
/// The tests to be run can be collected into an @a MQLUNIT_TestSuite.<br>
/// @code
/// MQLUNIT_TestSuite suite;
/// suite.addTest(new MyFirstTestCase());
/// suite.addTest(new MySecondTestCase());
/// suite.addTest(new MyThirdTestCase());
///
/// MQLUNIT_TerminalTestRunner runner;
/// runner.run(&suite);
/// @endcode
/// @see MQLUNIT_TestResult
/// @see MQLUNIT_TestSuite
class MQLUNIT_TestCase : public MQLUNIT_Test {
public:
    /// @brief Constructor : creates a test case using a class name as a test
    /// case name.
    MQLUNIT_TestCase() : MQLUNIT_Test(typename(this)) {};

    /// @brief Constructor : creates a test case with a provided name.
    /// @param name : test case name
    MQLUNIT_TestCase(const string name) : MQLUNIT_Test(name) {};

    /// @brief Destructor
    virtual ~MQLUNIT_TestCase() {};

    /// @brief Set up context before running a test.
    virtual void setUp() {};

    /// @brief Clean up after the test run.
    virtual void tearDown() {};

    /// @brief Runs the tests.
    /// @param result : collects the results of executing a test case
    /// @param inherited : set to true to tell the test it has been inherited
    /// from and is run by a child test
    /// @see MQLUNIT_TestResult
    virtual void run(MQLUNIT_TestResult* result, bool inherited = false) = 0;
};

//-----------------------------------------------------------------------------

#endif
