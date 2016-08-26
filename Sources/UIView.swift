//
//  UIView.swift
//  XLFoundationSwiftKit
//
//  Created by Miguel Revetria on 12/9/15.
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

public protocol CustomViewAnimations {
    func shake(duration: CFTimeInterval)
    func spin(duration: CFTimeInterval, rotations: CGFloat, repeatCount: Float)
}

extension UIView: CustomViewAnimations {

    public func shake(duration: CFTimeInterval = 0.3) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values =  [0, 20, -20, 10, 0]
        animation.keyTimes = [0, (1 / 6.0), (3 / 6.0), (5 / 6.0), 1]
        animation.duration = duration
        animation.additive = true
        
        layer.addAnimation(animation, forKey:"shake")
    }

    public func spin(duration: CFTimeInterval, rotations: CGFloat, repeatCount: Float) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = M_PI * 2.0 * Double(rotations)
        animation.duration = duration
        animation.cumulative = true
        animation.repeatCount = repeatCount
        
        layer.addAnimation(animation, forKey:"rotationAnimation")
    }
}

public extension UIView {
    /**
     A function that returns a view containing the views passed as parameter as if it was a vertical stack view (putting all views vertically one after the other).
     Thought to be a iOS 8 alternative to real UIStackViews
     Note: Views to be stacked should define their height by constraints as their 'translatesAutoresizingMaskIntoConstraints' will be set to 'false'

     - parameter views:         The views that will conform the stackview
     - parameter alignLeading:  If the stacked views should be aligned on the leading side. Default is true
     - parameter alignTrailing: If the stacked views should be aligned on the trailing side. Default is true
     - parameter frame:         Frame for the stackView. If nil then the frame will be calculated with the passed views. Defauilt is nil
     - parameter width:         Width for the stackview. Used if frame is nil. Default is whole screen width

     - returns: A view with the stacked views.
     */
    static public func verticalStackView(views: [UIView], alignLeading: Bool = true, alignTrailing: Bool = true, frame: CGRect? = nil,
                                  width: CGFloat = UIScreen.mainScreen().bounds.width) -> UIView {
        guard views.count > 0 else { return UIView(frame: frame ?? .zero) }
        let view = UIView(frame: frame ?? CGRect(x: 0, y: 0, width: width, height: views.reduce(0, combine: { $0 + $1.frame.height })))

        // add views as subviews
        _ = views.map { view.addSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false }

        // define options
        var options = NSLayoutFormatOptions()
        if alignLeading {
            options = options.union(NSLayoutFormatOptions.AlignAllLeading)
        }
        if alignTrailing {
            options = options.union(NSLayoutFormatOptions.AlignAllTrailing)
        }

        // create constraints
        var index = 0
        for _ in [1..<views.count] {
            let firstView = views[index]
            let secondView = views[index + 1]

            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[first]-0-[second]", options: options, metrics: nil, views: ["first": firstView, "second": secondView]))
            index += 1
        }

        // add constraints for first and last view
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[first]", options: options,
            metrics: nil, views: ["first": views.first!]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[last]-0-|", options: options,
            metrics: nil, views: ["last": views.last!]))

        // add width constraint
        view.addConstraint(NSLayoutConstraint(item: views.first!, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1, constant: width))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: views.first, attribute: .Width, multiplier: 1, constant: 0))

        return view
    }
}
