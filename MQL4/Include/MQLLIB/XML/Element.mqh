/// @file   Element.mqh
/// @author Copyright 2017, Eneset Group Trust
/// @brief  MQLLIB XML Element class definition.

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

#ifndef MQLLIB_XML_ELEMENT_MQH
#define MQLLIB_XML_ELEMENT_MQH

#include <MQLLIB/Collections/Pair.mqh>
#include <MQLLIB/Collections/Vector.mqh>
#include <MQLLIB/Collections/Iterator.mqh>
#include <MQLLIB/Lang/Pointer.mqh>
#include <MQLLIB/Lang/Exception.mqh>

//-----------------------------------------------------------------------------

/// @brief A XML Element.
///
/// An XML element has:
/// - a name, specified on construction,
/// - a content, specified on construction (may be empty),
/// - zero or more attributes, added with addAttribute(),
/// - zero or more child elements, added with addElement().
///
/// @note This implementation uses a vector to store it's children which is
/// not very effective implementation. Vector should be ideally replaced with
/// a deque in the future release.
class MQLLIB_XML_Element {
private:
    string _name;
    string _content;

    MQLLIB_Collections_Vector
        <MQLLIB_Collection_Pair<string, string>*>   _attributes;
    MQLLIB_Collections_Vector<MQLLIB_XML_Element*>  _elements;

public:
    /// @brief Constructs an element with the specified name and string
    /// content.
    /// @param elementName : name of the element. Must not be empty.
    /// @param content : content of the element.
    MQLLIB_XML_Element(string elementName, string content = "")
        : _name(elementName), _content(content) {};

    /// @brief Constructs an element with the specified name and numeric
    /// content.
    /// @param elementName : name of the element. Must not be empty.
    /// @param numericContent : nontent of the element.
    MQLLIB_XML_Element(
        string elementName, int numericContent
    ) : _name(elementName) {
        setContent(numericContent);
    };

    /// @brief Destructs the element and its child elements.
    virtual ~MQLLIB_XML_Element();

    /// @brief Returns the name of the element.
    /// @return Name of the element.
    string name() const { return _name; };

    /// @brief Returns the content of the element.
    /// @return Content of the element.
    string content() const { return _content; };

    /// @brief Sets the name of the element.
    /// @param name : new name for the element.
    void setName(const string name) { _name = name; };

    /// @brief Sets the content of the element.
    /// @param content : new content for the element.
    void setContent(const string content) { _content = content; };

    /// @overload void setContent(const string content)
    void setContent(int numericContent) {
        _content = IntegerToString(numericContent);
    };

    /// @brief Adds an attribute with the specified string value.
    /// @param attributeName : name of the attribute. Must not be an empty.
    /// @param value : value of the attribute.
    void addAttribute(string attributeName, string value);

    /// @brief Adds an attribute with the specified numeric value.
    /// @param attributeName : name of the attribute. Must not be empty.
    /// @param numericValue : numeric value of the attribute.
    void addAttribute(string attributeName, int numericValue);

    /// @brief Adds a child element to the element.
    /// @param element : child element to add. Must not be @c NULL.
    void addElement(MQLLIB_XML_Element* element) { _elements.add(element); };

    /// @brief Returns the number of child elements.
    /// @return Number of child elements (element added with addElement()).
    int elementCount() const { return _elements.size(); };

    /// @brief Returns the child element at the specified index.
    /// @param index : zero based index of the element to return.
    /// @returns Element at the specified index. Never \c NULL.
    /// @exception MQLLIB_INVALID_ARGUMENT_EXCEPTION : if \a index < 0 or
    /// index >= elementCount().
    MQLLIB_XML_Element* elementAt(int index);

    /// @brief Returns the first child element with the specified name.
    /// @param name : name of the child element to return.
    /// @return First child element found which is named \a name.
    /// @exception MQLLIB_INVALID_ARGUMENT_EXCEPTION : if there is no child
    /// element with the specified name.
    MQLLIB_XML_Element* elementFor(const string name) const;

    /// @brief Returns a XML string that represents the element.
    /// @param indent String of spaces representing the amount of 'indent'.
    /// @return XML string that represents the element, its attributes and its
    /// child elements.
    string toString(const string indent = "") const;

private:
    string attributesAsString() const;
    string escape(string value) const;
};

//-----------------------------------------------------------------------------

MQLLIB_XML_Element::~MQLLIB_XML_Element() {
    MQLLIB_FOREACHV(MQLLIB_XML_Element*, node, _elements) {
        MQLLIB_Lang_SafeDelete(node);
    }
}

//-----------------------------------------------------------------------------

void MQLLIB_XML_Element::addAttribute(string attributeName, string value) {
    _attributes.add(
        new MQLLIB_Collection_Pair<string, string>(attributeName, value)
    );
}

//-----------------------------------------------------------------------------

void MQLLIB_XML_Element::addAttribute(string attributeName, int numericValue) {
    addAttribute(attributeName, IntegerToString(numericValue));
}

//-----------------------------------------------------------------------------

MQLLIB_XML_Element* MQLLIB_XML_Element::elementAt(int index) {
    if (index < 0  ||  index >= elementCount()) {
        MQLLIB_THROW(MQLLIB_INVALID_ARGUMENT_EXCEPTION);
        return NULL;
    }
    return _elements[index];
}

//-----------------------------------------------------------------------------

MQLLIB_XML_Element* MQLLIB_XML_Element::elementFor(const string name) const {
    MQLLIB_FOREACHV(MQLLIB_XML_Element*, node, _elements) {
        if (node.name() == name) {
            return node;
        }
    }
    MQLLIB_THROW(MQLLIB_INVALID_ARGUMENT_EXCEPTION);
    return NULL;
}

//-----------------------------------------------------------------------------

string MQLLIB_XML_Element::toString(const string indent) const {
    string element = indent;
    element = StringConcatenate(element, "<", _name);

    if (!_attributes.isEmpty()) {
        element = StringConcatenate(element, " ", attributesAsString());
    }

    element = StringConcatenate(element, ">");

    if (!_elements.isEmpty()) {
        element = StringConcatenate(element, "\n");
        string subNodeIndent = StringConcatenate(indent, "  ");

        MQLLIB_FOREACHV(MQLLIB_XML_Element*, node, _elements) {
            element = StringConcatenate(element, node.toString(subNodeIndent));
        }

        element = StringConcatenate(element, indent);
    }

    if (_content != "") {
        element = StringConcatenate(element, escape(_content));
        if (!_elements.isEmpty()) {
            element = StringConcatenate(element, "\n", indent);
        }
    }

    element = StringConcatenate(element, "</", _name, ">\n");

    return element;
}

//-----------------------------------------------------------------------------

string MQLLIB_XML_Element::attributesAsString() const {
    string attributes;

    for (
        __MQLLIB_Collections_Iterator
            <MQLLIB_Collection_Pair<string, string>*> it(_attributes);
        it.hasNext();
        it.next()
    ) {
        MQLLIB_Collection_Pair<string, string>* pair = it.current();
        attributes = StringConcatenate(
            attributes, pair.getKey(), "=\"", escape(pair.getValue()), "\" "
        );
    }

    // remove the last space
    return StringSubstr(attributes, 0, StringLen(attributes) - 1);
}

//-----------------------------------------------------------------------------

string MQLLIB_XML_Element::escape(string value) const {
    string escaped;

    for (int i = 0; i < StringLen(value); ++i) {
        uchar c = (uchar) StringGetCharacter(value, i);

        switch ( c ) {
        case '<':
            escaped = StringConcatenate(escaped, "&lt;");
            break;
        case '>':
            escaped = StringConcatenate(escaped, "&gt;");
            break;
        case '&':
            escaped = StringConcatenate(escaped, "&amp;");
            break;
        case '\'':
            escaped = StringConcatenate(escaped, "&apos;");
            break;
        case '"':
            escaped = StringConcatenate(escaped, "&quot;");
            break;
        default:
            escaped = StringConcatenate(escaped, CharToString(c));
        }
    }

    return escaped;
}

//-----------------------------------------------------------------------------

#endif
