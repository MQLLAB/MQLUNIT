# MQLUNIT FAQ

**I see a lot of compilation errors.**

You are likely to forgot to add @ref TEST_END macro at the end of the test
case.

Test case definition should look like this.

```.cpp
TEST_START(Name) {
    // test body goes here
}
TEST_END
```
**I implemented operator== but ASSERT_EQUALS always fails anyway.**

Remember to dereference object pointers. When using pointers in
@ref ASSERT_EQUALS directly you are comparing pointers themselves, not
referenced objects.

Here is the correct way of checking dynamic objects for equality.

```.cpp
// MyIntObject implements operator==
MyIntObject* obj1 = new MyIntObject(1);
MyIntObject* obj2 = new MyIntObject(1);

// WRONG! ASSERT_EQUALS("Objects must be equal", obj1, obj2);
ASSERT_EQUALS("Objects must be equal", *obj1, *obj2);

delete obj2;
delete obj1;
```
**My test passes when it clearly should fail.**

Do not ever set a failure message to `NULL` when calling `ASSERT` macros.
Unlike other testing frameworks, MQLUNIT uses a message text to signal an
assertion failure. `NULL` means there were no failures, so by using a `NULL` as
a failure message you are causing the test to alway succeed. Use an empty
string if don't want to use any specific failure description.

```.cpp
int var1 = 1;
int var2 = 2;

// WRONG! ASSERT_TRUE(NULL, var1 == var2);
ASSERT_TRUE("", var1 == var2);
``` 
