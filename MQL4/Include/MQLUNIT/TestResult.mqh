/// @file   TestResult.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLUNIT TestResult class definition.

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

#ifndef MQLUNIT_TESTRESULT_MQH
#define MQLUNIT_TESTRESULT_MQH

#include <MQLLIB/Collections/Vector.mqh>

#include "Test.mqh"
#include "TestFailure.mqh"
#include "TestListener.mqh"

//-----------------------------------------------------------------------------

/// @brief Test result collects the results of executing a test.
///
/// It is an instance of the Collecting Parameter pattern.
/// @see MQLUNIT_TestListener
class MQLUNIT_TestResult : public MQLUNIT_TestListener {
private:
    MQLLIB_Collections_Vector<MQLUNIT_TestFailure*> _failures;
    MQLLIB_Collections_Vector<MQLUNIT_TestListener*> _listeners;
    uint _runTests;

public:
    /// @brief Constructor
    MQLUNIT_TestResult() : _runTests(0) {};

    /// @brief Registeres a test listener.
    /// @param listener : test listener
    /// @see MQLUNIT_TestListener
    void addListener(MQLUNIT_TestListener* listener) {
        _listeners.add(listener);
    };

    // MQLUNIT_TestListener implementation {

    /// @brief Adds a failure to the list of test failures.
    /// @param failure : failure details
    /// @see MQLUNIT_TestFailure
    void addFailure(MQLUNIT_TestFailure* failure);

    /// @brief Test suite started event.
    /// @param test : test case reference
    void startSuite(MQLUNIT_Test* test);

    /// @brief Test suite ended event.
    /// @param test : test case reference
    void endSuite(MQLUNIT_Test* test);

    /// @brief Informs the result that a test was started.
    /// @param test : test case reference
    /// @param name : test name
    void startTest(MQLUNIT_Test* test, const string name);

    /// @brief Informs the result that a test was completed.
    /// @param test : test case reference
    /// @param name : test name
    void endTest(MQLUNIT_Test* test, const string name);

    // }

    /// @brief Returns a total number of tests run.
    /// @return total number of tests run
    uint runCount() const { return _runTests; };

    /// @brief Returns a total number of failed tests.
    /// @return total number of failed tests
    uint failureCount()  const { return _failures.size(); }
};

//-----------------------------------------------------------------------------

void MQLUNIT_TestResult::startSuite(MQLUNIT_Test* test) {
    MQLLIB_FOREACHV(MQLUNIT_TestListener*, listener, _listeners) {
        listener.startSuite(test);
    }
}

//-----------------------------------------------------------------------------

void MQLUNIT_TestResult::endSuite(MQLUNIT_Test* test) {
    MQLLIB_FOREACHV(MQLUNIT_TestListener*, listener, _listeners) {
        listener.endSuite(test);
    }
}

//-----------------------------------------------------------------------------

void MQLUNIT_TestResult::startTest(MQLUNIT_Test* test, const string name) {
    _runTests++;
    MQLLIB_FOREACHV(MQLUNIT_TestListener*, listener, _listeners) {
        listener.startTest(test, name);
    }
}

//-----------------------------------------------------------------------------

void MQLUNIT_TestResult::endTest(MQLUNIT_Test* test, const string name) {
    MQLLIB_FOREACHV(MQLUNIT_TestListener*, listener, _listeners) {
        listener.endTest(test, name);
    }
}

//-----------------------------------------------------------------------------

void MQLUNIT_TestResult::addFailure(MQLUNIT_TestFailure* failure) {
    _failures.add(failure);
    MQLLIB_FOREACHV(MQLUNIT_TestListener*, listener, _listeners) {
        listener.addFailure(failure);
    }
}

//-----------------------------------------------------------------------------

#endif
