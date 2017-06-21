/// @file   TextFileTestRunner.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLUNIT TextFileTestRunner class.

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

#ifndef MQLUNIT_TEXTFILETESTRUNNER_MQH
#define MQLUNIT_TEXTFILETESTRUNNER_MQH

#include <MQLLIB/Collections/Vector.mqh>
#include <Files/FileTxt.mqh>

#include "Constants.mqh"
#include "TestFailure.mqh"
#include "TestResult.mqh"
#include "TestRunner.mqh"

//-----------------------------------------------------------------------------

/// @brief Test runner that outputs results to the text file.
/// @see MQLUNIT_TestRunner
class MQLUNIT_TextFileTestRunner : public MQLUNIT_TestRunner {
private:
    MQLLIB_Collections_Vector<MQLUNIT_TestFailure*> _failures;
    uint     _charCount;
    CFileTxt _file;

public:
    /// @brief Constructor : create a new text file test runner.
    /// @param file : full path the file to write test results to (relative
    /// to MQL4/Files directory)
    MQLUNIT_TextFileTestRunner(string file) : _charCount(0) {
        _file.Open(file, FILE_WRITE | FILE_TXT);
    };

    /// @brief Destructor
    ~MQLUNIT_TextFileTestRunner() {
        _file.Close();
    };

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

private:
    void printFailureCount(uint count);
    void checkWrap();
};

//-----------------------------------------------------------------------------

void MQLUNIT_TextFileTestRunner::checkWrap() {
    if (_charCount == MQLUNIT_OUTPUT_WRAP) {
        _file.WriteString("\r\n");
        _charCount = 0;
    }
}

//-----------------------------------------------------------------------------

void MQLUNIT_TextFileTestRunner::startTest(
    MQLUNIT_Test* test, const string name
) {
    checkWrap();
    _file.WriteString(".");
    _charCount++;
}

//-----------------------------------------------------------------------------

void MQLUNIT_TextFileTestRunner::printFailureCount(uint count) {
    _file.WriteString(
        StringConcatenate(
            StringFormat(failureCountFormat(count), count), "\r\n"
        )
    );
}

//-----------------------------------------------------------------------------

void MQLUNIT_TextFileTestRunner::addFailure(MQLUNIT_TestFailure* failure) {
    checkWrap();
    _file.WriteString("F");
    _charCount++;
    _failures.add(failure);
}

//-----------------------------------------------------------------------------

bool MQLUNIT_TextFileTestRunner::run(MQLUNIT_Test* test) {
    MQLUNIT_TestResult result;
    result.addListener(&this);

    double startTime = GetTickCount();
    test.run(&result);
    double endTime = GetTickCount();

    _file.WriteString(
        StringFormat("\r\nTime %.3f\r\n", (endTime - startTime) / 1000)
    );

    if (_failures.size() > 0) {
        printFailureCount(_failures.size());
        int count = 1;
        MQLLIB_FOREACHV(MQLUNIT_TestFailure*, failure, _failures) {
            _file.WriteString(
                StringFormat(
                    "%i) %s(%s:%i): %s\r\n", count, failure.getMethod(),
                    failure.getFile(), failure.getLine(), failure.getMessage()
                )
            );
        count++;
        }

        _file.WriteString("\r\nFAILURES!!!\r\n");
        _file.WriteString(
            StringFormat(
                "Tests run: %i,  Failures: %i\r\n", result.runCount(),
                _failures.size()
            )
        );
    } else {
        _file.WriteString(
            StringFormat("OK (%i tests)\r\n", result.runCount())
        );
    }

    return _failures.size() == 0;
}

//-----------------------------------------------------------------------------

#endif
