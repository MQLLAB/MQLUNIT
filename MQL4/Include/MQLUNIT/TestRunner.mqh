/// @file   TestRunner.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLUNIT TestRunner class definition.

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

#ifndef MQLUNIT_TESTRUNNER_MQH
#define MQLUNIT_TESTRUNNER_MQH

#include "Test.mqh"
#include "TestListener.mqh"

//-----------------------------------------------------------------------------

/// @class Base class for all test runners.
/// @see MQLUNIT_TestListener
class MQLUNIT_TestRunner : public MQLUNIT_TestListener {
public:
    /// @brief Destructor
    virtual ~MQLUNIT_TestRunner() {};
    
    /// @brief Run a test and output the result.
    /// @param test : a test to run
    /// @see MQLUNIT_Test
    virtual void run(MQLUNIT_Test* test) = 0;
    
protected:
    string failureCountFormat(uint count) const;
};

//-----------------------------------------------------------------------------

string MQLUNIT_TestRunner::failureCountFormat(uint count) const {
    if (count == 1) {
        return "There was %i failure:";
    }
    return "There were %i failures:";
}

//-----------------------------------------------------------------------------

#endif
