//
//  ParametrizedString.swift
//  XLSwiftKit
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

// In order to use this helpers, you need to extend
// the String type and conform to ParametrizedString

public protocol ParametrizedString {

    var parameterFormat: String { get } /* for instance "{i}" */

}

extension ParametrizedString where Self: StringProtocol {

    public func parametrize(_ parameters: CustomStringConvertible...) -> String {
        return parameters
            .enumerated()
            .reduce(self.value) { replaceParameter(from: $0, index: $1.0, with: $1.1) }
    }

    public func parametrize(withDictonary dictonary: [Int: CustomStringConvertible]) -> String {
        return dictonary
            .reduce(self.value) { replaceParameter(from: $0, index: $1.0, with: $1.1) }
    }

    fileprivate func replaceParameter(from string: String, index: Int, with stringConvertible: CustomStringConvertible) -> String {
        let metaParameter = parameterFormat.replacingOccurrences(of: "i", with: "\(index)")
        return string.replacingOccurrences(of: metaParameter, with: stringConvertible.description)
    }

}

public protocol StringProtocol {

    var value: String { get }

}

extension String: StringProtocol {

    public var value: String { return self }

}

extension String {

    public var description: String { return self }

}
