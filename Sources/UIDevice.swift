//
//  UIDevice.swift
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

import Foundation

/**
 These extensions have the intention to return if the current device has certain size or not.
 */
public extension UIDevice {

    func maxScreenLength() -> CGFloat {
        let bounds = UIScreen.main.bounds
        return max(bounds.width, bounds.height)
    }

    func iPhone4() -> Bool {
        return maxScreenLength() == 480
    }

    func iPhone5() -> Bool {
        return maxScreenLength() == 568
    }

    func iPhone6or7() -> Bool {
        return maxScreenLength() == 667
    }

    func iPhone6or7Plus() -> Bool {
        return maxScreenLength() == 736
    }

    /**
     Resize a font according to current device. Works for iPhone apps only. The desired font size will be multiplied by the coefficient for the corresponding current device.
     All coefficients have reasonable default values.

     - parameter size: Desired font size for iPhone6 Plus device type (or any other with the same size)
     - parameter q6:   iPhone6 coefficient
     - parameter q5:   iPhone5 coefficient
     - parameter q4:   iPhone4 coefficient

     - returns: The correctly resized font size
     */
    func fontSizeForDevice(_ size: CGFloat, q6: CGFloat = 0.94, q5: CGFloat = 0.86, q4: CGFloat = 0.80) -> CGFloat {
        if iPhone4() {
            return max(10, size * q4)
        } else if iPhone5() {
            return max(10, size * q5)
        } else if iPhone6or7() {
            return max(10, size * q6)
        }
        return size
    }
}

/**
 Scale a value for a vertical constraint constant depending on the current device. Works for iPhone apps only. All coefficients have reasonable default values for vertical constraints

 - parameter value: Desired value for iPhone6 Plus device type (or any other with the same size)
 - parameter q6:   iPhone6 coefficient
 - parameter q5:   iPhone5 coefficient
 - parameter q4:   iPhone4 coefficient

 - returns: The correctly resized constraint value
 */
public func suggestedVerticalConstraint(_ value: CGFloat, q6: CGFloat = 0.9, q5: CGFloat = 0.77, q4: CGFloat = 0.65) -> CGFloat {
    if UIDevice.current.iPhone4() {
        return ceil(value * q4)
    } else if UIDevice.current.iPhone5() {
        return ceil(value * q5)
    } else if UIDevice.current.iPhone6or7() {
        return ceil(value * q6)
    } else {
        return value
    }
}

/**
 Scale a value for a horizontal constraint constant depending on the current device. Works for iPhone apps only. All coefficients have reasonable default values for horizontal constraints

 - parameter value: Desired value for iPhone6 Plus device type (or any other with the same size)
 - parameter q6:   iPhone6 coefficient
 - parameter q5:   iPhone5 coefficient
 - parameter q4:   iPhone4 coefficient

 - returns: The correctly resized constraint value
 */
public func suggestedHorizontalConstraint(_ value: CGFloat, q6: CGFloat = 0.9, q5: CGFloat = 0.77, q4: CGFloat = 0.77) -> CGFloat {
    if UIDevice.current.iPhone4() {
        return ceil(value * q4)
    } else if UIDevice.current.iPhone5() {
        return ceil(value * q5)
    } else if UIDevice.current.iPhone6or7() {
        return ceil(value * q6)
    } else {
        return value
    }
}
