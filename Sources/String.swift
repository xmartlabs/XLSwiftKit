//
//  String.swift
//  XLFoundationSwiftKit
//
//  Created by mathias Claassen on 24/11/15.
//  Copyright (c) 2016 Xmartlabs SRL ( http://xmartlabs.com )
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

public extension String {

    /// Returns if a string is valid as email
    func isValidAsEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    /// Returns if a string is valid as phone number
    func isValidAsPhone() -> Bool {
        let phoneRegEx = "^[0-9-+]{9,15}$"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: self)
    }

    /// Returns if a string is composed just of numbers or '-' symbol
    func isNumberString() -> Bool {
        let charSet = NSMutableCharacterSet(charactersIn: "-")
        charSet.formUnion(with: CharacterSet.decimalDigits)
        return  rangeOfCharacter(from: charSet.inverted) == nil
    }

    /// Returns the first number in a String if found
    func findFirstNumberInString() -> String? {
        if let range = rangeOfCharacter(from: CharacterSet.decimalDigits), let numRange = rangeOfCharacter(from: CharacterSet.decimalDigits.inverted, options: .literal,
                range: range.lowerBound..<self.endIndex) {
            return String(self[range.lowerBound..<numRange.lowerBound])
        }
        return nil
    }

    /// Return the height necessary for a text given a width and font size. Same as `heightForString` extension on UIFont
    func renderedHeightWithFont(_ font: UIFont, width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: 5000)
        let attributes = [NSAttributedStringKey.font: font]
        let objcStr = NSString(string: self)
        let boundingRect = objcStr.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return boundingRect.height
    }

    /// Parses a first and a last name from a String. Takes last whitespace as separator for these values.
    func getFirstAndLastName() -> (String, String)? {
        guard let range = trimmingCharacters(in: CharacterSet.whitespaces).range(of: " ", options: .backwards,
            range: nil, locale: nil) else {
            return nil
        }
        let first = String(self[..<range.lowerBound])
        let last = String(self[range.upperBound...])
        return (first, last)
    }

}
