//
//  UIViewController.swift
//  XLFoundationSwiftKit
//
//  Created by Miguel Revetria on 12/9/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import Foundation

public extension UIViewController {
    public func showError(title: String, message: String) {
        if !NSThread.currentThread().isMainThread {
            dispatch_async(dispatch_get_main_queue()) { [weak self] in
                self?.showError(title, message: message)
            }
            return
        }
        
        let controller = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        controller.view.tintColor = UIWindow.appearance().tintColor
        controller.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
        presentViewController(controller, animated: true, completion: nil)
    }
}
