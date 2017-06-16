/// @file   Money.mq4
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLUNIT examples : Money class definition.

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
#include <MQLLIB/Lang/Exception.mqh>

#define MQLUNIT_INCOMPATIBLE_MONIES 1331

//-----------------------------------------------------------------------------

/// @brief A simple Money.
class MQLUNIT_Examples_Money_Money {
private:
    double _amount;
    string _currency;

public:
    MQLUNIT_Examples_Money_Money(const double amount, const string currency)
        : _amount(amount), _currency(currency) {};

    MQLUNIT_Examples_Money_Money(const MQLUNIT_Examples_Money_Money& that)
        : _amount(that._amount), _currency(that._currency) {};

    ~MQLUNIT_Examples_Money_Money() {};

    bool operator ==(const MQLUNIT_Examples_Money_Money& that) const {
        return _amount == that._amount && _currency == that._currency;
    };
    
    bool operator !=(const MQLUNIT_Examples_Money_Money& that) const {
        return !(this == that); // !(*this == other);
    };
    
    void operator +=(const MQLUNIT_Examples_Money_Money& that) {
        if (_currency != that._currency) {
            MQLLIB_THROW(MQLUNIT_INCOMPATIBLE_MONIES);
        } else {
            _amount += that._amount;
        }
    };

    double getAmount()   const { return _amount;   };
    
    string getCurrency() const { return _currency; };
};

//-----------------------------------------------------------------------------

#endif
