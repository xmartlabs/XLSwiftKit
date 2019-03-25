import XCTest

typealias NTuple2 = (a: CGFloat, b: CGFloat)

class TestOverload2D: XCTestCase {
    enum Operation { case add, subtract, multiply, divide }
    enum OperandType { case point, size, vector }

    struct TestEntry_PassByReference_OpScalar {
        let aResult: CGFloat
        let bResult: CGFloat

        let lhs: (CGFloat, CGFloat)
        let rhs: CGFloat

        let operation: Operation

        init(_ operation: Operation,
             _ lhs: (CGFloat, CGFloat), _ rhs: CGFloat,
             _ aResult: CGFloat, _ bResult: CGFloat
            ) {
            self.lhs = lhs; self.rhs = rhs; self.operation = operation
            self.aResult = aResult; self.bResult = bResult
        }
    }

    func operate(_ operation: Operation, _ operandType: OperandType,
                 _ lhs: (CGFloat, CGFloat), _ rhs: CGFloat)
        -> (CGFloat, CGFloat)
    {
        switch operation {
        case .add:
            switch operandType {
            case .point:
                var p = CGPoint(x: lhs.0, y: lhs.1); p += rhs; return (p.x, p.y)

            case .size:
                var s = CGSize(width: lhs.0, height: lhs.1); s += rhs; return (s.width, s.height)

            case .vector:
                var v = CGVector(dx: lhs.0, dy: lhs.1); v += rhs; return (v.dx, v.dy)
            }

        case .subtract:
            switch operandType {
            case .point:
                var p = CGPoint(x: lhs.0, y: lhs.1); p -= rhs; return (p.x, p.y)

            case .size:
                var s = CGSize(width: lhs.0, height: lhs.1); s -= rhs; return (s.width, s.height)

            case .vector:
                var v = CGVector(dx: lhs.0, dy: lhs.1); v -= rhs; return (v.dx, v.dy)
            }

        case .multiply:
            switch operandType {
            case .point:
                var p = CGPoint(x: lhs.0, y: lhs.1); p *= rhs; return (p.x, p.y)

            case .size:
                var s = CGSize(width: lhs.0, height: lhs.1); s *= rhs; return (s.width, s.height)

            case .vector:
                var v = CGVector(dx: lhs.0, dy: lhs.1); v *= rhs; return (v.dx, v.dy)
            }

        case .divide:
            switch operandType {
            case .point:
                var p = CGPoint(x: lhs.0, y: lhs.1); p /= rhs; return (p.x, p.y)

            case .size:
                var s = CGSize(width: lhs.0, height: lhs.1); s /= rhs; return (s.width, s.height)

            case .vector:
                var v = CGVector(dx: lhs.0, dy: lhs.1); v /= rhs; return (v.dx, v.dy)
            }
        }
    }

    func testPassByReference_OpScalar() {
        let a = CGFloat.random(in: -1000...1000)
        let b = CGFloat.random(in: -1000...1000)
        let c = CGFloat.random(in: -1000...1000)
        let d = CGFloat.random(in: -1000...1000)
        let zero: (CGFloat, CGFloat) = (0.0, 0.0)

        continueAfterFailure = false
        XCTAssert(a != 0 && b != 0 && c != 0 && d != 0,
                  "Run again; got a zero random number, won't work for division")
        continueAfterFailure = true

        let testSetForPassByReference = [
            TestEntry_PassByReference_OpScalar(.add, zero, a, a, a),
            TestEntry_PassByReference_OpScalar(.add, (a, b), c, a + c, b + c),
            TestEntry_PassByReference_OpScalar(.add, (d, c), b, d + b, c + b),

            TestEntry_PassByReference_OpScalar(.subtract, zero, a, -a, -a),
            TestEntry_PassByReference_OpScalar(.subtract, (a, b), c, a - c, b - c),
            TestEntry_PassByReference_OpScalar(.subtract, (d, c), b, d - b, c - b),

            TestEntry_PassByReference_OpScalar(.multiply, zero, a, 0, 0),
            TestEntry_PassByReference_OpScalar(.multiply, (a, b), c, a * c, b * c),
            TestEntry_PassByReference_OpScalar(.multiply, (d, c), b, d * b, c * b),

            TestEntry_PassByReference_OpScalar(.divide, zero, a, 0, 0),
            TestEntry_PassByReference_OpScalar(.divide, (a, b), c, a / c, b / c),
            TestEntry_PassByReference_OpScalar(.divide, (d, c), b, d / b, c / b),
        ]

        testSetForPassByReference.forEach { testEntry in
            let p = (testEntry.lhs.0, testEntry.lhs.1)
            let s = (testEntry.lhs.0, testEntry.lhs.1)
            let v = (testEntry.lhs.0, testEntry.lhs.1)

            let pr = operate(testEntry.operation, .point, p, testEntry.rhs)
            XCTAssertEqual(CGPoint(x: pr.0, y: pr.1), CGPoint(x: testEntry.aResult, y: testEntry.bResult))

            let sr = operate(testEntry.operation, .size, s, testEntry.rhs)
            XCTAssertEqual(CGSize(width: sr.0, height: sr.1), CGSize(width: testEntry.aResult, height: testEntry.bResult))

            let vr = operate(testEntry.operation, .vector, v, testEntry.rhs)
            XCTAssertEqual(CGVector(dx: vr.0, dy: vr.1), CGVector(dx: testEntry.aResult, dy: testEntry.bResult))
        }
    }
}
