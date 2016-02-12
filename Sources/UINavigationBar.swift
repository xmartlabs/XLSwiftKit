//
//  UINavigationBar.swift
//  XLFoundationSwiftKit
//
//  Created by Miguel Revetria on 12/9/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import Foundation

public extension UINavigationBar {
    
    public func setTransparent(transparent: Bool) {
        if transparent {
            setBackgroundImage(UIImage(), forBarMetrics: .Default)
            shadowImage = UIImage()
            translucent = true
            backgroundColor = .clearColor()
        } else {
            // By default take values from UINavigationBar appearance
            let backImage = UINavigationBar.appearance().backgroundImageForBarMetrics(.Default)
            setBackgroundImage(backImage, forBarMetrics: .Default)
            shadowImage = UINavigationBar.appearance().shadowImage
            translucent = UINavigationBar.appearance().translucent
            backgroundColor = UINavigationBar.appearance().backgroundColor
        }
    }

}
