//
//  UIView.swift
//  XLFoundationSwiftKit
//
//  Created by Miguel Revetria on 12/9/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

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
