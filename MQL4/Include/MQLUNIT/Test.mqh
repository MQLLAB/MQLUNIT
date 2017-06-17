/// @file   Test.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLUNIT Test class definition.

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

#ifndef MQLUNIT_TEST_MQH
#define MQLUNIT_TEST_MQH

class MQLUNIT_TestResult;

//-----------------------------------------------------------------------------

/// @brief Base class for all tests.
///
/// An MQLUNIT_Test can be run and collect its results.
/// @see MQLUNIT_TestResult
class MQLUNIT_Test {
private:
    const string _name;

public:
    /// @brief Constructor : creates a test using a class name as a test name.
    MQLUNIT_Test() : _name(typename(this)) {};

    /// @brief Constructor : creates a test with a provided test name.
    /// @param name : test name
    MQLUNIT_Test(const string name) : _name(name) {};

    /// @brief Destructor
    virtual ~MQLUNIT_Test() {};

    /// @brief Returns a name of a test.
    /// @return the name of the test
    string getName() { return _name; };

    /// @brief Runs the test.
    /// @param result : collects the results of executing a test
    /// @param inherited : set to true to tell the test it has been inherited
    /// from and is run by a child test
    /// @see MQLUNIT_TestResult
    virtual void run(MQLUNIT_TestResult* result, bool inherited = false) = 0;

private:
    // copying of the interface is forbidden
    MQLUNIT_Test(const MQLUNIT_Test& that) {};
    void operator =(const MQLUNIT_Test& that) {};
};

//-----------------------------------------------------------------------------

#endif
