/// @file   Kernel32.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  Win32 API : kernel32.dll

//-----------------------------------------------------------------------------
// Copyright 2017 Eneset Group Trust
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

#ifndef MQLLIB_WIN32_KERNEL32_MQH
#define MQLLIB_WIN32_KERNEL32_MQH

//-----------------------------------------------------------------------------

#define STD_INPUT_HANDLE        -10
#define STD_OUTPUT_HANDLE       -11
#define ATTACH_PARENT_PROCESS   -1

//-----------------------------------------------------------------------------

#import "kernel32.dll"
bool AllocConsole();
bool FreeConsole();
bool AttachConsole(uint dwProcessId);
int  GetStdHandle(int nStdHandle);
bool WriteConsoleW(
    int hConsoleOutput, string lpBuffer, uint nNumberOfCharsToWrite,
    uint& lpNumberOfCharsWritten, int lpReserved
);
bool ReadConsoleW(
    int hConsoleInput, string& lpBuffer, uint nNumberOfCharsToRead,
    uint& lpNumberOfCharsRead, int pInputControl
);
void OutputDebugStringW(string msg);
#import

//-----------------------------------------------------------------------------

#endif