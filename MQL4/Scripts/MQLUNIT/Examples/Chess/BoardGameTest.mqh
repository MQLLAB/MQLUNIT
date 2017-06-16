/// @file   BoardGameTest.mq4
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLUNIT examples : BoardGameTest class definition.

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

#ifndef SCRIPTS_MQLUNIT_EXAMPLES_CHESS_BOARDGAMETEST_MQH
#define SCRIPTS_MQLUNIT_EXAMPLES_CHESS_BOARDGAMETEST_MQH

#include <MQLUNIT/MQLUNIT.mqh>
#include <MQLLIB/Lang/Pointer.mqh>

//-----------------------------------------------------------------------------

template <typename T>
class MQLUNIT_Examples_Chess_BoardGameTest  : public MQLUNIT_TestCase {
protected:
    T* _game;
public:
    MQLUNIT_Examples_Chess_BoardGameTest()
        : MQLUNIT_TestCase(typename(this))  {};
    MQLUNIT_Examples_Chess_BoardGameTest(string name)
        : MQLUNIT_TestCase(name) {};

    void setUp() {
        _game = new T;
    }

    void tearDown() {
        MQLLIB_Lang_SafeDelete(_game);
    }

    MQLUNIT_START

    //----------------------------------------

    TEST_START(Reset) {
        ASSERT_TRUE(NULL, _game.reset());
    }
    TEST_END

    //----------------------------------------

    TEST_START(ResetShouldFail) {
        ASSERT_TRUE(
            "This test fails, this is intended", !_game.reset()
        );
    }
    TEST_END

    //----------------------------------------

    MQLUNIT_END
};

//-----------------------------------------------------------------------------

#endif
