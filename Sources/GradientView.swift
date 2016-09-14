//
//  RoundedView.swift
//  XLSwiftKit ( https://github.com/xmartlabs/XLSwiftKit )
//
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

public enum GradientViewDirection {

    case horizontal
    case vertcial
    case custom(start: CGPoint, end: CGPoint)

    var directionPoints: (start: CGPoint, end: CGPoint) {
        switch self {
        case .horizontal:
            return (start: CGPoint(x: 0, y: 0.5), end: CGPoint(x: 1, y: 0.5))
        case .vertcial:
            return (start: CGPoint(x: 0.5, y: 0), end: CGPoint(x: 0.5, y: 1))
        case let .custom(start, end):
            return (start: start, end: end)
        }
    }

}

open class GradientView: UIView {

    open var colors: [UIColor]? {
        didSet {
            updateColors()
        }
    }

    open var direction = GradientViewDirection.vertcial {
        didSet {
            updateDirection()
        }
    }

    fileprivate let gradientLayer = CAGradientLayer()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    fileprivate func setup() {
        backgroundColor = .clear
        layer.addSublayer(gradientLayer)
        updateColors()
        updateDirection()
    }

    fileprivate func updateColors() {
        guard let colors = colors else { return }
        gradientLayer.colors = colors.map { $0.cgColor }
        let count = CGFloat(colors.count)
        let locations = colors.enumerated().map { CGFloat($0.0) }.reduce([]) { $0 + [$1 / (count - 1)] }
        gradientLayer.locations = locations as [NSNumber]
    }

    fileprivate func updateDirection() {
        let (startPoint, endPoint) = direction.directionPoints
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
    }

//    override open func layoutSublayersOfLayer(_ layer: CALayer) {
//        super.layoutSublayersOfLayer(layer)
//        gradientLayer.frame = layer.frame
//    }

}
