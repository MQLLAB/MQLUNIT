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
    
    /// @brief Informs the result that a test was started. 
    /// @param name : test name
    void startTest(const string name);
    
    /// @brief Informs the result that a test was completed. 
    /// @param name : test name
    void endTest(const string name);
    
    // }

    /// @brief Returns a total number of tests run.
    /// @return total number of tests run
    uint countRunTests() { return _runTests; };
};

//-----------------------------------------------------------------------------

void MQLUNIT_TestResult::startTest(const string name) {
    _runTests++;
    MQLLIB_FOREACHV(MQLUNIT_TestListener*, listener, _listeners) {
        listener.startTest(name);
    }
}

//-----------------------------------------------------------------------------

void MQLUNIT_TestResult::endTest(const string name) {
    MQLLIB_FOREACHV(MQLUNIT_TestListener*, listener, _listeners) {
        listener.endTest(name);
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
