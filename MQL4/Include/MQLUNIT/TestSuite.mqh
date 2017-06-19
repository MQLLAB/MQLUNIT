/// @file   TestSuite.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLUNIT TestSuite class definition.

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

#ifndef MQLUNIT_TESTSUITE_MQH
#define MQLUNIT_TESTSUITE_MQH

#include <MQLLIB/Collections/Collection.mqh>
#include <MQLLIB/Collections/Vector.mqh>
#include <MQLLIB/Lang/Pointer.mqh>
#include <MQLLIB/Utils/Console.mqh>

#include "Test.mqh"
#include "TestCase.mqh"
#include "TestResult.mqh"

//-----------------------------------------------------------------------------

/// @brief Runs a collection of test cases.
///
/// A MQLUNIT_TestSuite is a Composite of MQLUNIT_Test.<br>
/// <br>
/// Example usage:<br>
/// @code
/// MQLUNIT_TestSuite suite;
/// suite.addTest(new MyFirstTestCase());
/// suite.addTest(new MySecondTestCase());
/// suite.addTest(new MyThirdTestCase());
///
/// MQLUNIT_TerminalTestRunner runner;
/// runner.run(&suite);
/// @endcode
/// @see MQLUNIT_Test
/// @see MQLUNIT_TestCase
/// @see MQLUNIT_TestResult
class MQLUNIT_TestSuite : public MQLUNIT_Test {
private:
    MQLLIB_Collections_Vector<MQLUNIT_Test*> _tests;
public:
    /// @brief Constructor : creates a test suite using a class name as a test
    /// suite name.
    MQLUNIT_TestSuite() : MQLUNIT_Test(typename(this)) {};

    /// @brief Constructor : creates a test suite with a provided suite name.
    /// @param name : test suite name
    MQLUNIT_TestSuite(const string name) : MQLUNIT_Test(name) {};

    /// @brief Destructor.
    virtual ~MQLUNIT_TestSuite() {};

    /// @brief Add a test to this test suite.
    /// @param test : a test to add to this test suite
    virtual void addTest(MQLUNIT_Test* test) { _tests.add(test); };

    /// @brief Runs the test suite.
    /// @param result : collects the results of executing a test suite
    /// @param inherited : set to true to tell the test it has been inherited
    /// from and is run by a child test
    /// @see #MQLUNIT_TestResult
    virtual void run(MQLUNIT_TestResult* result, bool inherited = false);
};

//-----------------------------------------------------------------------------

void MQLUNIT_TestSuite::run(
    MQLUNIT_TestResult* result, bool inherited = false
) {
    MQLLIB_FOREACHV(MQLUNIT_Test*, test, _tests) {
        test.run(result, inherited);
    }
}

//-----------------------------------------------------------------------------

#endif
