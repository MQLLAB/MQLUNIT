/// @file   Exception.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  Exception emulation.

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

#ifndef MQLLIB_LANG_EXCEPTION_MQH
#define MQLLIB_LANG_EXCEPTION_MQH

//-----------------------------------------------------------------------------

#define MQLLIB_RUNTIME_EXCEPTION            1
#define MQLLIB_INVALID_ARGUMENT_EXCEPTION   2

//-----------------------------------------------------------------------------

/// @brief Exception handling emulation.
///
/// To throw an "exception":
///
/// 1. #define some "exceptions" as numbers
/// 2. call MQLLIB_THROW() and pass an "exception" number
/// 3. abort the rest of your function execution
///
/// To catch an "exception" use the following code:
///
/// @code
/// #define MY_EXCEPTION 1
///
/// MQLLIB_TRY {
///     thisWillThrowAnException();
/// MQLLIB_CATCH(MY_EXCEPTION) {
///     Print("Exception handled");
/// }
///
/// void thisWillThrowAnException() {
///    ...
///     if (badStuffHappened) {
///         MQLLIB_THROW(MY_EXCEPTION);
///     }
///     ...
/// }
/// @endcode

#define MQLLIB_TRY
#define MQLLIB_CATCH(e) if (_LastError - ERR_USER_ERROR_FIRST == e)
#define MQLLIB_THROW(e) SetUserError(e)

//-----------------------------------------------------------------------------

#endif
