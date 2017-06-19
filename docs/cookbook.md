# MQLUNIT Cookbook

Here is a short cookbook to help you get started.

## Simple Test Case

You want to know whether your code is working.

How do you do it?

There are many ways. Stepping through a debugger or littering your code with
Print output calls are two of the simpler ways, but they both have drawbacks.
Stepping through your code is a good idea, but it is not automatic. You have
to do it every time you make changes. Printing out text is also fine, but it
makes code ugly and it generates far more information than you need most of
the time.

Tests in MQLUNIT can be run automatically. They are easy to set up and once
you have written them, they are always there to help you keep confidence in
the quality of your code.

This is especially important while working with MQL4 language as MetaTrader 4
get constant updates that tend to break woking code. Having a unit test suite
helps to quickly verify the functionality of your code.

To make a simple test, here is what you do:

Subclass the MQLUNIT_TestCase class. Make sure to add two constructors as in
the example below.

Use @ref MQLUNIT_START to denote the beginning of the tests block.

Use @ref TEST_START and @ref TEST_END macros to add a single test method.

Close the tests block with @ref MQLUNIT_END macro. 

When you want to check a value, call @ref ASSERT_TRUE(string, bool) and
pass in an expression that is true if the test succeeds along with a string
message to be displayed if the test fails (you can pass an empty string `""`
if you wish to use a default message).

For example, to test the equality comparison for a Complex number class, write:

```.cpp
class ComplexNumberTest : public MQLUNIT_TestCase { 
public:
    ComplexNumberTest() : MQLUNIT_TestCase(typename(this))  {};
    ComplexNumberTest(string name) : MQLUNIT_TestCase(name) {};

    MQLUNIT_START

    TEST_START(ComplexNumber) {
        Complex(10, 1) c1;
        Complex(10, 1) c2;
        
        ASSERT_TRUE("", c1 == c2);

        Complex (1, 1) c3;
        Complex (2, 2) c4;

        ASSERT_TRUE("", !(c3 == c4));
    }
    TEST_END

    MQLUNIT_END
};
```

You only need to include a single file in your code to import all MQLUNIT
functionality:

```.cpp
#include <MQLUNIT/MQLUNIT.mqh>
```

Ordinarily, you'll have many little test cases that you'll want to run on the
same set of objects. To do this, we will improve on this example. 

## Fixture

A fixture is a known set of objects that serves as a base for a set of test
cases. Fixtures come in very handy when you are testing as you develop.

Let's try out this style of development and learn about fixtures along the
away. Suppose that we are really developing a complex number class. Let's start
by defining a empty class named Complex.

```.cpp
class Complex {};
```

Now create an instance of ComplexNumberTest above, compile the code and see
what happens. The first thing we notice is a few compiler errors. The test uses
operator ==, but it is not defined. Let's fix that.

```.cpp
bool operator==(const Complex &that) { 
  return true; 
}
```

Now compile the test, and run it. This time it compiles but the test fails.
We need a bit more to get an operator ==working correctly, so we revisit the
code.

```.cpp
class Complex { 
private
    double real, imaginary;
public:
    Complex(double r, double i = 0) : real(r) , imaginary(i) {}; 
    bool operator ==(const Complex &that) {}
        return this.real == that.real  &&  this.imaginary == that.imaginary; 
    }
};
```

If we compile now and run our test it will pass.

Now we are ready to add new operations and new tests. At this point a fixture
would be handy. We would probably be better off when doing our tests if we
decided to instantiate three or four complex numbers and reuse them across our
tests.

Here is how we do it:

* Add member variables for each part of the fixture
* Override MQLUNIT_TestCase::setUp() to initialize the variables
* Override MQLUNIT_TestCase::tearDown() to release any permanent resources you
  allocated in MQLUNIT_TestCase::setUp() 

```.cpp
class ComplexNumberTest : public MQLUNIT_TestCase { 
private:
    Complex* m_10_1;
    Complex* m_1_1;
    Complex* m_11_2;

public:
    ComplexNumberTest() : MQLUNIT_TestCase(typename(this))  {};
    ComplexNumberTest(string name) : MQLUNIT_TestCase(name) {};
    
    void setUp() {
        m_10_1 = new Complex(10, 1);
        m_1_1 = new Complex(1, 1);
        m_11_2 = new Complex(11, 2);  
    }
  
    void tearDown() {
        delete m_10_1;
        delete m_1_1;
        delete m_11_2;
    }
};
```

Once we have this fixture, we can add the complex addition test case and any
others that we need over the course of our development.

## Test Case

How do you write and invoke individual tests using a fixture?

Write the test case using @ref TEST_START and @ref TEST_END macros in the
fixture class between @ref MQLUNIT_START and @ref MQLUNIT_END macros.

Here is our test case class with a few extra case methods:

```.cpp
class ComplexNumberTest : public MQLUNIT_TestCase { 
private:
    Complex* m_10_1;
    Complex* m_1_1;
    Complex* m_11_2;

public:
    ComplexNumberTest() : MQLUNIT_TestCase(typename(this))  {};
    ComplexNumberTest(string name) : MQLUNIT_TestCase(name) {};
    
    void setUp() {
        m_10_1 = new Complex(10, 1);
        m_1_1 = new Complex(1, 1);
        m_11_2 = new Complex(11, 2);  
    }
  
    void tearDown() {
        delete m_10_1;
        delete m_1_1;
        delete m_11_2;
    }

    MQLUNIT_START

    TEST_START(Equality) {
        ASSERT_TRUE("", *m_10_1 == *m_10_1);
        ASSERT_TRUE("", !(*m_10_1 == *m_11_2));
    }
    TEST_END

    TEST_START(Addition) {
        ASSERT_TRUE("", *m_10_1 + *m_1_1 == *m_11_2);
    }
    TEST_END

    MQLUNIT_END
};
```

One may create and run instances for each test case using MQL4 script:

```.cpp
#include <MQLUNIT/MQLUNIT.mqh>

void OnStart() {
    MQLUNIT_TerminalTestRunner runner;
    runner.run(new ComplexNumberTest());
}
```

Test runner takes ownership of the test, so there's no need to delete it.

This script will output test result to the `Experts` log window of the
MetaTrader 4 terminal.

Once you have several tests, organise them into a suite.

## Test Suite

How do you set up your tests so that you can run them all at once?

MQLUNIT provides a MQLUNIT_TestSuite class that runs any number of Test Cases
together.

We saw, above, how to run a single test case.

To create a suite of two or more tests, you do the following in your script:

```.cpp
#include <MQLUNIT/MQLUNIT.mqh>

void OnStart() {
    MQLUNIT_TestSuite suite;
    suite.addTest(new ComplexNumberTest());
    suite.addTest(new AnotherTest());
    suite.addTest(new YetAnotherTest());

    MQLUNIT_TerminalTestRunner runner;
    runner.run(&suite);
}
```

Test suite takes ownership of the added test cases, so there's no need to
delete them.

Run this script and see the output in the `Experts` log window of the
MetaTrader 4 terminal.

## TestRunner

The MQLUNIT_TestRunner implementations run the tests. If all the tests pass,
you'll get an informative message. If any fail, you'll get the following
information:

* The name of the test case that failed
* The name of the source file that contains the test
* The line number where the failure occurred
* Failure message that you passed to the call to @ref ASSERT_TRUE which
  detected the failure

MQLUNIT provides the following implementations of MQLUNIT_TestRunner:

* MQLUNIT_TerminalTestRunner: test runner that outputs results to the `Experts`
  log window of MetaTrader terminal.
* MQLUNIT_ConsoleTestRunner: test runner that outputs results to the text
  console.
* MQLUNIT_TextFileTestRunner: test runner that outputs results to the text
  file.
* MQLUNIT_XMLTestRunner: test runner that outputs results to the XML file
  compatible with JUnit report analysers.

## Post-build check

Well, now that we have our unit tests running, how about integrating unit
testing to our build process? Can we actually have one with MetaTarder 4?
Fully automated?

The anwer is yes! MQLUNIT itsef is continuously tested on AppVeyor cloud CI.

You can examine `.appveyor.yml` file in the source code tree and have a look
at the live build  results at https://ci.appveyor.com/project/mqllab/mqlunit.

In a nutshell,  `MQLUNITTest` script uses the output result of the call to
MQLUNIT_TestRunner::run method do determine if the test suite succeeded. If
yes, it creates an empty `SUCCESS` file in `MQL4/Files/MQLUNIT` directory.

Build script uses the presence of this file to determine whether the test
run was successful or not.

Test result in JUnit compatible XML formar are uploaded to AppVeyor and are
displayed on [the build page](https://ci.appveyor.com/project/mqllab/mqlunit).

---

Adapted from CppUnit Cookbook by Michael Feathers and Baptiste Lepilleur.

@author Egor Pervuninski (<https://egor.pe>)
@author Michael Feathers
@author Baptiste Lepilleur
