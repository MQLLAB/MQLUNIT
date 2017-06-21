/// @file   TerminalTestRunner.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLUNIT TerminalTestRunner class definition.

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

#ifndef MQLUNIT_TERMINALTESTRUNNER_MQH
#define MQLUNIT_TERMINALTESTRUNNER_MQH

#include <MQLLIB/Collections/Vector.mqh>

#include "Constants.mqh"
#include "TestFailure.mqh"
#include "TestResult.mqh"
#include "TestRunner.mqh"

//-----------------------------------------------------------------------------

/// @brief Test runner that outputs results to the "Experts" log window of
/// MetaTrader terminal.
///
/// Optionally can pop up an alert dialog with a list of test failures if any
/// occure.
/// @see MQLUNIT_TestRunner
class MQLUNIT_TerminalTestRunner : public MQLUNIT_TestRunner {
private:
    MQLLIB_Collections_Vector<MQLUNIT_TestFailure*> _failures;
    string _output;
    bool _alertsEnabled;

public:
    /// @brief Constructor : disable alerts by default.
    MQLUNIT_TerminalTestRunner() : _output(""), _alertsEnabled(false) {};

    /// @brief Destructor
    ~MQLUNIT_TerminalTestRunner() {};

    // MQLUNIT_TestListener implementation {

    /// @brief Registeres a test failure.
    /// @param failure : failure details
    /// @see MQLUNIT_TestFailure
    void addFailure(MQLUNIT_TestFailure* failure);

    /// @brief Test suite started event.
    /// @param test : test case reference
    void startSuite(MQLUNIT_Test* test) {};

    /// @brief Test suite ended event.
    /// @param test : test case reference
    void endSuite(MQLUNIT_Test* test) {};

    /// @brief Test started event.
    /// @param test : test case reference
    /// @param name : name of a test
    void startTest(MQLUNIT_Test* test, const string name);

    /// @brief Test ended event.
    /// @param test : test case reference
    /// @param name : name of a test
    void endTest(MQLUNIT_Test* test, const string name) {};

    // }

    // MQLUNIT_TestRunner implementation {

    /// @brief Run a test and output the result to the console.
    /// @param test : a test to run
    /// @return true, if all tests succeeded, false if there were failures
    /// @see MQLUNIT_Test
    bool run(MQLUNIT_Test* test);

    // }

    /// @brief Enable or disable alerts window pop up in case of a test
    /// failure.
    /// @param alertsEnabled : set to true to enable alerts, set to false to
    /// disable alerts
    void setAlertsEnabled(bool alertsEnabled) {
        _alertsEnabled = alertsEnabled;
    };

private:
    void printFailureCount(uint count) const;
    void printFailure(uint count, MQLUNIT_TestFailure* failure) const;
    void checkWrap();
};

//-----------------------------------------------------------------------------

void MQLUNIT_TerminalTestRunner::printFailureCount(uint count) const {
    PrintFormat(failureCountFormat(count), count);
}

//-----------------------------------------------------------------------------

void MQLUNIT_TerminalTestRunner::startTest(
    MQLUNIT_Test* test, const string name
) {
    checkWrap();
    StringAdd(_output, ".");
}

//-----------------------------------------------------------------------------

void MQLUNIT_TerminalTestRunner::addFailure(MQLUNIT_TestFailure* failure) {
    _failures.add(failure);
    checkWrap();
    StringAdd(_output, "F");
}

//-----------------------------------------------------------------------------

void MQLUNIT_TerminalTestRunner::checkWrap() {
    if (StringLen(_output) == MQLUNIT_OUTPUT_WRAP) {
        Print(_output);
        _output = "";
    }
}

//-----------------------------------------------------------------------------

void MQLUNIT_TerminalTestRunner::printFailure(
    uint count, MQLUNIT_TestFailure* failure
) const {
    if (_alertsEnabled) {
        Alert(
            StringFormat(
                "%s(%s:%i): %s", failure.getMethod(), failure.getFile(),
                failure.getLine(), failure.getMessage()
            )
        );
  } else {
      PrintFormat(
          "%i) %s(%s:%i): %s", count, failure.getMethod(),
          failure.getFile(), failure.getLine(), failure.getMessage()
      );
  }
}

//-----------------------------------------------------------------------------

bool MQLUNIT_TerminalTestRunner::run(MQLUNIT_Test* test) {
    MQLUNIT_TestResult result;
    result.addListener(&this);
    Print("");

    double startTime = GetTickCount();
    test.run(&result);
    double endTime = GetTickCount();

    Print(_output);
    PrintFormat("Time %.3f", (endTime - startTime) / 1000);

    if (_failures.size() > 0) {
        printFailureCount(_failures.size());
        uint count = 1;
        MQLLIB_FOREACHV(MQLUNIT_TestFailure*, failure, _failures) {
            printFailure(count, failure);
            count++;
        }

        Print("FAILURES!!!");
        PrintFormat("Tests run: %i,  Failures: %i", result.runCount(),
        _failures.size());
        Print("");
    } else {
        PrintFormat("OK (%i tests)", result.runCount());
        Print("");
    }

    return _failures.size() == 0;
}

//-----------------------------------------------------------------------------

#endif
