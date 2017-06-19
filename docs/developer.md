# MQLUNIT Developer Documentation

## Assertion Framework

Although MQL4 is pretty close syntactically to C++, it lacks a lot of C++
features suck as multiple inheritance, runtime type information (RTTI) and
exceptions.

Traditionally, in JUnit and CppUnit assertion failures are thrown as exceptions.
Unfortunately this can't be done in MQL4. Although
[MQLLIB](https://mqllib.github.io/MQLLAB/MQLLIB) includes some rudementary
exception emulation layer, it is unsuitable for our purposes here.

The following convention, therefore, has been established. Assertion methods
of MQLUNIT_Assert class return string value. The value is set to `NULL` if 
the assertion was successful, otherwise the method returns a `message`
parameter passed to the function (which is a user defined failure description).

Please take time to examine MQLUNIT_Assert class and corresponding
`MQLUNIT_AssertTest` test case to understand an assertion framework of MQLUNIT.

## Test Execution Model

All test cases and test suites are derived from MQLUNIT_Test class. Each 
test is executed by calling MQLUNIT_Test#run method. End users of MQLUNIT
never implement MQLUNIT_Test#run directly. Instead they use a set of macros
that builds this method.

@ref MQLUNIT_START starts the implementation of MQLUNIT_Test#run method.

Each pair of @ref TEST_START and @ref TEST_END macros adds a code for a
particular test method inline right into MQLUNIT_Test#run implementation body.

`ASSERT` macros run assertions and add any encountered failures as
MQLUNIT_TestFailure to the list of test failures.

@ref MQLUNIT_END macro finishes the MQLUNIT_Test#run implementation.

## Set Up and Tear Down

As in JUnit and CppUnit, MQLUNIT_TestCase defines MQLUNIT_TestCase#setUp and
MQLUNIT_TestCase#tearDown methods. MQLUNIT_TestCase#setUp is executed before
each test method and MQLUNIT_TestCase#tearDown is executed after each test
method.

@ref TEST_START and @ref TEST_END macros are responsible for this
functionality.

## Event System

MQLUNIT includes MQLUNIT_TestListener interface that defines events that get
emitted during the test execution. Separate events are emitted when test
case execution starts, before and after each test method and at the end of the
test case.

These events are fired by @ref MQLUNIT_START, @ref TEST_START, @ref TEST_END,
and @ref MQLUNIT_END macros and are embedded into the generated
MQLUNIT_Test#run implementation.

In the case of assertion failure, the appropriate `ASSERT` macro fires the
event.

MQLUNIT_TestResult collector class contains the list of registered
MQLUNIT_TestListener and calls event handling methods on each one of them.

## Test Hierarchy

It is possible to build a test hierarchy off MQLUNIT_Test. The child test's
implementation of MQLUNIT_Test#run is responsible for calling MQLUNIT_Test#run
implementation on its parent. Helper macro @ref MQLUNIT_INHERIT has been added
for this purpose. It makes sure the parent's MQLUNIT_Test#run implementation
is called and passes an `inherited` parameter set to `true`. The purpose of
this parameter is to prevent parent test from firing events on a test case
start and a test case end (the child test fires them and, essentially, wraps
a parent test).
