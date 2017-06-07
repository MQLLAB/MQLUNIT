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

class MQLUNIT_TerminalTestRunner : public MQLUNIT_TestRunner {
private:
    MQLLIB_Collections_Vector<MQLUNIT_TestFailure*> _failures;
    string _output;
    bool _alertsEnabled;
public:
    MQLUNIT_TerminalTestRunner() : _output(""), _alertsEnabled(false) {};
    ~MQLUNIT_TerminalTestRunner() {};
  
    /// @defgroup TestListenerImpl
    /// @{
    void addFailure(MQLUNIT_TestFailure* failure);
    void startTest(string name);
    void endTest(string name) {};
    /// @}
    /// @defgroup TestRunnerImpl
    /// @{
    void run(MQLUNIT_Test* test);
    /// @}
  
    void setAlertsEnabled(bool alertsEnabled) { _alertsEnabled = alertsEnabled; };

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

void MQLUNIT_TerminalTestRunner::startTest(string name) {
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

void MQLUNIT_TerminalTestRunner::run(MQLUNIT_Test* test) {
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
        PrintFormat("Tests run: %i,  Failures: %i", result.countRunTests(),
        _failures.size());
        Print("");
    } else {
        PrintFormat("OK (%i tests)", result.countRunTests());
        Print("");
    }
}

//-----------------------------------------------------------------------------

#endif
