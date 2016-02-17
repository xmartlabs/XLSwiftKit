//
//  Dictionary.swift
//  XLFoundationSwiftKit
//
//  Created by mathias Claassen on 24/11/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import Foundation

public extension Dictionary {
    mutating func merge(dict: [Key: Value]) {
        for (k, v) in dict {
            self.updateValue(v, forKey: k)
        }
    }
}
