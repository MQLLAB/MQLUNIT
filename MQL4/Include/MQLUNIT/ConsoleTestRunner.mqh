/// @file   ConsoleTestRunner.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLUNIT ConsoleTestRunner class.

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

#ifndef MQLUNIT_CONSOLETESTRUNNER_MQH
#define MQLUNIT_CONSOLETESTRUNNER_MQH

#include <MQLLIB/Collections/Vector.mqh>
#include <MQLLIB/Utils/Console.mqh>

#include "Constants.mqh"
#include "TestFailure.mqh"
#include "TestResult.mqh"
#include "TestRunner.mqh"

//-----------------------------------------------------------------------------

class MQLUNIT_ConsoleTestRunner : public MQLUNIT_TestRunner{
private:
    MQLLIB_Collections_Vector<MQLUNIT_TestFailure*> _failures;
    uint _charCount;
public:
    MQLUNIT_ConsoleTestRunner() : _charCount(0) {};
    ~MQLUNIT_ConsoleTestRunner() {};
  
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
private:
    void printFailureCount(uint count) const;
    void checkWrap();
};

//-----------------------------------------------------------------------------

void MQLUNIT_ConsoleTestRunner::checkWrap() {
    if (_charCount == MQLUNIT_OUTPUT_WRAP) {
        MQLLIB_Utils_Console::writeLine();
        _charCount =0;
    }
}

//-----------------------------------------------------------------------------

void MQLUNIT_ConsoleTestRunner::startTest(string name) {
    checkWrap();
    MQLLIB_Utils_Console::write(".");
    _charCount++;
}

//-----------------------------------------------------------------------------

void MQLUNIT_ConsoleTestRunner::printFailureCount(uint count) const {
    MQLLIB_Utils_Console::writeLine(
        StringFormat(failureCountFormat(count), count)
    );
}

//-----------------------------------------------------------------------------

void MQLUNIT_ConsoleTestRunner::addFailure(MQLUNIT_TestFailure* failure) {
    checkWrap();
    MQLLIB_Utils_Console::write("F");
    _charCount++;
    _failures.add(failure);
}

//-----------------------------------------------------------------------------

void MQLUNIT_ConsoleTestRunner::run(MQLUNIT_Test* test) {
    MQLUNIT_TestResult result;
    result.addListener(&this);
  
    double startTime = GetTickCount();
    test.run(&result);
    double endTime = GetTickCount();
  
    MQLLIB_Utils_Console::writeLine();
    MQLLIB_Utils_Console::writeLine(
        StringFormat("Time %.3f", (endTime - startTime) / 1000)
    );
  
    if (_failures.size() > 0) {
        printFailureCount(_failures.size());
        int count = 1;
        MQLLIB_FOREACHV(MQLUNIT_TestFailure*, failure, _failures) {
            MQLLIB_Utils_Console::writeLine(
                StringFormat(
                    "%i) %s(%s:%i): %s", count, failure.getMethod(),
                    failure.getFile(), failure.getLine(), failure.getMessage()
                )
            );
        count++;
        }

        MQLLIB_Utils_Console::writeLine();
        MQLLIB_Utils_Console::writeLine("FAILURES!!!");
        MQLLIB_Utils_Console::writeLine(
            StringFormat(
                "Tests run: %i,  Failures: %i",
                result.countRunTests(), _failures.size()
            )
        );
    } else {
        MQLLIB_Utils_Console::writeLine(
            StringFormat("OK (%i tests)", result.countRunTests())
        );
    }
  
    MQLLIB_Utils_Console::writeLine();
}

//-----------------------------------------------------------------------------

#endif
