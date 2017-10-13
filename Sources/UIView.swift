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

    func shake(_ duration: CFTimeInterval)
    func spin(_ duration: CFTimeInterval, rotations: CGFloat, repeatCount: Float)

}

extension UIView: CustomViewAnimations {

    public func shake(_ duration: CFTimeInterval = 0.3) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values =  [0, 20, -20, 10, 0]
        animation.keyTimes = [0, NSNumber(value: 1 / 6.0), NSNumber(value: 3 / 6.0), NSNumber(value: 5 / 6.0), 1]
        animation.duration = duration
        animation.isAdditive = true

        layer.add(animation, forKey:"shake")
    }

    public func spin(_ duration: CFTimeInterval, rotations: CGFloat, repeatCount: Float) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = .pi * 2.0 * Double(rotations)
        animation.duration = duration
        animation.isCumulative = true
        animation.repeatCount = repeatCount

        layer.add(animation, forKey:"rotationAnimation")
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
    static public func verticalStackView(_ views: [UIView], alignLeading: Bool = true, alignTrailing: Bool = true, frame: CGRect? = nil, width: CGFloat = UIScreen.main.bounds.width) -> UIView {
        guard !views.isEmpty else { return UIView(frame: frame ?? .zero) }
        let view = UIView(frame: frame ?? CGRect(x: 0, y: 0, width: width, height: views.reduce(0, { $0 + $1.frame.height })))

        // add views as subviews
        _ = views.map { view.addSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false }

        // define options
        var options = NSLayoutFormatOptions()
        if alignLeading {
            options = options.union(NSLayoutFormatOptions.alignAllLeading)
        }
        if alignTrailing {
            options = options.union(NSLayoutFormatOptions.alignAllTrailing)
        }

        // create constraints
        var index = 0
        for _ in [1..<views.count] {
            let firstView = views[index]
            let secondView = views[index + 1]

            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[first]-0-[second]", options: options, metrics: nil, views: ["first": firstView, "second": secondView]))
            index += 1
        }

        // add constraints for first and last view
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[first]", options: options,
            metrics: nil, views: ["first": views.first!]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[last]-0-|", options: options,
            metrics: nil, views: ["last": views.last!]))

        // add width constraint
        view.addConstraint(NSLayoutConstraint(item: views.first!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: width))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: views.first, attribute: .width, multiplier: 1, constant: 0))

        return view
    }

}
