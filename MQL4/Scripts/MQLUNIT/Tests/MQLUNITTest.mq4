/// @file   MQLUNITTest.mq4
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLUNIT test suite executor script.

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

#property copyright "Copyright 2017, Eneset Group Trust"
#property link      "https://www.github.com/MQLLIB/MQLUNIT"
#property version   "1.0"
#property strict

#include <MQLUNIT/MQLUNIT.mqh>

#include "AssertTest.mqh"

//-----------------------------------------------------------------------------

/// @brief MQLUNIT test suite executor entry point.
/// Runs a complete MQLUNIT test suite using MQLUNIT (self-test).
void OnStart() {
    MQLUNIT_TestSuite suite;
    suite.addTest(new MQLUNIT_AssertTest());

    MQLUNIT_ConsoleTestRunner runner;
    runner.run(&suite);
}

//-----------------------------------------------------------------------------