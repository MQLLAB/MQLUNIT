/// @file   XMLTestRunner.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLUNIT XMLTestRunner class definition.

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

#ifndef MQLUNIT_XMLTESTRUNNER_MQH
#define MQLUNIT_XMLTESTRUNNER_MQH

#include <MQLLIB/Collections/Vector.mqh>
#include <MQLLIB/XML/Element.mqh>
#include <MQLLIB/XML/Document.mqh>

#include <Files/FileTxt.mqh>

#include "Constants.mqh"
#include "TestFailure.mqh"
#include "TestResult.mqh"
#include "TestRunner.mqh"

//-----------------------------------------------------------------------------

/// @brief Test runner that outputs results to the XML file compatible with
/// JUnit report analysers.
/// @note This runner's output is optimised for AppVeyor cloud CI.
/// @see MQLUNIT_TestRunner
class MQLUNIT_XMLTestRunner : public MQLUNIT_TestRunner {
private:
    MQLLIB_Collections_Vector<MQLUNIT_TestFailure*> _failures;
    MQLLIB_XML_Document _xml;
    MQLLIB_XML_Element* _currentSuite;
    MQLLIB_XML_Element* _currentTest;
    string _file;

public:
    /// @brief Constructor : create a new XML test runner.
    /// @param file : full path the file to write test results to (relative
    /// to MQL4/Files directory)
    MQLUNIT_XMLTestRunner(string file) : _file(file), _currentSuite(NULL) {
        _xml.setRootElement(new MQLLIB_XML_Element("testsuites"));
    };

    /// @brief Destructor
    ~MQLUNIT_XMLTestRunner() {};

    // MQLUNIT_TestListener implementation {

    /// @brief Registeres a test failure.
    /// @param failure : failure details
    /// @see MQLUNIT_TestFailure
    void addFailure(MQLUNIT_TestFailure* failure);

    /// @brief Test suite started event.
    /// @param test : test case reference
    void startSuite(MQLUNIT_Test* test);

    /// @brief Test suite ended event.
    /// @param test : test case reference
    void endSuite(MQLUNIT_Test* test);

    /// @brief Test started event.
    /// @param test : test case reference
    /// @param name : name of a test
    void startTest(MQLUNIT_Test* test, const string name);

    /// @brief Test ended event.
    /// @param test : test case reference
    /// @param name : name of a test
    void endTest(MQLUNIT_Test* test, const string name);

    // }

    // MQLUNIT_TestRunner implementation {

    /// @brief Run a test and output the result to the console.
    /// @param test : a test to run
    /// @return true, if all tests succeeded, false if there were failures
    /// @see MQLUNIT_Test
    bool run(MQLUNIT_Test* test);

    // }

private:
    string getFileName(string testName);

};

//-----------------------------------------------------------------------------

string MQLUNIT_XMLTestRunner::getFileName(string testName) {
    string result = testName;
    int tail = StringFind(testName, "<");
    if (tail != -1) {
        result = StringSubstr(testName, 0, tail);
    }
    StringReplace(result, "_", "\\");
    return result;
}

//-----------------------------------------------------------------------------

void MQLUNIT_XMLTestRunner::startSuite(MQLUNIT_Test* test) {
    _currentSuite = new MQLLIB_XML_Element("testsuite");
    _currentSuite.addAttribute("name", getFileName(test.getName()));
}

//-----------------------------------------------------------------------------

void MQLUNIT_XMLTestRunner::endSuite(MQLUNIT_Test* test) {
    _currentSuite.addAttribute("tests", _currentSuite.elementCount());
    _xml.rootElement().addElement(_currentSuite);
}

//-----------------------------------------------------------------------------

void MQLUNIT_XMLTestRunner::startTest(MQLUNIT_Test* test, const string name) {
    _currentTest = new MQLLIB_XML_Element("testcase");
    _currentTest.addAttribute("classname", test.getName());
    _currentTest.addAttribute("name", name);
}

//-----------------------------------------------------------------------------

void MQLUNIT_XMLTestRunner::endTest(MQLUNIT_Test* test, const string name) {
    _currentSuite.addElement(_currentTest);
}

//-----------------------------------------------------------------------------

void MQLUNIT_XMLTestRunner::addFailure(MQLUNIT_TestFailure* failure) {
    _failures.add(failure);
    string message = StringFormat(
        "%s(%s:%i): %s", failure.getMethod(), failure.getFile(),
        failure.getLine(), failure.getMessage()
    );
    MQLLIB_XML_Element* failXml = new MQLLIB_XML_Element("failure", message);
    failXml.addAttribute("message", failure.getMessage());
    _currentTest.addElement(failXml);
}

//-----------------------------------------------------------------------------

bool MQLUNIT_XMLTestRunner::run(MQLUNIT_Test* test) {
    MQLUNIT_TestResult result;
    result.addListener(&this);

    double startTime = GetTickCount();
    test.run(&result);
    double endTime = GetTickCount();

    _xml.rootElement().addAttribute("name", test.getName());

    _xml.rootElement().addAttribute(
        "time", StringFormat("%.6f", (endTime - startTime) / 1000)
    );

    _xml.rootElement().addAttribute("tests", result.runCount());

    _xml.rootElement().addAttribute( "failures", _failures.size());

    CFileTxt file;
    file.Open(_file, FILE_WRITE | FILE_TXT);
    file.WriteString(_xml.toString());
    file.Close();

    return _failures.size() == 0;
}

//-----------------------------------------------------------------------------

#endif
