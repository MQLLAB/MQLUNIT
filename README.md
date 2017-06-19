# MQLUNIT

[![Build status](https://ci.appveyor.com/api/projects/status/j4jalp8y6ct52s08?svg=true)](https://ci.appveyor.com/project/mqllab/mqlunit) [![Build Status](https://travis-ci.org/MQLLAB/MQLUNIT.svg?branch=master)](https://travis-ci.org/MQLLAB/MQLUNIT)

## Overview

MQLUNIT is an object-oriented unit testing framework for MetaTarder4 MQL4
inspired by JUnit3 and CppUnit.

## Requirements

MetaTrader 4 build 1090 or later version.

## Installation

Copy `MQL4/Include` directory content to your MetaTrader 4 `MQL4` directory.

This method is deprecated and will be replaced by
[MUKLA](https://mqllab.github.io/MUKLA), the package manager for MetaTrader 4
currently in the process of being open-sourced.

## Usage

Take a look into the
[MQLUNIT Cookbook](https://mqllab.github.io/MQLUNIT/md_docs_cookbook.html).
It gives a quick start into using this testing framework.
[FAQ](https://mqllab.github.io/MQLUNIT/md_docs_faq.html) has answers to
commonly asked questions.

We provided example tests that can be found in `MQL4\Scripts\MQLUNIT\Examples`
directory.

MQLUNIT uses itself to test its functionality (self-test). You can find and
examine the test suite in `MQL4\Scripts\MQLUNIT\Tests`.

If you are interested in how MQLUNIT works, have a look at
[MQLUNIT Developer Documentation](https://mqllab.github.io/MQLUNIT/md_docs_developer.html).

## Support

If you are experiencing a problem with MQLUNIT,
[open an issue on GitHub.com](https://github.com/MQLLAB/MQLUNIT/issues).
We don't have a forum, mailing list or IRC channel yet. If you think it would
be useful, [open an issue about that](https://github.com/MQLLAB/MQLUNIT/issues).

## License

This library is released under the
[MIT License](https://opensource.org/licenses/MIT).

@author Egor Pervuninski (<https://egor.pe>)

@see https://mqllab.github.io/MQLUNIT
