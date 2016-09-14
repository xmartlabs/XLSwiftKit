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

    fileprivate static var saveToCameraRollCompletions: [UIImage: ((Bool) -> Void)] = [:]

    public convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        self.init(cgImage: (image?.cgImage!)!)
        UIGraphicsEndImageContext()
    }

    public convenience init(view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        self.init(cgImage: (image?.cgImage!)!)
        UIGraphicsEndImageContext()
    }

    public convenience init(image: UIImage, scaledToSize: CGSize) {
        UIGraphicsBeginImageContextWithOptions(scaledToSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: scaledToSize.width, height: scaledToSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        self.init(cgImage: (scaledImage?.cgImage!)!)
        UIGraphicsEndImageContext()
    }

    public class func imageWithColor(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIImage(color: color, size: size)
    }

    public class func imageWithView(_ view: UIView) -> UIImage {
        return UIImage(view: view)
    }

    public class func imageWithImage(_ image: UIImage, scaledToSize size: CGSize) -> UIImage {
        return UIImage(image: image, scaledToSize: size)
    }

    public func imageScaledToSize(_ size: CGSize) -> UIImage {
        return UIImage.imageWithImage(self, scaledToSize: size)
    }

    public func saveToCameraRoll(_ completion: ((_ succeded: Bool) -> Void)? = nil) {
        if let completion = completion {
            UIImage.saveToCameraRollCompletions[self] = completion
        }
        UIImageWriteToSavedPhotosAlbum(self, self, #selector(UIImage.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        UIImage.saveToCameraRollCompletions[image]?(error == nil)
        UIImage.saveToCameraRollCompletions[image] = nil
    }

}
