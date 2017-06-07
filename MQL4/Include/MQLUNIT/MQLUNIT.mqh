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
#include "ConsoleTestRunner.mqh"
#include "Constants.mqh"
#include "TerminalTestRunner.mqh"
#include "Test.mqh"
#include "TestCase.mqh"
#include "TestFailure.mqh"
#include "TestResult.mqh"
#include "TestRunner.mqh"
#include "TestSuite.mqh"

//-----------------------------------------------------------------------------

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

#define ASSERT_NULL(message, condition) if (!__failed__) {                   \
    string __message__ = MQLUNIT_Assert::assertNull(message, condition);     \
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

#define ASSERT_NOT_NULL(message, condition) if (!__failed__) {               \
    string __message__ = MQLUNIT_Assert::assertNotNull(message, condition);  \
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

#define ASSERT_EQUALS(message, expected, actual) if (!__failed__) {          \
    string __message__ = MQLUNIT_Assert::assertEquals(                       \
        message, expected, actual                                            \
    );                                                                       \
    if (__message__ != NULL) {                                               \
        __result__.addFailure(                                               \
            new MQLUNIT_TestFailure(                                         \
                &this, __FILE__, __LINE__, __testName__, __message__         \
            )                                                                \
        )                                                                    \
      __failed__ = true;                                                     \
    }                                                                        \
}

//-----------------------------------------------------------------------------

#define MQLUNIT_START virtual void run(MQLUNIT_TestResult* __result__) {
     
//-----------------------------------------------------------------------------

#define TEST_START(name) {                                                   \
    string __testName__ = StringConcatenate("test", #name);                  \
    bool __failed__ = false;                                                 \
    setUp();                                                                 \
    __result__.startTest(__testName__);

//-----------------------------------------------------------------------------

#define TEST_END ;                                                           \
    __result__.endTest(__testName__);                                        \
    tearDown();                                                              \
}

//-----------------------------------------------------------------------------

#define MQLUNIT_END };

//-----------------------------------------------------------------------------

#endif