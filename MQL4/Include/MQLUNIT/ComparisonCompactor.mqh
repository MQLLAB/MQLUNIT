/// @file   ComparisonCompactor.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  Definition of MQLUNIT ComparisonCompactor class.

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

#ifndef MQLUNIT_COMPARISONCOMPACTOR_MQH
#define MQLUNIT_COMPARISONCOMPACTOR_MQH

#include "Constants.mqh"

//-----------------------------------------------------------------------------

/// @brief Used to compact the output of the difference between two strings.
class MQLUNIT_ComparisonCompactor {
private:
    const int    _contextLength;
    const string _expected;
    const string _actual;
    int          _prefix;
	int          _suffix;

public:
    /// @brief Constructor : create a new string difference compactor.
    /// @param contextLength : number of characters at which strings are going
    /// to be compacted
    /// @param expected : expected result to be compacted
    /// @param actual   : actual result to be compacted
    MQLUNIT_ComparisonCompactor(
        const int contextLength, const string expected, const string actual
    ) : _contextLength(contextLength), _expected(expected), _actual(actual) {};

    /// @brief Creates a compacted string comparison failure description.
    /// @param message : a failure description
    string compact(const string message);

private:
    string wrapNull(const string value) const;
    string formatMessage(
        const string message, const string expected, const string actual
    ) const;
    void findCommonPrefix();
	void findCommonSuffix();
    string compactString(string source) const;
    string computeCommonPrefix() const;
    string computeCommonSuffix() const;
    string getSubString(const string value, const int start, const int end);
};

//-----------------------------------------------------------------------------

string MQLUNIT_ComparisonCompactor::compact(const string message) {
    if (_expected == NULL || _actual == NULL || _expected == _actual) {
        return formatMessage(message, wrapNull(_expected), wrapNull(_actual));
    }

    findCommonPrefix();
	findCommonSuffix();

	string expected = compactString(_expected);
	string actual= compactString(_actual);

	return formatMessage(message, expected, actual);
}

//-----------------------------------------------------------------------------

string MQLUNIT_ComparisonCompactor::formatMessage(
    const string message, const string expected, const string actual
) const {
    return StringConcatenate(
        MQLUNIT_Assert::getMessage(message), "expected:<", expected,
        "> but was:<", actual, ">"
    );
}

//-----------------------------------------------------------------------------

string MQLUNIT_ComparisonCompactor::wrapNull(const string value) const {
    if (value == NULL) return "null";
    return value;
};

//-----------------------------------------------------------------------------

void MQLUNIT_ComparisonCompactor::findCommonPrefix() {
    _prefix= 0;
	const int end = MathMin(StringLen(_expected), StringLen(_actual));
	for (; _prefix < end; _prefix++) {
        if (StringGetCharacter(_expected, _prefix)
            != StringGetCharacter(_actual, _prefix)
        ) { break; }
	}
}

//-----------------------------------------------------------------------------

void MQLUNIT_ComparisonCompactor::findCommonSuffix() {
    int expectedSuffix = StringLen(_expected) - 1;
	int actualSuffix = StringLen(_actual) - 1;
	for (;
        actualSuffix >= _prefix && expectedSuffix >= _prefix;
        actualSuffix--, expectedSuffix--
    ) {
		if (StringGetCharacter(_expected, expectedSuffix)
            != StringGetCharacter(_actual, actualSuffix)
        ) { break; }
	}
	_suffix = StringLen(_expected) - expectedSuffix;
}

//-----------------------------------------------------------------------------

string MQLUNIT_ComparisonCompactor::compactString(string source) const {
    string result = StringConcatenate(
        MQLUNIT_DELTA_START,
        getSubString(source, _prefix, StringLen(source) - _suffix),
        MQLUNIT_DELTA_END
    );
    if (_prefix > 0) {
        result = StringConcatenate(computeCommonPrefix(), result);
    }
    if (_suffix > 0) {
        result = StringConcatenate(result, computeCommonSuffix());
    }
    return result;
}

//-----------------------------------------------------------------------------

string MQLUNIT_ComparisonCompactor::computeCommonPrefix() const {
    const int start = MathMax(0, _prefix - _contextLength);
    return StringConcatenate(
        (_prefix > _contextLength ? MQLUNIT_ELLIPSIS : ""),
        getSubString(_expected, MathMax(
            0, _prefix - _contextLength
        ), _prefix - 1)
    );
}

//-----------------------------------------------------------------------------

string MQLUNIT_ComparisonCompactor::computeCommonSuffix() const {
	const int end = MathMin(
        StringLen(_expected) - _suffix + 1 + _contextLength,
        StringLen(_expected)
    );
    return StringConcatenate(
        getSubString(_expected, StringLen(_expected) - _suffix + 1, end - 1),
        (StringLen(_expected) - _suffix + 1
            < StringLen(_expected) - _contextLength ? MQLUNIT_ELLIPSIS : "")
    );
}

//-----------------------------------------------------------------------------

string getSubString(const string value, const int start, const int end) {
    const int length = end - start + 1;
    if (length <= 0) { return ""; }
    return StringSubstr(value, start, length);
}

//-----------------------------------------------------------------------------

#endif
