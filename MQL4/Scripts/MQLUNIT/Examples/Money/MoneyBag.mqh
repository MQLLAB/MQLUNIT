/// @file   MoneyBag.mq4
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLUNIT examples : MoneyBag class definition.

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

#ifndef SCRIPTS_MQLUNIT_EXAMPLES_MONEY_MONEY_MQH
#define SCRIPTS_MQLUNIT_EXAMPLES_MONEY_MONEY_MQH

#include <MQLUNIT/MQLUNIT.mqh>

#include "IMoney.mqh"
#include "Money.mqh"

/// @brief A MoneyBag defers exchange rate conversions.
///
/// For example adding 12 Swiss Francs to 14 US Dollars is represented as a
/// bag containing the two Monies 12 CHF and 14 USD. Adding another 10 Swiss
/// francs gives a bag with 22 CHF and 14 USD. Due to the deferred exchange
/// rate conversion we can later value a MoneyBag with different exchange
/// rates.
///
/// A MoneyBag is represented as a list of Monies and provides different
/// constructors to create a MoneyBag.
class MQLUNIT_Examples_Money_MoneyBag : public MQLUNIT_Examples_Money_IMoney  {
public:
    MQLUNIT_Examples_Money_MoneyBag() {};
    MQLUNIT_Examples_Money_MoneyBag(const MQLUNIT_Examples_Money_Money& that);
    virtual ~MQLUNIT_Examples_Money_MoneyBag() {};

    void operator =(const MQLUNIT_Examples_Money_MoneyBag& that);
    bool operator ==(const MQLUNIT_Examples_Money_MoneyBag& that);
};

//-----------------------------------------------------------------------------

#endif
