/// @file   Console.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  Text based console for MQL.

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

#ifndef MQLLIB_UTILS_CONSOLE_MQH
#define MQLLIB_UTILS_CONSOLE_MQH

#include "../Win32/Kernel32.mqh"

//-----------------------------------------------------------------------------

/// @brief Enable console input/output.
class MQLLIB_Utils_Console {
public:
    int _stdin;
    int _stdout;
private:
    MQLLIB_Utils_Console();
    bool _write(const string message);
    bool _writeLine(const string message);
    ushort _readChar();
    string _readLine(const string terminator = "\r\n");
public:
    /// @brief Writes a message to the standard output.
    /// @param message : s string to write
    /// @return false, if failed to write the whole string
    static bool write(const string message);
    
    /// @brief Writes an empty line to the standard output.
    /// @return false, if failed to write an empty line
    static bool writeLine();
  
    /// @brief Writes a message to the standard output.
    /// @param message : s string to write
    /// @return false, if failed to write the whole string
    static bool writeLine(const string message);
  
    /// @brief Reads a single character from the stardard input.
    /// This method will wait for input in no characters are available.
    /// @return a unicode character
    static ushort readChar();
  
    /// @brief Reads a line from standard input untils a termial is reached.
    /// This method will wait for input in no characters are available.
    /// @param terminator : the terminator character seqence
    /// @return a string read from the standard input
    static string readLine(const string terminator = "\r\n");
  
    /// @brief Closes the console.
    static void close();
};

//-----------------------------------------------------------------------------

MQLLIB_Utils_Console::MQLLIB_Utils_Console() {
    if (!AllocConsole()) { AttachConsole(ATTACH_PARENT_PROCESS); }
    _stdin  = GetStdHandle(STD_INPUT_HANDLE);
    _stdout = GetStdHandle(STD_OUTPUT_HANDLE);
}

//-----------------------------------------------------------------------------

static void MQLLIB_Utils_Console::close() {
    FreeConsole();
}

//-----------------------------------------------------------------------------

static bool MQLLIB_Utils_Console::write(const string message) {
    MQLLIB_Utils_Console console;
    return console._write(message);
}

//-----------------------------------------------------------------------------

static bool MQLLIB_Utils_Console::writeLine(const string message) {
    MQLLIB_Utils_Console console;
    return console._writeLine(message);
}

//-----------------------------------------------------------------------------

static bool MQLLIB_Utils_Console::writeLine() {
    MQLLIB_Utils_Console console;
    return console._writeLine("");
}

//-----------------------------------------------------------------------------

static ushort MQLLIB_Utils_Console::readChar() {
    MQLLIB_Utils_Console console;
    return console._readChar();
}

//-----------------------------------------------------------------------------

static string MQLLIB_Utils_Console::readLine(const string terminator = "\r\n") {
    MQLLIB_Utils_Console console;
    return console._readLine(terminator);
}

//-----------------------------------------------------------------------------

bool MQLLIB_Utils_Console::_write(const string message) {
    const int m = StringLen(message);
    uint n = 0;
    WriteConsoleW(_stdout, message, m, n, NULL);
    return m == n;
}

//-----------------------------------------------------------------------------

bool MQLLIB_Utils_Console::_writeLine(const string message) {  
    return write(StringConcatenate(message, "\r\n"));
}

//-----------------------------------------------------------------------------

ushort MQLLIB_Utils_Console::_readChar() {
    string b = " ";
    uint n;
    ReadConsoleW(_stdin, b, 1, n, NULL);
    return StringGetChar(b, 0);
}

//-----------------------------------------------------------------------------

string MQLLIB_Utils_Console::_readLine(const string terminator) {
    string line = "";
  
    while (true) {
        uint n;
        string b;
        StringInit(b, 256, 0);
    
        ReadConsoleW(_stdin, b, 256, n, NULL);
    
        line = StringConcatenate(line, b);

        int term_pos = StringFind(line, terminator);
        if (term_pos == -1) { continue; }
    
        line = StringSubstr(line, 0, term_pos);
    
        break;
    }
    
    return line;
}

//-----------------------------------------------------------------------------

#endif