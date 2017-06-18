/// @file   MQLUNIT.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  Single include file for the MQLUNIT library.

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

#ifndef MQLUNIT_MQLUNIT_MQH
#define MQLUNIT_MQLUNIT_MQH

#include "Assert.mqh"
#include "ComparisonCompactor.mqh"
#include "ConsoleTestRunner.mqh"
#include "Constants.mqh"
#include "TerminalTestRunner.mqh"
#include "Test.mqh"
#include "TestCase.mqh"
#include "TestFailure.mqh"
#include "TestResult.mqh"
#include "TestRunner.mqh"
#include "TestSuite.mqh"
#include "TextFileTestRunner.mqh"
#include "XMLTestRunner.mqh"

//-----------------------------------------------------------------------------

/// @brief Fail the test providing a specific failure description.
#define ASSERT_FAIL(message) if (!__failed__) {                              \
    string __message__ = MQLUNIT_Assert::fail(message);                      \
    if (__message__ != NULL) {                                               \
        __result__.addFailure(                                               \
            new MQLUNIT_TestFailure(                                         \
                &this, __FILE__, __LINE__, __testName__, __message__         \
            )                                                                \
        );                                                                   \
        __failed__ = true;                                                   \
    }                                                                        \
}

//-----------------------------------------------------------------------------

/// @brief Asserts that the @a entity is NULL.
#define ASSERT_NULL(message, entity) if (!__failed__) {                      \
    string __message__ = MQLUNIT_Assert::assertNull(message, entity);        \
    if (__message__ != NULL) {                                               \
        __result__.addFailure(                                               \
            new MQLUNIT_TestFailure(                                         \
                &this, __FILE__, __LINE__, __testName__, __message__         \
            )                                                                \
        );                                                                   \
        __failed__ = true;                                                   \
    }                                                                        \
}

//-----------------------------------------------------------------------------

/// @brief Asserts that the @a entity is not NULL.
#define ASSERT_NOT_NULL(message, entity) if (!__failed__) {                  \
    string __message__ = MQLUNIT_Assert::assertNotNull(message, entity);     \
    if (__message__ != NULL) {                                               \
        __result__.addFailure(                                               \
            new MQLUNIT_TestFailure(                                         \
                &this, __FILE__, __LINE__, __testName__, __message__         \
            )                                                                \
        );                                                                   \
        __failed__ = true;                                                   \
    }                                                                        \
}

//-----------------------------------------------------------------------------

/// @brief Asserts that the boolean @a condition is true.
#define ASSERT_TRUE(message, condition) if (!__failed__) {                   \
    string __message__ = MQLUNIT_Assert::assertTrue(message, condition);     \
    if (__message__ != NULL) {                                               \
        __result__.addFailure(                                               \
            new MQLUNIT_TestFailure(                                         \
                &this, __FILE__, __LINE__, __testName__, __message__         \
            )                                                                \
        );                                                                   \
        __failed__ = true;                                                   \
    }                                                                        \
}

//-----------------------------------------------------------------------------

/// @brief Asserts that the boolean @a condition is false.
#define ASSERT_FALSE(message, condition) if (!__failed__) {                  \
    string __message__ = MQLUNIT_Assert::assertFalse(message, condition);    \
    if (__message__ != NULL) {                                               \
        __result__.addFailure(                                               \
            new MQLUNIT_TestFailure(                                         \
                &this, __FILE__, __LINE__, __testName__, __message__         \
            )                                                                \
        );                                                                   \
        __failed__ = true;                                                   \
    }                                                                        \
}

//-----------------------------------------------------------------------------

/// @brief Asserts that the entity @a actual is equal to the entity @a expected.
///
/// Entities can be values, strings, variables of the primitive types, object
/// references, pointers or arrays of primitive types, object references or
/// pointers.
///
/// @note Enumeration values, function pointers and arrays of enumeration
/// values or function pointers are not supported and will generate an error
/// during the compilation.
#define ASSERT_EQUALS(message, expected, actual) if (!__failed__) {          \
    string __message__ = MQLUNIT_Assert::assertEquals(                       \
        message, expected, actual                                            \
    );                                                                       \
    if (__message__ != NULL) {                                               \
        __result__.addFailure(                                               \
            new MQLUNIT_TestFailure(                                         \
                &this, __FILE__, __LINE__, __testName__, __message__         \
            )                                                                \
        );                                                                   \
        __failed__ = true;                                                   \
    }                                                                        \
}

//-----------------------------------------------------------------------------

/// @brief Asserts that the number @a actual is equal to the entity @a
/// expected in respect to @a delta.
#define ASSERT_EQUALS_DELTA(message, expected, actual, delta)                \
    if (!__failed__) {                                                       \
        string __message__ = MQLUNIT_Assert::assertEqualsDelta(              \
            message, expected, actual, delta                                 \
        );                                                                   \
        if (__message__ != NULL) {                                           \
            __result__.addFailure(                                           \
                new MQLUNIT_TestFailure(                                     \
                    &this, __FILE__, __LINE__, __testName__, __message__     \
                )                                                            \
            );                                                               \
            __failed__ = true;                                               \
        }                                                                    \
    }

//-----------------------------------------------------------------------------
/// @brief Starts the MQLUNIT test block definition.
#define MQLUNIT_START virtual void run(                                      \
    MQLUNIT_TestResult* __result__, bool __inherit__ = false                 \
) {                                                                          \
    if (!__inherit__) { __result__.startSuite(&this); }

//-----------------------------------------------------------------------------

/// @brief Enables running inherited tests from the superclass.
#define MQLUNIT_INHERIT(super) super::run(__result__, true);

//-----------------------------------------------------------------------------

/// @brief Defines a beginning of test with a @a name.
#define TEST_START(name) {                                                   \
    string __testName__ = StringConcatenate("test", #name);                  \
    bool __failed__ = false;                                                 \
    setUp();                                                                 \
    __result__.startTest(&this, __testName__);

//-----------------------------------------------------------------------------

/// @brief Defines an end of a test.
#define TEST_END ;                                                           \
    __result__.endTest(&this, __testName__);                                 \
    tearDown();                                                              \
}

//-----------------------------------------------------------------------------

/// @brief Ends the MQLUNIT test block definition.
#define MQLUNIT_END if (!__inherit__) { __result__.endSuite(&this); }       \
};

//-----------------------------------------------------------------------------

#endif
