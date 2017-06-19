/// @file   MoneyTest.mq4
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLUNIT examples : MoneyTest class definition.

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

#ifndef SCRIPTS_MQLUNIT_EXAMPLES_MONEY_MONEYTEST_MQH
#define SCRIPTS_MQLUNIT_EXAMPLES_MONEY_MONEYTEST_MQH

#include <MQLUNIT/MQLUNIT.mqh>
#include <MQLLIB/Lang/Exception.mqh>

#include "Money.mqh"

//-----------------------------------------------------------------------------

/// @brief Example of testing a complex object behaviour with MQLUNIT.
class MQLUNIT_Examples_Money_MoneyTest : public MQLUNIT_TestCase {
public:
    MQLUNIT_Examples_Money_MoneyTest() : MQLUNIT_TestCase(typename(this))  {};
    MQLUNIT_Examples_Money_MoneyTest(string name) : MQLUNIT_TestCase(name) {};

    MQLUNIT_START

        //----------------------------------------

    TEST_START(Constructor) {
        const string currencyFF =  "FF";
        const double longNumber = 1234.5678;

        MQLUNIT_Examples_Money_Money money(longNumber, currencyFF);

        ASSERT_EQUALS("", longNumber, money.getAmount());
        ASSERT_EQUALS("", currencyFF, money.getCurrency());
    }
    TEST_END

    //----------------------------------------

    TEST_START(Add) {
        MQLUNIT_Examples_Money_Money money12FF(12, "FF");
        MQLUNIT_Examples_Money_Money expectedMoney(135, "FF");

        MQLUNIT_Examples_Money_Money money(123, "FF");
        money += money12FF;

        ASSERT_EQUALS("Add should work", expectedMoney, money);
    }
    TEST_END

    //----------------------------------------

    TEST_START(Equal) {
        MQLUNIT_Examples_Money_Money money123FF(123, "FF");
        MQLUNIT_Examples_Money_Money money123USD(123, "USD");
        MQLUNIT_Examples_Money_Money money12FF(12, "FF");
        MQLUNIT_Examples_Money_Money money12USD(12, "USD");

        ASSERT_TRUE("==", money123FF == money123FF);
        ASSERT_TRUE("!= amount", money12FF != money123FF);
        ASSERT_TRUE("!= currency", money123USD != money123FF);
        ASSERT_TRUE("!= currency and != amount", money12USD != money123FF);
    }
    TEST_END

    //----------------------------------------

    TEST_START(Throw) {
        MQLUNIT_Examples_Money_Money money123FF(123, "FF");
        MQLUNIT_Examples_Money_Money money( 123, "USD" );

        bool exceptionThrown = false;

        MQLLIB_TRY {
            money += money123FF;
        } MQLLIB_CATCH(MQLUNIT_INCOMPATIBLE_MONIES) {
            exceptionThrown = true;
        }

        ASSERT_TRUE("Must not change money", money.getAmount() == 123);
        ASSERT_TRUE("Must throw an exception", exceptionThrown);
    }
    TEST_END

    //----------------------------------------

    MQLUNIT_END
};

//-----------------------------------------------------------------------------

#endif
