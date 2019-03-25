import CoreGraphics

/// Arithmetic extensions for CGPoint, CGSize, and CGVector.
/// All of the operators +, -, *, /, and unary minus are supported. Where
/// applicable, operators can be applied to point/size/vector + point/size/vector,
/// as well as point/size/vector + CGFloat and CGFloat + point/size/vector.
protocol Overload2D {
    /// Really for internal use, but publicly available so the unit tests can use them.
    var aa: CGFloat { get set }
    var bb: CGFloat { get set }

    /// So we can create any one of our types without needing argument names
    /// - Parameters:
    ///   - xx: depending on the object being created, this is the x-coordinate,
    ///        or the width, or the dx component
    ///   - yy: depending on the object being created, this is the y-coordinate,
    ///        or the height, or the dy component
    init(_ xx: CGFloat, _ yy: CGFloat)

    /// Convenience function for easy conversion to CGPoint from the others,
    /// to make arithmetic operations between the types easier to write and read.
    func asPoint() -> CGPoint
    /// Convenience function for easy conversion to CGSize from the others,
    /// to make arithmetic operations between the types easier to write and read.
    func asSize() -> CGSize
    /// Convenience function for easy conversion to CGVector from the others,
    /// to make arithmetic operations between the types easier to write and read.
    func asVector() -> CGVector

    /// So we can create any one of our types without needing argument names
    ///
    /// Same functionality as init(_:,_:)
    ///
    /// - Parameters:
    ///   - x: depending on the object being created, this is the x-coordinate,
    ///        or the width, or the dx component
    ///   - y: depending on the object being created, this is the y-coordinate,
    ///        or the height, or the dy component
    static func makeTuple(_ xx: CGFloat, _ yy: CGFloat) -> Self

    /// Unary minus: negates both scalars in the tuple
    static prefix func - (_ myself: Self) -> Self

    /// Basic arithmetic with tuples on both sides of the operator.
    /// These return a new tuple with lhsTuple.0 (op) rhsTuple.0, lhsTuple.1 (op) rhsTuple.1.
    ///
    /// Examples:
    ///
    /// CGPoint(x: 10, y: 3) + CGPoint(17, 37) = CGPoint(x: 10 + 17, y: 3 + 37)
    ///
    /// CGSize(width: 5, height: 7) * CGSize(width: 12, height: 13) = CGSize(width: 5 * 12, height: 7 * 13)
    static func + (_ lhs: Self, _ rhs: Self) -> Self
    static func - (_ lhs: Self, _ rhs: Self) -> Self
    static func * (_ lhs: Self, _ rhs: Self) -> Self
    static func / (_ lhs: Self, _ rhs: Self) -> Self

    /// Basic arithmetic with tuple (op) CGFloat, or CGFloat (op) tuple
    /// These return a new tuple with lhsTuple.0 (op) rhs, lhsTuple.1 (op) rhs.
    ///
    /// Examples:
    ///
    /// CGPoint(x: 10, y: 3) / 42 = CGPoint(x: 10 / 42, y: 3 / 42)
    ///
    /// CGSize(width: 5, height: 7) - 137 = CGSize(width: 5 - 137, height: 7 - 137)
    static func + (_ lhs: Self, _ rhs: CGFloat) -> Self
    static func - (_ lhs: Self, _ rhs: CGFloat) -> Self
    static func * (_ lhs: Self, _ rhs: CGFloat) -> Self
    static func / (_ lhs: Self, _ rhs: CGFloat) -> Self

    static func + (_ lhs: CGFloat, _ rhs: Self) -> Self
    static func - (_ lhs: CGFloat, _ rhs: Self) -> Self
    static func * (_ lhs: CGFloat, _ rhs: Self) -> Self
    static func / (_ lhs: CGFloat, _ rhs: Self) -> Self

    /// Compound assignment operators. These all work the same as the basic operators,
    /// applying compound assignment the same as the usual arithmetic versions.
    static func += (_ lhs: inout Self, _ rhs: Self)
    static func -= (_ lhs: inout Self, _ rhs: Self)
    static func *= (_ lhs: inout Self, _ rhs: Self)
    static func /= (_ lhs: inout Self, _ rhs: Self)

    static func += (_ lhs: inout Self, _ rhs: CGFloat)
    static func -= (_ lhs: inout Self, _ rhs: CGFloat)
    static func *= (_ lhs: inout Self, _ rhs: CGFloat)
    static func /= (_ lhs: inout Self, _ rhs: CGFloat)
}

// MARK: Implementations

extension Overload2D {
    static prefix func - (_ myself: Self) -> Self {
        return myself * -1.0
    }

    static func + (_ lhs: Self, _ rhs: Self) -> Self {
        return makeTuple(lhs.aa + rhs.aa, lhs.bb + rhs.bb)
    }
    static func - (_ lhs: Self, _ rhs: Self) -> Self {
        return makeTuple(lhs.aa - rhs.aa, lhs.bb - rhs.bb)
    }
    static func * (_ lhs: Self, _ rhs: Self) -> Self {
        return makeTuple(lhs.aa * rhs.aa, lhs.bb * rhs.bb)
    }
    static func / (_ lhs: Self, _ rhs: Self) -> Self {
        return makeTuple(lhs.aa / rhs.aa, lhs.bb / rhs.bb)
    }

    static func + (_ lhs: Self, _ rhs: CGFloat) -> Self {
        return makeTuple(lhs.aa + rhs, lhs.bb + rhs)
    }
    static func - (_ lhs: Self, _ rhs: CGFloat) -> Self {
        return makeTuple(lhs.aa - rhs, lhs.bb - rhs)
    }
    static func * (_ lhs: Self, _ rhs: CGFloat) -> Self {
        return makeTuple(lhs.aa * rhs, lhs.bb * rhs)
    }
    static func / (_ lhs: Self, _ rhs: CGFloat) -> Self {
        return makeTuple(lhs.aa / rhs, lhs.bb / rhs)
    }

    static func + (_ lhs: CGFloat, _ rhs: Self) -> Self {
        return makeTuple(lhs + rhs.aa, lhs + rhs.bb)
    }
    static func - (_ lhs: CGFloat, _ rhs: Self) -> Self {
        return makeTuple(lhs - rhs.aa, lhs - rhs.bb)
    }
    static func * (_ lhs: CGFloat, _ rhs: Self) -> Self {
        return makeTuple(lhs * rhs.aa, lhs * rhs.bb)
    }
    static func / (_ lhs: CGFloat, _ rhs: Self) -> Self {
        return makeTuple(lhs / rhs.aa, lhs / rhs.bb)
    }

    static func += (_ lhs: inout Self, _ rhs: Self) {
        lhs.aa += rhs.aa; lhs.bb += rhs.bb
    }
    static func -= (_ lhs: inout Self, _ rhs: Self) {
        lhs.aa -= rhs.aa; lhs.bb -= rhs.bb
    }
    static func *= (_ lhs: inout Self, _ rhs: Self) {
        lhs.aa *= rhs.aa; lhs.bb *= rhs.bb
    }
    static func /= (_ lhs: inout Self, _ rhs: Self) {
        lhs.aa /= rhs.aa; lhs.bb /= rhs.bb
    }

    static func += (_ lhs: inout Self, _ rhs: CGFloat) {
        lhs.aa += rhs; lhs.bb += rhs
    }
    static func -= (_ lhs: inout Self, _ rhs: CGFloat) {
        lhs.aa -= rhs; lhs.bb -= rhs
    }
    static func *= (_ lhs: inout Self, _ rhs: CGFloat) {
        lhs.aa *= rhs; lhs.bb *= rhs
    }
    static func /= (_ lhs: inout Self, _ rhs: CGFloat) {
        lhs.aa /= rhs; lhs.bb /= rhs
    }
}

extension Overload2D where Self == CGVector {
    func magnitude() -> CGFloat {
        return sqrt(self.dx * self.dx + self.dy * self.dy)
    }
}

extension Overload2D where Self == CGPoint {
    func distance(to otherPoint: CGPoint) -> CGFloat {
        return (otherPoint - self).asVector().magnitude()
    }

    static func random(in range: Range<CGFloat>) -> CGPoint {
        return CGPoint(x: CGFloat.random(in: range), y: CGFloat.random(in: range))
    }

    static func random(xRange: Range<CGFloat>, yRange: Range<CGFloat>) -> CGPoint {
        return CGPoint(x: CGFloat.random(in: xRange), y: CGFloat.random(in: yRange))
    }
}

extension Overload2D where Self == CGSize {
    static func random(in range: Range<CGFloat>) -> CGSize {
        return CGSize(width: CGFloat.random(in: range), height: CGFloat.random(in: range))
    }

    static func random(widthRange: Range<CGFloat>, heightRange: Range<CGFloat>) -> CGSize {
        return CGSize(width: CGFloat.random(in: widthRange), height: CGFloat.random(in: heightRange))
    }
}

extension Overload2D where Self == CGVector {
    static func random(in range: Range<CGFloat>) -> CGVector {
        return CGVector(dx: CGFloat.random(in: range), dy: CGFloat.random(in: range))
    }

    static func random(dxRange: Range<CGFloat>, dyRange: Range<CGFloat>) -> CGVector {
        return CGVector(dx: CGFloat.random(in: dxRange), dy: CGFloat.random(in: dyRange))
    }
}

extension CGPoint: Overload2D {
    var aa: CGFloat { get { return self.x } set { self.x = newValue } }
    var bb: CGFloat { get { return self.y } set { self.y = newValue } }

    init(_ xx: CGFloat, _ yy: CGFloat) {
        self.init(x: xx, y: yy)
    }

    static func makeTuple(_ xx: CGFloat, _ yy: CGFloat) -> CGPoint {
        return CGPoint(x: xx, y: yy)
    }

    static func makeTuple(_ xx: CGFloat, _ yy: CGFloat) -> CGSize {
        return CGSize.makeTuple(xx, yy)
    }

    static func makeTuple(_ xx: CGFloat, _ yy: CGFloat) -> CGVector {
        return CGVector.makeTuple(xx, yy)
    }

    func asPoint() -> CGPoint {
        return CGPoint(x: x, y: y)
    }

    func asSize() -> CGSize {
        return CGSize(width: x, height: y)
    }

    func asVector() -> CGVector {
        return CGVector(dx: x, dy: y)
    }
}

extension CGSize: Overload2D {
    var aa: CGFloat { get { return self.width } set { self.width = newValue } }
    var bb: CGFloat { get { return self.height } set { self.height = newValue } }

    init(_ width: CGFloat, _ height: CGFloat) {
        self.init(width: width, height: height)
    }

    static func makeTuple(_ width: CGFloat, _ height: CGFloat) -> CGPoint {
        return CGPoint.makeTuple(width, height)
    }

    static func makeTuple(_ width: CGFloat, _ height: CGFloat) -> CGSize {
        return CGSize(width: width, height: height)
    }

    static func makeTuple(_ width: CGFloat, _ height: CGFloat) -> CGVector {
        return CGVector.makeTuple(width, height)
    }

    func asPoint() -> CGPoint {
        return CGPoint(x: width, y: height)
    }

    func asSize() -> CGSize {
        return CGSize(width: width, height: height)
    }

    func asVector() -> CGVector {
        return CGVector(dx: width, dy: height)
    }
}

extension CGVector: Overload2D {
    var aa: CGFloat { get { return self.dx } set { self.dx = newValue } }
    var bb: CGFloat { get { return self.dy } set { self.dy = newValue } }

    init(_ dx: CGFloat, _ dy: CGFloat) {
        self.init(dx: dx, dy: dy)
    }

    static func makeTuple(_ dx: CGFloat, _ dy: CGFloat) -> CGPoint {
        return CGPoint.makeTuple(dx, dy)
    }

    static func makeTuple(_ dx: CGFloat, _ dy: CGFloat) -> CGSize {
        return CGSize.makeTuple(dx, dy)
    }

    static func makeTuple(_ dx: CGFloat, _ dy: CGFloat) -> CGVector {
        return CGVector(dx: dx, dy: dy)
    }

    func asPoint() -> CGPoint {
        return CGPoint(x: dx, y: dy)
    }

    func asSize() -> CGSize {
        return CGSize(width: dx, height: dy)
    }

    func asVector() -> CGVector {
        return CGVector(dx: dx, dy: dy)
    }
}
