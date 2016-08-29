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

    case Horizontal
    case Vertcial
    case Custom(start: CGPoint, end: CGPoint)

    var directionPoints: (start: CGPoint, end: CGPoint) {
        switch self {
        case .Horizontal:
            return (start: CGPoint(x: 0, y: 0.5), end: CGPoint(x: 1, y: 0.5))
        case .Vertcial:
            return (start: CGPoint(x: 0.5, y: 0), end: CGPoint(x: 0.5, y: 1))
        case let Custom(start, end):
            return (start: start, end: end)
        }
    }

}

public class GradientView: UIView {

    public var colors: [UIColor]? {
        didSet {
            updateColors()
        }
    }

    public var direction = GradientViewDirection.Vertcial {
        didSet {
            updateDirection()
        }
    }

    private let gradientLayer = CAGradientLayer()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        backgroundColor = .clearColor()
        layer.addSublayer(gradientLayer)
        updateColors()
        updateDirection()
    }

    private func updateColors() {
        guard let colors = colors else { return }
        gradientLayer.colors = colors.map { $0.CGColor }
        let count = CGFloat(colors.count)
        let locations = colors.enumerate().map { CGFloat($0.index) }.reduce([]) { $0 + [$1 / (count - 1)] }
        gradientLayer.locations = locations
    }

    private func updateDirection() {
        let (startPoint, endPoint) = direction.directionPoints
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
    }

    override public func layoutSublayersOfLayer(layer: CALayer) {
        super.layoutSublayersOfLayer(layer)
        gradientLayer.frame = layer.frame
    }

}
