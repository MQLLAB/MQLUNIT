/// @file   User32.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  Win32 API : user32.dll

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

#ifndef MQLLIB_WIN32_USER32_MQH
#define MQLLIB_WIN32_USER32_MQH

//-----------------------------------------------------------------------------

#define IDOK        1
#define IDCANCEL    2
#define IDABORT     3
#define IDRETRY     4
#define IDIGNORE    5
#define IDYES       6
#define IDNO        7
#define IDTRYAGAIN  10
#define IDCONTINUE  11

#define MB_ABORTRETRYIGNORE     0x00000002
#define MB_CANCELTRYCONTINUE    0x00000006
#define MB_HELP                 0x00004000
#define MB_OK                   0x00000000
#define MB_OKCANCEL             0x00000001
#define MB_RETRYCANCEL          0x00000005
#define MB_YESNO                0x00000004
#define MB_YESNOCANCEL          0x00000003

#define MB_ICONEXCLAMATION  0x00000030
#define MB_ICONWARNING      0x00000030
#define MB_ICONINFORMATION  0x00000040
#define MB_ICONASTERISK     0x00000040
#define MB_ICONQUESTION     0x00000020
#define B_ICONSTOP          0x00000010
#define MB_ICONERROR        0x00000010
#define MB_ICONHAND         0x00000010

#define MB_DEFBUTTON1   0x00000000
#define MB_DEFBUTTON2   0x00000100
#define MB_DEFBUTTON3   0x00000200
#define MB_DEFBUTTON4   0x00000300

#define MB_APPLMODAL    0x00000000
#define MB_SYSTEMMODAL  0x00001000
#define MB_TASKMODAL    0x00002000

#define MB_DEFAULT_DESKTOP_ONLY 0x00020000
#define MB_RIGHT                0x00080000
#define MB_RTLREADING           0x00100000
#define MB_SETFOREGROUND        0x00010000
#define MB_TOPMOST              0x00040000
#define MB_SERVICE_NOTIFICATION 0x00200000

//-----------------------------------------------------------------------------

#import "user32.dll"
/// @see https://msdn.microsoft.com/en-us/library/windows/desktop/ms645505.aspx
int  MessageBoxW(int hWnd, string lpText, string lpCaption, int style);
#import

//-----------------------------------------------------------------------------

#endif
