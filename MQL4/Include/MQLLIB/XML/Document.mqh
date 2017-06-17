/// @file   Document.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLLIB XML Document class definition.

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

#ifndef MQLLIB_XML_DOCUMENT_MQH
#define MQLLIB_XML_DOCUMENT_MQH

#include <MQLLIB/Lang/Pointer.mqh>
#include "Element.mqh"

//-----------------------------------------------------------------------------

/// @brief An XML Document.
///
/// A Document represents a XML file. It holds a pointer on the root Element
/// of the document. It also holds the encoding and style sheet used.
///
/// By default, the XML document is stand-alone and tagged with enconding
/// "ISO-8859-1".
class MQLLIB_XML_Document {
protected:
    MQLLIB_XML_Element* _rootElement;
    string _encoding;
    string _styleSheet;
    bool   _standalone;

public:

    /// @brief Constructs a XmlDocument object.
    /// @param encoding : encoding used in the XML file (default is Latin-1,
    /// ISO-8859-1).
    /// @param styleSheet : name of the XSL style sheet file used. If empty
    /// then no style sheet will be specified in the output.
    MQLLIB_XML_Document(
        const string encoding = "", const string styleSheet = ""
    ) : _styleSheet(styleSheet), _rootElement(
        new MQLLIB_XML_Element("DummyRoot")
    ) {
        setEncoding(encoding);
    };

    /// @brief Destructor.
    virtual ~MQLLIB_XML_Document() { MQLLIB_Lang_SafeDelete(_rootElement); };

    string encoding() const { return _encoding; };
    void setEncoding(const string encoding = "") {
        _encoding = encoding == "" ? "ISO-8859-1" : encoding;
    };

    string styleSheet() const { return _styleSheet; };
    void setStyleSheet(const string styleSheet = "") {
        _styleSheet = styleSheet;
    };

    bool standalone() const { return _standalone; };

    /// @brief set the output document as standalone or not.
    ///
    /// For the output document, specify wether it's a standalone XML document,
    /// or not.
    /// @param standalone : if true, the output will be specified as
    /// standalone; if false, it will be not.
    void setStandalone(bool standalone) { _standalone = standalone; };

    void setRootElement(MQLLIB_XML_Element *rootElement) {
        if (rootElement == _rootElement) { return; }
        MQLLIB_Lang_SafeDelete(_rootElement);
        _rootElement = rootElement;
    };

    MQLLIB_XML_Element* rootElement() const { return _rootElement; };

    string toString() const;

private:
    MQLLIB_XML_Document(const MQLLIB_XML_Document& that);
    void operator =(const MQLLIB_XML_Document& that);
};

//-----------------------------------------------------------------------------

string MQLLIB_XML_Document::toString() const {
    string asString = StringConcatenate(
        "<?xml version=\"1.0\" encoding=\"", _encoding,   "\""
    );

    if (_standalone) {
        asString = StringConcatenate(asString, " standalone=\"yes\"");
    }

    asString = StringConcatenate(asString, " ?>\n");

    if (_styleSheet != "") {
        asString = StringConcatenate(
            asString, "<?xml-stylesheet type=\"text/xsl\" href=\"",
            _styleSheet, "\"?>\n"
        );
    }

    asString = StringConcatenate(asString, _rootElement.toString());

    return asString;
}

//-----------------------------------------------------------------------------

#endif
