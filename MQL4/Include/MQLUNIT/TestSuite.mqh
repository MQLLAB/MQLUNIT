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

/// @brief Test case..
class MQLUNIT_TestSuite : public MQLUNIT_Test {
private:
    MQLLIB_Collections_Vector<MQLUNIT_Test*> _tests;
public:
    MQLUNIT_TestSuite() : MQLUNIT_Test(typename(this)) {};
    MQLUNIT_TestSuite(const string name) : MQLUNIT_Test(name) {};
    virtual ~MQLUNIT_TestSuite() {};
    virtual void addTest(MQLUNIT_Test* test) { _tests.add(test); };
    virtual void run(MQLUNIT_TestResult* result);
};


//-----------------------------------------------------------------------------
void MQLUNIT_TestSuite::run(MQLUNIT_TestResult* result) {
    MQLLIB_FOREACHV(MQLUNIT_Test*, test, _tests) {
        test.run(result);
    }
}

//-----------------------------------------------------------------------------

#endif
