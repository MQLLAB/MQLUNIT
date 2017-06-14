/// @file   WinMM.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  Win32 API : winmm.dll

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

#ifndef MQLLIB_WIN32_WINMM_MQH
#define MQLLIB_WIN32_WINMM_MQH

//-----------------------------------------------------------------------------

#define SND_SYNC        0x00
#define SND_ASYNC       0x01
#define SND_NODEFAULT   0x02
#define SND_MEMORY      0x04
#define SND_LOOP        0x08
#define SND_NOSTOP      0x10
#define SND_NOWAIT	    0x00002000
#define SND_ALIAS       0x00010000
#define SND_ALIAS_ID    0x000110000
#define SND_FILENAME    0x00020000
#define SND_RESOURCE    0x00040004
#define SND_PURGE       0x40
#define SND_APPLICATION 0x80
#define SND_ALIAS_START 0x00
#define	sndAlias(c0,c1)	                                                     \
    (SND_ALIAS_START+((int)(ushort)(c0)|((int)(ushort)(c1)<<8)))
#define SND_ALIAS_SYSTEMASTERISK    sndAlias('S','*')
#define SND_ALIAS_SYSTEMQUESTION    sndAlias('S','?')
#define SND_ALIAS_SYSTEMHAND        sndAlias('S','H')
#define SND_ALIAS_SYSTEMEXIT        sndAlias('S','E')
#define SND_ALIAS_SYSTEMSTART       sndAlias('S','S')
#define SND_ALIAS_SYSTEMWELCOME     sndAlias('S','W')
#define SND_ALIAS_SYSTEMEXCLAMATION sndAlias('S','!')
#define SND_ALIAS_SYSTEMDEFAULT     sndAlias('S','D')

//-----------------------------------------------------------------------------

#import "winmm.dll"
/// @see https://msdn.microsoft.com/en-us/library/windows/desktop/dd743680.aspx
bool PlaySoundW(string lpSound, int hMod, int fSound);
#import

//-----------------------------------------------------------------------------

#endif
