//
//  Box.swift
//  XLSwiftKit
//
//  Created by mathias Claassen on 17/2/16.
//
//

import Foundation

/** Box is a Wrapper: e.g. Used to wrap any structs in a class so that they can be used where AnyObject is required
*/
public class Box<T> {
    
    public let value: T?
    
    public init(_ value: T){
        self.value = value
    }
}
