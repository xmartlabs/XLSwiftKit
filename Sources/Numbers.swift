//
//  Numbers.swift
//  XLFoundationSwiftKit
//
//  Created by Miguel Revetria on 8/12/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import Foundation

public extension Double {

    public func currencyString() -> String? {
        return Constants.Formatters.currencyFormatter.stringFromNumber(NSNumber(double: self))
    }

}

public extension Int {

    public func currencyString() -> String? {
        return Constants.Formatters.currencyFormatter.stringFromNumber(NSNumber(integer: self))
    }

}
