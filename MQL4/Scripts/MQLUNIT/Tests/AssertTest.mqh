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

#ifndef SCRIPTS_MQLUNIT_TESTS_ASSERTTEST_MQH
#define SCRIPTS_MQLUNIT_TESTS_ASSERTTEST_MQH

#include <MQLUNIT/MQLUNIT.mqh>
#include <MQLLIB/Lang/Pointer.mqh>

#include "TestData.mqh"

//-----------------------------------------------------------------------------

// Test for the Assert class. All other tests rely on the assertion system,
// therefore this test case must be run prior to any other test case.
class MQLUNIT_Tests_AssertTest : public MQLUNIT_TestCase {
public:
    MQLUNIT_Tests_AssertTest() : MQLUNIT_TestCase(typename(this)) {};
    MQLUNIT_Tests_AssertTest(string name) : MQLUNIT_TestCase(name) {};

    MQLUNIT_START

    //----------------------------------------

    // This is the most fundamental assertions test. This assertion is used in
    // ASSERT_FAIL macro to fail other tests, so it's defined here directly.
    TEST_START(Fails) {
        string result = MQLUNIT_Assert::fail();
        if (result == NULL) {
            __result__.addFailure(
                new MQLUNIT_TestFailure(
                    &this, __FILE__, __LINE__,
                    __testName__, "Assert::fail() returned NULL"
                )
            );
        __failed__ = true;
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertNullDouble) {
        double d1 = NULL;

        string result = MQLUNIT_Assert::assertNull("NULL must be NULL", d1);
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertNull() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertNullString) {
        string nullStr = NULL;

        string result = MQLUNIT_Assert::assertNull(
            "NULL must be NULL", nullStr
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertNull() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertNullPointer) {
        __Object__* obj = NULL;

        string result = MQLUNIT_Assert::assertNull("Object must be NULL", obj);
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertNull() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertNullPointerFails) {
        MQLLIB_Lang_AutoPtr<__Object__> obj = new __Object__(0);

        string result = MQLUNIT_Assert::assertNull(
            "Object must be NULL", obj.p
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertNull() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertNullStringFails) {
        string str = "content";

        string result = MQLUNIT_Assert::assertNull("NULL must be NULL", str);
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertNull() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertNullDoubleFails) {
        double d1 = 1.25;

        string result = MQLUNIT_Assert::assertNull("NULL must be NULL", d1);
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertNull() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertNotNullDouble) {
        double d1 = 1.25;

        string result = MQLUNIT_Assert::assertNotNull(
            "Number must not be NULL", d1
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertNotNull() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertNotNullString) {
        string str = "content";

        string result = MQLUNIT_Assert::assertNotNull(
            "String must not be NULL", str
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertNotNull() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertNotNullStringFails) {
        string nullStr = NULL;

        string result = MQLUNIT_Assert::assertNotNull(
            "String must not be NULL", nullStr
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertNotNull() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertNotNullPointer) {
        MQLLIB_Lang_AutoPtr<__Object__> obj = new __Object__(0);

        string result = MQLUNIT_Assert::assertNotNull(
            "Object must not be NULL", obj.p
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertNotNull() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertNotNullPointerFails) {
        __Object__* obj = NULL;

        string result = MQLUNIT_Assert::assertNotNull(
            "Object must not be NULL", obj
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertNotNull() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertEqualObject) {
        __Object__ obj(0);

        string result = MQLUNIT_Assert::assertEquals(
            "Object must be equal to self", obj, obj
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertEqualObjects) {
        __Object__ obj1(0);
        __Object__ obj2(0);

        string result = MQLUNIT_Assert::assertEquals(
            "Objects must be equal", obj1, obj2
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertEqualReferences) {
        MQLLIB_Lang_AutoPtr<__Object__> obj1 = new __Object__(0);
        MQLLIB_Lang_AutoPtr<__Object__> obj2 = new __Object__(0);

        string result = MQLUNIT_Assert::assertEquals(
            "Objects must be equal", *obj1.p, *obj2.p
        );
        if (result != NULL) {
          ASSERT_FAIL("Assert::assertEquals() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertEqualObjectFails) {
        __Object__ obj1(1);
        __Object__ obj2(2);

        string result = MQLUNIT_Assert::assertEquals(
          "Objects must be equal", obj1, obj2
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertEqualReferencesFails) {
        MQLLIB_Lang_AutoPtr<__Object__> obj1 = new __Object__(0);
        MQLLIB_Lang_AutoPtr<__Object__> obj2 = new __Object__(1);

        string result = MQLUNIT_Assert::assertEquals(
            "Objects must be equal", *obj1.p, *obj2.p
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertEqualDouble) {
        double d1 = 1.25;

        string result = MQLUNIT_Assert::assertEquals(
            "Numbers must be equal", 1.25, d1
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertStringEquals) {
        string s1 = "foo";

        string result = MQLUNIT_Assert::assertEquals(
            "Strings must be equal", "foo", s1
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertStringNotEqualsNull) {
        string s1 = NULL;

        string result = MQLUNIT_Assert::assertEquals(
            "Strings must be equal", "foo", s1
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertTrue) {
        string result = MQLUNIT_Assert::assertTrue("Must be true", true);
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertTrue() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertTrueFails) {
        string result = MQLUNIT_Assert::assertTrue("Must be true", false);
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertTrue() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertFalse) {
        string result = MQLUNIT_Assert::assertFalse("Must be false", false);
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertFalse() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertFalseFails) {
        string result = MQLUNIT_Assert::assertFalse("Must be false", true);
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertFalse() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertSame) {
        __AnotherObject__ obj;

        string result = MQLUNIT_Assert::assertSame("Must be same", obj, obj);
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertSame() must report success");
       }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertSamePointer) {
        MQLLIB_Lang_AutoPtr<__AnotherObject__> obj = new __AnotherObject__();

        string result = MQLUNIT_Assert::assertSame(
            "Must be same", *obj.p, *obj.p
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertSame() must report success");
        }
    }
    TEST_END

    //----------------------------------------


    TEST_START(AssertSameFails) {
        __AnotherObject__ obj1;
        __AnotherObject__ obj2;

        string result = MQLUNIT_Assert::assertSame("Must be same", obj1, obj2);
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertSame() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertSamePointerFails) {
        MQLLIB_Lang_AutoPtr<__AnotherObject__> obj1 = new __AnotherObject__();
        MQLLIB_Lang_AutoPtr<__AnotherObject__> obj2 = new __AnotherObject__();

        string result = MQLUNIT_Assert::assertSame(
            "Must be same", *obj1.p, *obj2.p
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertSame() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertNotSame) {
        __AnotherObject__ obj1;
        __AnotherObject__ obj2;

        string result = MQLUNIT_Assert::assertNotSame(
            "Must not be same", obj1, obj2
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertNotSame() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertNotSamePointer) {
        MQLLIB_Lang_AutoPtr<__AnotherObject__> obj1 = new __AnotherObject__();
        MQLLIB_Lang_AutoPtr<__AnotherObject__> obj2 = new __AnotherObject__();

        string result = MQLUNIT_Assert::assertNotSame(
            "Must not be same", *obj1.p, *obj2.p
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertNotSame() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertNotSameFails) {
        __AnotherObject__ obj;

        string result = MQLUNIT_Assert::assertNotSame(
            "Must not be same", obj, obj
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertNotSame() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertNotSamePointerFails) {
        MQLLIB_Lang_AutoPtr<__AnotherObject__> obj = new __AnotherObject__();

        string result = MQLUNIT_Assert::assertNotSame(
            "Must not be same", *obj.p, *obj.p
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertNotSame() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertDoubleArrayEqualsSelf) {
        double d[] = { 1.1, 2.2, 3.3, 4.4 };

        string result = MQLUNIT_Assert::assertEquals(
            "Double array be equal to self", d, d
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertStringArrayEqualsSelf) {
        string s[] = { "a1=1.1", "a2=2.2", "a3=3.3", "a4=4.4" };

        string result = MQLUNIT_Assert::assertEquals(
            "String array be equal to self", s, s
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertObjectArrayEqualsSelf) {
        __Object__ obj1(0);
        __Object__ obj2(1);

        __Object__ o[4];
        o[0] = obj1;
        o[1] = obj2;
        o[2] = obj1;
        o[3] = obj2;

        string result = MQLUNIT_Assert::assertEquals(
            "Object array be equal to self", o, o
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertPointerArrayEqualsSelf) {
        MQLLIB_Lang_AutoPtr<__Object__> obj1 = new __Object__(0);
        MQLLIB_Lang_AutoPtr<__Object__> obj2 = new __Object__(1);

        __Object__* o[4];
        o[0] = obj1.p;
        o[1] = obj2.p;
        o[2] = obj1.p;
        o[3] = obj2.p;

        string result = MQLUNIT_Assert::assertEquals(
            "Pointer array be equal to self", o, o
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report success");
       }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertDoubleArrayEquals) {
        double d1[] = { 1.1, 2.2, 3.3, 4.4 };
        double d2[] = { 1.1, 2.2, 3.3, 4.4 };

        string result = MQLUNIT_Assert::assertEquals(
            "Double arrays must be equal", d1, d2
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertDoubleArrayEqualsFails) {
        double d1[] = { 1.1, 2.2, 3.3, 4.4 };
        double d2[] = { 4.4, 3.3, 2.2, 1.1 };
        double d3[] = { 1.1, 2.2 };
        double d4[];

        string result = MQLUNIT_Assert::assertEquals(
            "Double arrays must be equal", d1, d4
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report failure");
        }

        result = MQLUNIT_Assert::assertEquals(
            "Double arrays must be equal", d1, d3
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report failure");
        }

        result = MQLUNIT_Assert::assertEquals(
            "Double arrays must be equal", d1, d2
        );
        if (result == NULL) {
          ASSERT_FAIL("Assert::assertEquals() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertStringArrayEquals) {
        string s1[] = { "one", "two" };
        string s2[] = { "one", "two" };

        string result = MQLUNIT_Assert::assertEquals(
            "String arrays must be equal", s1, s2
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report success");
       }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertStringArrayEqualsFails) {
        string s1[] = { "one", "two" };
        string s2[] = { "two", "one" };
        string s3[] = { "one" };

        string result = MQLUNIT_Assert::assertEquals(
            "String arrays must be equal", s1, s3
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report failure");
        }

        result = MQLUNIT_Assert::assertEquals(
            "String arrays must be equal", s1, s2
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertObjectArrayEquals) {
        __Object__ obj1(0);
        __Object__ obj2(1);

        __Object__ o1[2];
        o1[0] = obj1;
        o1[1] = obj2;

        __Object__ o2[2];
        o2[0] = obj1;
        o2[1] = obj2;

        string result = MQLUNIT_Assert::assertEquals(
            "Object arrays must be equal", o1, o2
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertObjectArrayEqualsFails) {
        __Object__ obj1(0);
        __Object__ obj2(1);

        __Object__ o1[2];
        o1[0] = obj1;
        o1[1] = obj2;

        __Object__ o2[2];
        o2[0] = obj2;
        o2[1] = obj1;

        __Object__ o3[1];
        o3[0] = obj1;

        string result = MQLUNIT_Assert::assertEquals(
            "Object arrays must be equal", o1, o3
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report failure");
        }

        result = MQLUNIT_Assert::assertEquals(
            "Object arrays must be equal", o1, o2
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertPointerArrayEquals) {
        MQLLIB_Lang_AutoPtr<__Object__> obj1 = new __Object__(0);
        MQLLIB_Lang_AutoPtr<__Object__> obj2 = new __Object__(1);

        __Object__* o1[2];
        o1[0] = obj1.p;
        o1[1] = obj2.p;

        __Object__* o2[2];
        o2[0] = obj1.p;
        o2[1] = obj2.p;

        string result = MQLUNIT_Assert::assertEquals(
            "Pointer arrays must be equal", o1, o2
        );
        if (result != NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report success");
        }
    }
    TEST_END

    //----------------------------------------

    TEST_START(AssertPointerArrayEqualsFails) {
        MQLLIB_Lang_AutoPtr<__Object__> obj1 = new __Object__(0);
        MQLLIB_Lang_AutoPtr<__Object__> obj2 = new __Object__(1);

        __Object__* o1[2];
        o1[0] = obj1.p;
        o1[1] = obj2.p;

        __Object__* o2[2];
        o2[0] = obj2.p;
        o2[1] = obj1.p;

        __Object__* o3[1];
        o3[0] = obj1.p;

        string result = MQLUNIT_Assert::assertEquals(
            "Object arrays must be equal", o1, o3
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report failure");
        }

        result = MQLUNIT_Assert::assertEquals(
            "Object arrays must be equal", o1, o2
        );
        if (result == NULL) {
            ASSERT_FAIL("Assert::assertEquals() must report failure");
        }
    }
    TEST_END

    //----------------------------------------

    MQLUNIT_END
};

//-----------------------------------------------------------------------------

#endif
