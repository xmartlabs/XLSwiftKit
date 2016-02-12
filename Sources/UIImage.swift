//
//  UIImage.swift
//  XLFoundationSwiftKit
//
//  Created by mathias Claassen on 24/11/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import UIKit

public extension UIImage {

    private static var saveToCameraRollCompletions : [UIImage : (Bool -> Void)] = [:]

    public convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        self.init(CGImage: image.CGImage!)
        UIGraphicsEndImageContext()
    }
    
    public convenience init(view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        self.init(CGImage: image.CGImage!)
        UIGraphicsEndImageContext()
    }
    
    public convenience init(image: UIImage, scaledToSize: CGSize) {
        UIGraphicsBeginImageContextWithOptions(scaledToSize, false, 0.0)
        image.drawInRect(CGRect(x: 0, y: 0, width: scaledToSize.width, height: scaledToSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        self.init(CGImage: scaledImage.CGImage!)
        UIGraphicsEndImageContext()
    }

    public class func imageWithColor(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIImage(color: color, size: size)
    }
    
    public class func imageWithView(view: UIView) -> UIImage {
        return UIImage(view: view)
    }
    
    public class func imageWithImage(image: UIImage, scaledToSize size: CGSize) -> UIImage {
        return UIImage(image: image, scaledToSize: size)
    }
    
    public func imageScaledToSize(size: CGSize) -> UIImage {
        return UIImage.imageWithImage(self, scaledToSize: size)
    }
    
    public func saveToCameraRoll(completion: ((succeded: Bool) -> Void)? = nil) {
        if let completion = completion {
            UIImage.saveToCameraRollCompletions[self] = completion
        }
        UIImageWriteToSavedPhotosAlbum(self, self, Selector("image:didFinishSavingWithError:contextInfo:"), nil)
    }

    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafePointer<()>) {
        UIImage.saveToCameraRollCompletions[image]?(error == nil || error.memory == nil)
        UIImage.saveToCameraRollCompletions[image] = nil
    }
}
