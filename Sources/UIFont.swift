//
//  UIFont.swift
//  XLFoundationSwiftKit
//
//  Created by mathias Claassen on 24/11/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import UIKit


extension UIFont {
    public func heightForString(string: NSString, width: CGFloat) -> CGFloat {
        let size = CGSizeMake(width, 5000)
        let s = string.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: self], context: nil)
        return s.height
    }
}
