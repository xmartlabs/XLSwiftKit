//
//  UIDevice.swift
//  XLFoundationSwiftKit
//
//  Created by mathias Claassen on 24/11/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import Foundation

public extension UIDevice {
    func maxScreenLength() -> CGFloat {
        let bounds = UIScreen.mainScreen().bounds
        return max(bounds.width, bounds.height)
    }
    
    func iPhone5() -> Bool {
        return maxScreenLength() == 568
    }
    
    func iPhone6() -> Bool {
        return maxScreenLength() == 667
    }
    
    func iPhone6Plus() -> Bool {
        return maxScreenLength() == 736
    }
}
