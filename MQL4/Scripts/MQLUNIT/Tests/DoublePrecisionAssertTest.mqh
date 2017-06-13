/// @file   AssertTest.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  Test case for MQLUNIT_Assert class.

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

#ifndef SCRIPTS_MQLUNIT_TESTS_DOUBLEPRECISIONASSERTTEST_MQH
#define SCRIPTS_MQLUNIT_TESTS_DOUBLEPRECISIONASSERTTEST_MQH

#include <MQLUNIT/MQLUNIT.mqh>
#include <MQLLIB/Lang/Number.mqh>

//-----------------------------------------------------------------------------

class MQLUNIT_Tests_DoublePrecisionAssertTest : public MQLUNIT_TestCase {
public:
    MQLUNIT_Tests_DoublePrecisionAssertTest()
        : MQLUNIT_TestCase(typename(this)) {};

    MQLUNIT_Tests_DoublePrecisionAssertTest(string name)
        : MQLUNIT_TestCase(name) {};

    MQLUNIT_START

    //----------------------------------------

    TEST_START(AssertEqualsDelta) {
        double d1 = 1.000001;
        double d2 = 1.0;
        double delta1 = 0.00001;

        string result = MQLUNIT_Assert::assertEqualsDelta(
            "Doubles must be equal within an acceptable error", d2, d1, delta1
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertEqualsDelta() must report success");
        }

        float f1 = 1.0001f;
        float f2 = 1.0f;
        float delta2 = 0.001f;

        result = MQLUNIT_Assert::assertEqualsDelta(
            "Floats must be equal within an acceptable error", f2, f1, delta2
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertEqualsDelta() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertEqualsDeltaFails) {
        double d1 = 1.000001;
        double d2 = 1.0;
        double delta1 = 0.0000001;

        string result = MQLUNIT_Assert::assertEqualsDelta(
            "Doubles must be equal within an acceptable error", d2, d1, delta1
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEqualsDelta() must report failure");
        }

        float f1 = 1.001f;
        float f2 = 1.0f;
        float delta2 = 0.0001f;

        result = MQLUNIT_Assert::assertEqualsDelta(
            "Floats must be equal within an acceptable error", f2, f1, delta2
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEqualsDelta() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertDoubleEqualsDeltaNaNFails) {
        string result = MQLUNIT_Assert::assertEqualsDelta(
            "Number is equal to NaN", 1.234, MQLLIB_Lang_Double::NaN, 0.0
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEqualsDelta() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertDoubleNaNEqualsFails) {
        string result = MQLUNIT_Assert::assertEqualsDelta(
            "NaN is equal to a number", MQLLIB_Lang_Double::NaN, 1.234, 0.0
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEqualsDelta() must report failure");
        }
    }
    TEST_END

     //----------------------------------------

    TEST_START(AssertSingleEqualsDeltaNaNFails) {
        string result = MQLUNIT_Assert::assertEqualsDelta(
            "Number is equal to NaN", 1.234f, MQLLIB_Lang_Single::NaN, 0.0
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEqualsDelta() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertSingleNaNEqualsFails) {
        string result = MQLUNIT_Assert::assertEqualsDelta(
            "NaN is equal to a number", MQLLIB_Lang_Single::NaN, 1.234f, 0.0
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEqualsDelta() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertDoubleNaNEqualsNaN) {
        string result = MQLUNIT_Assert::assertEqualsDelta(
            "NaN is equal to NaN", MQLLIB_Lang_Double::NaN,
            MQLLIB_Lang_Double::NaN, 0.0
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertEqualsDelta() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertSingleNaNEqualsNaN) {
        string result = MQLUNIT_Assert::assertEqualsDelta(
            "NaN is equal to NaN", MQLLIB_Lang_Single::NaN,
            MQLLIB_Lang_Single::NaN, 0.0
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertEqualsDelta() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertDoublePosInfinityNotEqualsNegInfinity) {
        string result = MQLUNIT_Assert::assertEqualsDelta(
            "Posotive infinity equals negative infinity",
            MQLLIB_Lang_Double::PositiveInfinity,
            MQLLIB_Lang_Double::NegativeInfinity, 0.0
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEqualsDelta() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertDoublePosInfinityNotEquals) {
        string result = MQLUNIT_Assert::assertEqualsDelta(
            "Positive infinity equals a number",
            MQLLIB_Lang_Double::PositiveInfinity,
            1.23, 0.0
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEqualsDelta() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertSinglePosInfinityNotEqualsNegInfinity) {
        string result = MQLUNIT_Assert::assertEqualsDelta(
            "Posotive infinity equals negative infinity",
            MQLLIB_Lang_Single::PositiveInfinity,
            MQLLIB_Lang_Single::NegativeInfinity, 0.0
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEqualsDelta() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertSinglePosInfinityNotEquals) {
        string result = MQLUNIT_Assert::assertEqualsDelta(
            "Positive infinity equals a number",
            MQLLIB_Lang_Single::PositiveInfinity,
            1.23, 0.0
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEqualsDelta() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertDoubleNegInfinityNotEquals) {
        string result = MQLUNIT_Assert::assertEqualsDelta(
            "Negative infinity equals a number",
            MQLLIB_Lang_Double::NegativeInfinity,
            -1.23, 0.0
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEqualsDelta() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertSingleNegInfinityNotEquals) {
        string result = MQLUNIT_Assert::assertEqualsDelta(
            "Negative infinity equals a number",
            MQLLIB_Lang_Single::NegativeInfinity,
            -1.23, 0.0
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEqualsDelta() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertDoublePosInfinityEqualsInfinity) {
        string result = MQLUNIT_Assert::assertEqualsDelta(
            "Positive infinity must be equal to self",
            MQLLIB_Lang_Double::PositiveInfinity,
            MQLLIB_Lang_Double::PositiveInfinity, 0.0
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertEqualsDelta() must report success");
        }
    }
    TEST_END

     //----------------------------------------

    TEST_START(AssertSinglePosInfinityEqualsInfinity) {
        string result = MQLUNIT_Assert::assertEqualsDelta(
            "Positive infinity must be equal to self",
            MQLLIB_Lang_Single::PositiveInfinity,
            MQLLIB_Lang_Single::PositiveInfinity, 0.0
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertEqualsDelta() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertDoubleNegInfinityEqualsInfinity) {
        string result = MQLUNIT_Assert::assertEqualsDelta(
            "Positive infinity must be equal to self",
            MQLLIB_Lang_Double::NegativeInfinity,
            MQLLIB_Lang_Double::NegativeInfinity, 0.0
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertEqualsDelta() must report success");
        }
    }
    TEST_END

     //----------------------------------------

    TEST_START(AssertSingleNegInfinityEqualsInfinity) {
        string result = MQLUNIT_Assert::assertEqualsDelta(
            "Positive infinity must be equal to self",
            MQLLIB_Lang_Single::NegativeInfinity,
            MQLLIB_Lang_Single::NegativeInfinity, 0.0
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertEqualsDelta() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    MQLUNIT_END
};

//-----------------------------------------------------------------------------

#endif
