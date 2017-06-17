/// @file   TestData.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  Various classes and test data for MQLUNIT tests.

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

#ifndef SCRIPTS_MQLUNIT_TESTS_TESTDATA_MQH
#define SCRIPTS_MQLUNIT_TESTS_TESTDATA_MQH

#include <MQLUNIT/MQLUNIT.mqh>

//-----------------------------------------------------------------------------
class __Object__ {
private:
  int _data;
public:
  __Object__() : _data(-1) {};
  __Object__(int data) : _data(data) {};
  void operator=(const __Object__& that) { this._data = that._data; };
  bool operator !=(const __Object__& that) const {
      return this._data != that._data;
  };
  bool operator ==(const __Object__* that) const {
      return this._data == that._data;
  };

};

//-----------------------------------------------------------------------------

class __AnotherObject__ {};

class __Failure__ : public MQLUNIT_TestCase {
public:
    __Failure__() : MQLUNIT_TestCase(typename(this))  {};
    __Failure__(string name) : MQLUNIT_TestCase(name) {};

    MQLUNIT_START

    //----------------------------------------

    TEST_START(Failure) {
        ASSERT_FAIL(NULL);
    }
    TEST_END

    //----------------------------------------

    MQLUNIT_END
};

//-----------------------------------------------------------------------------

class __Success__ : public MQLUNIT_TestCase {
public:
    __Success__() : MQLUNIT_TestCase(typename(this))  {};
    __Success__(string name) : MQLUNIT_TestCase(name) {};

    MQLUNIT_START

    //----------------------------------------

    TEST_START(Success) {
    }
    TEST_END

    //----------------------------------------

    MQLUNIT_END
};

//-----------------------------------------------------------------------------

class __TornDown__ : public MQLUNIT_TestCase {
private:
    bool _tornDown;

public:
    __TornDown__() : MQLUNIT_TestCase(typename(this)),  _tornDown(false) {};
    __TornDown__(string name) : MQLUNIT_TestCase(name), _tornDown(false) {};

    void tearDown() {
        _tornDown = true;
    }

    bool isTornDown() const { return _tornDown; };

    MQLUNIT_START

    //----------------------------------------

    TEST_START(Failure) {
        ASSERT_FAIL(NULL);
    }
    TEST_END

    //----------------------------------------

    MQLUNIT_END
};

//-----------------------------------------------------------------------------

class __SetUp__ : public MQLUNIT_TestCase {
private:
    bool _setUp;

public:
    __SetUp__() : MQLUNIT_TestCase(typename(this)),  _setUp(false) {};
    __SetUp__(string name) : MQLUNIT_TestCase(name), _setUp(false) {};

    void setUp() {
        _setUp = true;
    }

    bool isSetUp() const { return _setUp; };

    MQLUNIT_START

    //----------------------------------------

    TEST_START(Failure) {
        ASSERT_FAIL(NULL);
    }
    TEST_END

    //----------------------------------------

    MQLUNIT_END
};

//-----------------------------------------------------------------------------

class __WasRun__ : public MQLUNIT_TestCase {
private:
    bool _wasRun;
public:
    __WasRun__() : MQLUNIT_TestCase(typename(this)),  _wasRun(false) {};
    __WasRun__(string name) : MQLUNIT_TestCase(name), _wasRun(false) {};

    void run(MQLUNIT_TestResult* result, bool inherited = true) {
        _wasRun = true;
    };
    bool wasRun() { return _wasRun; };
};

//-----------------------------------------------------------------------------

class __OneTestCase__ : public MQLUNIT_TestCase {
public:
    __OneTestCase__() : MQLUNIT_TestCase(typename(this))  {};
    __OneTestCase__(string name) : MQLUNIT_TestCase(name) {};

    MQLUNIT_START

    //----------------------------------------

    TEST_START(OnetTest) {
    }
    TEST_END

    //----------------------------------------

    MQLUNIT_END
};

//-----------------------------------------------------------------------------

class __InheritedTestCase__ : public __OneTestCase__ {
public:
    __InheritedTestCase__() : __OneTestCase__(typename(this))  {};
    __InheritedTestCase__(string name) : __OneTestCase__(name) {};

    MQLUNIT_START
    MQLUNIT_INHERIT(__OneTestCase__)

    //----------------------------------------

    TEST_START(TwoTest) {
    }
    TEST_END

    //----------------------------------------

    MQLUNIT_END
};

//-----------------------------------------------------------------------------

class __NoTestCases__ : public MQLUNIT_TestCase {
public:
    __NoTestCases__() : MQLUNIT_TestCase(typename(this))  {};
    __NoTestCases__(string name) : MQLUNIT_TestCase(name) {};

    MQLUNIT_START
    MQLUNIT_END
};

//-----------------------------------------------------------------------------

class __TestListener__ : public MQLUNIT_TestListener {
public:
	uint startCount;
	uint endCount;
	uint failureCount;
    bool suiteStarted;
    bool suiteEnded;

public:
    __TestListener__() :
        startCount(0), endCount(0), failureCount(0),
        suiteStarted(false), suiteEnded(false) {};
    void addFailure(MQLUNIT_TestFailure* failure) { failureCount++; };
    void startTest(MQLUNIT_Test* test, const string name) { startCount++; };
    void endTest(MQLUNIT_Test* test, const string name) { endCount++; };
    void startSuite(MQLUNIT_Test* test) { suiteStarted = true; };
    void endSuite(MQLUNIT_Test* test) { suiteEnded = true; };
};

//-----------------------------------------------------------------------------

class __Test__ : public MQLUNIT_Test {
private:
    bool _wasRun;
public:
    __Test__() : MQLUNIT_Test(typename(this)),  _wasRun(false) {};
    __Test__(string name) : MQLUNIT_Test(name), _wasRun(false) {};

    void run(MQLUNIT_TestResult* result, bool inherited = false) {
        _wasRun = true;
    }

    bool wasRun() const { return _wasRun; };
};

//-----------------------------------------------------------------------------

#endif
