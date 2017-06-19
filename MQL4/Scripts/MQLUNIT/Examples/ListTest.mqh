/// @file   ListTest.mq4
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLUNIT examples : ListTest class definition.

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

#ifndef SCRIPTS_MQLUNIT_EXAMPLES_LISTTEST_MQH
#define SCRIPTS_MQLUNIT_EXAMPLES_LISTTEST_MQH

#include <Object.mqh>
#include <Arrays/List.mqh>
#include <MQLLIB/Lang/Pointer.mqh>
#include <MQLUNIT/MQLUNIT.mqh>

//-----------------------------------------------------------------------------

/// @brief Example MQLUNI test case for the CList class.
class MQLUNIT_Examples_ListTest : public MQLUNIT_TestCase {
private:
	CList* _empty;
	CList* _full;

public:
    MQLUNIT_Examples_ListTest() : MQLUNIT_TestCase(typename(this))  {};
    MQLUNIT_Examples_ListTest(string name) : MQLUNIT_TestCase(name) {};

    void setUp() {
        _empty = new CList();
        _full  = new CList();
        _full.Add(new __Integer__(1));
        _full.Add(new __Integer__(2));
        _full.Add(new __Integer__(3));
    }

    void tearDown() {
        MQLLIB_Lang_SafeDelete(_empty);
        MQLLIB_Lang_SafeDelete(_full);
    }

    MQLUNIT_START

    //----------------------------------------

    TEST_START(Capacity) {
        const int size = _full.Total();
		for (int i = 0; i < 100; i++) {
			_full.Add(new __Integer__(i));
        }
        ASSERT_EQUALS("", (int) (100 + size), _full.Total());
    }
    TEST_END

    //----------------------------------------


    TEST_START(Contains) {
        __Integer__* i = new __Integer__(1);
        _full.Add(i);
        ASSERT_TRUE("Must contain i", _full.IndexOf(i) != -1);
    }
    TEST_END

    //----------------------------------------

    TEST_START(GetNodeAtIndex) {
        for (int i = 0; i < 3; i++) {
            ASSERT_EQUALS(
                "", i + 1, ((__Integer__*) _full.GetNodeAtIndex(i)).get()
            );
        }

        ASSERT_TRUE(
            "Check with invalid index", _full.GetNodeAtIndex(100) == NULL
        );
    }
    TEST_END

    //----------------------------------------

    TEST_START(RemoveAll) {
        _full.Clear();
        _empty.Clear();
        ASSERT_EQUALS("List must be empty", (int) 0, _full.Total());
        ASSERT_EQUALS("List must be empty", (int) 0, _empty.Total());
    }
    TEST_END

    //----------------------------------------

    TEST_START(RemoveElement) {
        _full.Delete(1);
        ASSERT_EQUALS("Size must reduce", (int) 2, _full.Total());
        ASSERT_EQUALS(
            NULL, (int) 1, ((__Integer__*) _full.GetNodeAtIndex(0)).get()
        );
        ASSERT_EQUALS(
            NULL, (int) 3, ((__Integer__*) _full.GetNodeAtIndex(1)).get()
        );
    }
    TEST_END

    //----------------------------------------

    MQLUNIT_END
};

//-----------------------------------------------------------------------------

class __Integer__ : public CObject {
private:
    int _i;

public:
    __Integer__(int i) : _i (i) {};
    int get() const { return _i; };
};

//-----------------------------------------------------------------------------

#endif
