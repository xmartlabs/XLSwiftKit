//
//  UIImage.swift
//  XLFoundationSwiftKit
//
//  Created by mathias Claassen on 24/11/15.
//  Copyright (c) 2016 Xmartlabs SRL ( http://xmartlabs.com )
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
        UIImageWriteToSavedPhotosAlbum(self, self, #selector(UIImage.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafePointer<()>) {
        UIImage.saveToCameraRollCompletions[image]?(error == nil || error.memory == nil)
        UIImage.saveToCameraRollCompletions[image] = nil
    }
}
