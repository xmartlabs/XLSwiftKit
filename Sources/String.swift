//
//  String.swift
//  XLFoundationSwiftKit
//
//  Created by mathias Claassen on 24/11/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import Foundation

public extension String {
    
    func isValidAsEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(self)
    }
    
    func isValidAsPhone() -> Bool {
        let phoneRegEx = "^[0-9-+]{9,15}$"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluateWithObject(self)
    }
    
    func isNumberString() -> Bool {
        let charSet = NSMutableCharacterSet(charactersInString: "-")
        charSet.formUnionWithCharacterSet(NSCharacterSet.decimalDigitCharacterSet())
        return  rangeOfCharacterFromSet(charSet.invertedSet) == nil
    }
    
    func findFirstNumberInString() -> String? {
        if let range = rangeOfCharacterFromSet(NSCharacterSet.decimalDigitCharacterSet()), let numRange = rangeOfCharacterFromSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet, options: .LiteralSearch,
                range: range.startIndex..<self.endIndex) {
                return substringWithRange(range.startIndex..<numRange.startIndex)
        }
        return nil
    }
    
    func renderedHeightWithFont(font: UIFont, width: CGFloat) -> CGFloat {
        let size = CGSizeMake(width, 5000)
        let attributes = [NSFontAttributeName: font]
        let objcStr = NSString(string: self)
        let boundingRect = objcStr.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes: attributes, context: nil)
        return boundingRect.height
    }
    
    func getFirstAndLastName() -> (String,String)?{
        guard let range = stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).rangeOfString(" ", options: .BackwardsSearch,
            range: nil, locale: nil) else {
            return nil
        }
        let first = substringToIndex(range.startIndex)
        let last = substringFromIndex(range.endIndex)
        return (first,last)
    }
    
}
