//
//  UIApplication.swift
//  XLFoundationSwiftKit
//
//  Created by mathias Claassen on 24/11/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import UIKit

public extension UIApplication {

    public class func topViewController(base: UIViewController? = UIApplication.sharedApplication().keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController where top.view.window != nil {
                return topViewController(top)
            } else if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        
        return base
    }
    
    public static func makePhoneCall(phoneNumber: String) -> Bool {
        guard let phoneNumberUrl = NSURL(string: phoneNumber) where UIApplication.sharedApplication().canOpenURL(phoneNumberUrl) else {
            return false
        }
        return UIApplication.sharedApplication().openURL(phoneNumberUrl)
    }
    
    public static var bundleIdentifier: String {
        return NSBundle.mainBundle().bundleIdentifier!
    }
    
    public static var buildVersion: String {
        return NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String
    }
    
    public static var appVersion: String {
        return NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    public static var bundleName: String {
        return NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String
    }
}
