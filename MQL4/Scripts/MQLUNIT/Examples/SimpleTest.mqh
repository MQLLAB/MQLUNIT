/// @file   SimpleTest.mq4
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLUNIT examples : SimpleTest class definition.

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

#ifndef SCRIPTS_MQLUNIT_EXAMPLES_SIMPLETEST_MQH
#define SCRIPTS_MQLUNIT_EXAMPLES_SIMPLETEST_MQH

#include <MQLUNIT/MQLUNIT.mqh>

//-----------------------------------------------------------------------------

/// @brief Example MQLUNI test case.
class MQLUNIT_Examples_SimpleTest : public MQLUNIT_TestCase {
private:
    int _value1;
    int _value2;

public:
    MQLUNIT_Examples_SimpleTest() : MQLUNIT_TestCase(typename(this))  {};
    MQLUNIT_Examples_SimpleTest(string name) : MQLUNIT_TestCase(name) {};

    void setUp() {
        _value1 = 2;
        _value2 = 3;
    }

    MQLUNIT_START

    //----------------------------------------

    TEST_START(Add) {
		double result = _value1 + _value2;
        Print(result == 6.0);

        // forced failure result == 5.0
		ASSERT_TRUE("", result == 6.0);
    }
    TEST_END

    //----------------------------------------

    TEST_START(Equals) {
        ASSERT_EQUALS("Integers must be equal", (int) 12, (int) 12);
        ASSERT_EQUALS("Doubles must be equal", 12.0, 12.0);
        ASSERT_EQUALS_DELTA("Capacity", 12.0, 11.99, 0.1);
    }
    TEST_END

    //----------------------------------------

    MQLUNIT_END
};

//-----------------------------------------------------------------------------

#endif
