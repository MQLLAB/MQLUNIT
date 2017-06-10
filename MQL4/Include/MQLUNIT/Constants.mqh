/// @file   Constants.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  Definition of MQLUNIT constants.

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

#ifndef MQLUNIT_CONSTANTS_MQH
#define MQLUNIT_CONSTANTS_MQH

//-----------------------------------------------------------------------------

/// @brief The number of characters to wrap the test progress output at.
/// Only applicable to text based output (console, terminal, text file).
#define MQLUNIT_OUTPUT_WRAP 42

/// @brief The maximum context length at which strings that aren't equal are
/// going to be compacted in the assertion failure message.
#define MQLUNIT_MAX_CONTEXT_LENGTH 20

/// @brief Used to replace a common prefix in the output of the difference
/// between two strings.
#define MQLUNIT_ELLIPSIS "..."

/// @brief Used to wrap the output of the difference between two strings.
#define MQLUNIT_DELTA_END "]"

/// @brief Used to wrap the output of the difference between two strings.
#define MQLUNIT_DELTA_START "["

//-----------------------------------------------------------------------------

#endif
