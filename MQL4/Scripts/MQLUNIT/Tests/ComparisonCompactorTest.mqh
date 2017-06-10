/// @file   ComparisonCompactorTest.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLUNIT ComparisonCompactorTest test class definition.

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

#ifndef MQLUNIT_COMPARIONCOMPARATORTEST_MQH
#define MQLUNIT_COMPARIONCOMPARATORTEST_MQH

#include <MQLUNIT/MQLUNIT.mqh>

//-----------------------------------------------------------------------------

class MQLUNIT_ComparisonCompactorTest : public MQLUNIT_TestCase {
public:
    MQLUNIT_ComparisonCompactorTest() : MQLUNIT_TestCase(typename(this)) {};
    MQLUNIT_ComparisonCompactorTest(string name) : MQLUNIT_TestCase(name) {};

    MQLUNIT_START

    //----------------------------------------

    TEST_START(Message) {
        MQLUNIT_ComparisonCompactor compactor(0, "b", "c");
		string failure = compactor.compact("a");
        ASSERT_TRUE(
            NULL, "a: expected:<[b]> but was:<[c]>" == failure
        );
    }
    TEST_END

    //----------------------------------------

    TEST_START(StartSame) {
        MQLUNIT_ComparisonCompactor compactor(1, "ba", "bc");
        string failure = compactor.compact(NULL);
        ASSERT_EQUALS(
            NULL, "expected:<b[a]> but was:<b[c]>", failure
        );
    }
    TEST_END

    //----------------------------------------

    TEST_START(EndsSame) {
        MQLUNIT_ComparisonCompactor compactor(1, "ab", "cb");
        string failure = compactor.compact(NULL);
        ASSERT_EQUALS(
            NULL, "expected:<[a]b> but was:<[c]b>", failure
        );
    }
    TEST_END

    //----------------------------------------

    TEST_START(Same) {
        MQLUNIT_ComparisonCompactor compactor(1, "ab", "ab");
        string failure = compactor.compact(NULL);
        ASSERT_EQUALS(
            NULL, "expected:<ab> but was:<ab>", failure
        );
    }
    TEST_END

    //----------------------------------------

    TEST_START(NoContextStartAndEndSame) {
        MQLUNIT_ComparisonCompactor compactor(0, "abc", "adc");
        string failure = compactor.compact(NULL);
        ASSERT_EQUALS(
            NULL, "expected:<...[b]...> but was:<...[d]...>", failure
        );
    }
    TEST_END

    //----------------------------------------

    TEST_START(StartAndEndContext) {
        MQLUNIT_ComparisonCompactor compactor(1, "abc", "adc");
        string failure = compactor.compact(NULL);
        ASSERT_EQUALS(
            NULL, "expected:<a[b]c> but was:<a[d]c>", failure
        );
    }
    TEST_END

    //----------------------------------------

    TEST_START(StartAndEndContextWithEllipses) {
        MQLUNIT_ComparisonCompactor compactor(1, "abcde", "abfde");
        string failure = compactor.compact(NULL);
        ASSERT_EQUALS(
            NULL, "expected:<...b[c]d...> but was:<...b[f]d...>", failure
        );
    }
    TEST_END

    //----------------------------------------

    TEST_START(ComparisonErrorStartSameComplete) {
        MQLUNIT_ComparisonCompactor compactor(2, "ab", "abc");
        string failure = compactor.compact(NULL);
        ASSERT_EQUALS(
            NULL, "expected:<ab[]> but was:<ab[c]>", failure
        );
    }
    TEST_END

    //----------------------------------------

    TEST_START(ComparisonErrorEndSameComplete) {
        MQLUNIT_ComparisonCompactor compactor(0, "bc", "abc");
        string failure = compactor.compact(NULL);
        ASSERT_EQUALS(
            NULL, "expected:<[]...> but was:<[a]...>", failure
        );
    }
    TEST_END

    //----------------------------------------

    TEST_START(ComparisonErrorEndSameCompleteContext) {
        MQLUNIT_ComparisonCompactor compactor(2, "bc", "abc");
        string failure = compactor.compact(NULL);
        ASSERT_EQUALS(
            NULL, "expected:<[]bc> but was:<[a]bc>", failure
        );
    }
    TEST_END

    //----------------------------------------

    TEST_START(ComparisonErrorOverlapingMatches) {
        MQLUNIT_ComparisonCompactor compactor(0, "abc", "abbc");
        string failure = compactor.compact(NULL);
        ASSERT_EQUALS(
            NULL, "expected:<...[]...> but was:<...[b]...>", failure
        );
    }
    TEST_END

    //----------------------------------------

    TEST_START(ComparisonErrorOverlapingMatchesContext) {
        MQLUNIT_ComparisonCompactor compactor(2, "abc", "abbc");
        string failure = compactor.compact(NULL);
        ASSERT_EQUALS(
            NULL, "expected:<ab[]c> but was:<ab[b]c>", failure
        );
    }
    TEST_END

    //----------------------------------------

    TEST_START(ComparisonErrorOverlapingMatches2) {
        MQLUNIT_ComparisonCompactor compactor(0, "abcdde", "abcde");
        string failure = compactor.compact(NULL);
        ASSERT_EQUALS(
            NULL, "expected:<...[d]...> but was:<...[]...>", failure
        );
    }
    TEST_END

    //----------------------------------------

    TEST_START(ComparisonErrorOverlapingMatches2Context) {
        MQLUNIT_ComparisonCompactor compactor(2, "abcdde", "abcde");
        string failure = compactor.compact(NULL);
        ASSERT_EQUALS(
            NULL, "expected:<...cd[d]e> but was:<...cd[]e>", failure
        );
    }
    TEST_END

    //----------------------------------------

    TEST_START(ComparisonErrorWithActualNull) {
        MQLUNIT_ComparisonCompactor compactor(0, "a", NULL);
        string failure = compactor.compact(NULL);
        ASSERT_EQUALS(
            NULL, "expected:<a> but was:<null>", failure
        );
    }
    TEST_END

    //----------------------------------------

    TEST_START(ComparisonErrorWithActualNullContext) {
        MQLUNIT_ComparisonCompactor compactor(2, "a", NULL);
        string failure = compactor.compact(NULL);
        ASSERT_EQUALS(
            NULL, "expected:<a> but was:<null>", failure
        );
    }
    TEST_END

    //----------------------------------------

    TEST_START(ComparisonErrorWithExpectedNull) {
        MQLUNIT_ComparisonCompactor compactor(0, NULL, "a");
        string failure = compactor.compact(NULL);
        ASSERT_EQUALS(
            NULL, "expected:<null> but was:<a>", failure
        );
    }
    TEST_END

    //----------------------------------------

    TEST_START(ComparisonErrorWithExpectedNullContext) {
        MQLUNIT_ComparisonCompactor compactor(2, NULL, "a");
        string failure = compactor.compact(NULL);
        ASSERT_EQUALS(
            NULL, "expected:<null> but was:<a>", failure
        );
    }
    TEST_END

    //----------------------------------------

    TEST_START(AmpersandPresent) {
        MQLUNIT_ComparisonCompactor compactor(10, "S&P500", "0");
        string failure = compactor.compact(NULL);
        ASSERT_EQUALS(
            NULL, "expected:<[S&P50]0> but was:<[]0>", failure
        );
    }
    TEST_END

    //----------------------------------------

    MQLUNIT_END
};

//-----------------------------------------------------------------------------

#endif
