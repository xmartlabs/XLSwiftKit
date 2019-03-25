import XCTest

typealias NTuple2 = (aa: CGFloat, bb: CGFloat)

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

    private func operate_add(_ operandType: OperandType,
                             _ lhs: (CGFloat, CGFloat), _ rhs: CGFloat) -> (CGFloat, CGFloat) {
        switch operandType {
        case .point:
            var pp = CGPoint(x: lhs.0, y: lhs.1); pp += rhs; return (pp.x, pp.y)

        case .size:
            var ss = CGSize(width: lhs.0, height: lhs.1); ss += rhs; return (ss.width, ss.height)

        case .vector:
            var vv = CGVector(dx: lhs.0, dy: lhs.1); vv += rhs; return (vv.dx, vv.dy)
        }
    }

    func operate_subtract(_ operandType: OperandType,
                          _ lhs: (CGFloat, CGFloat), _ rhs: CGFloat)
        -> (CGFloat, CGFloat) {
            switch operandType {
            case .point:
                var pp = CGPoint(x: lhs.0, y: lhs.1); pp -= rhs; return (pp.x, pp.y)

            case .size:
                var ss = CGSize(width: lhs.0, height: lhs.1); ss -= rhs; return (ss.width, ss.height)

            case .vector:
                var vv = CGVector(dx: lhs.0, dy: lhs.1); vv -= rhs; return (vv.dx, vv.dy)
            }
    }

    func operate_multiply(_ operandType: OperandType,
                          _ lhs: (CGFloat, CGFloat), _ rhs: CGFloat) -> (CGFloat, CGFloat) {
        switch operandType {
        case .point:
            var pp = CGPoint(x: lhs.0, y: lhs.1); pp *= rhs; return (pp.x, pp.y)

        case .size:
            var ss = CGSize(width: lhs.0, height: lhs.1); ss *= rhs; return (ss.width, ss.height)

        case .vector:
            var vv = CGVector(dx: lhs.0, dy: lhs.1); vv *= rhs; return (vv.dx, vv.dy)
        }
    }

    func operate_divide(_ operandType: OperandType,
                        _ lhs: (CGFloat, CGFloat), _ rhs: CGFloat) -> (CGFloat, CGFloat) {
        switch operandType {
        case .point:
            var pp = CGPoint(x: lhs.0, y: lhs.1); pp /= rhs; return (pp.x, pp.y)

        case .size:
            var ss = CGSize(width: lhs.0, height: lhs.1); ss /= rhs; return (ss.width, ss.height)

        case .vector:
            var vv = CGVector(dx: lhs.0, dy: lhs.1); vv /= rhs; return (vv.dx, vv.dy)
        }
    }

    func operate(_ operation: Operation, _ operandType: OperandType,
                 _ lhs: (CGFloat, CGFloat), _ rhs: CGFloat) -> (CGFloat, CGFloat) {
        switch operation {
        case .add: return operate_add(operandType, lhs, rhs)
        case .subtract: return operate_subtract(operandType, lhs, rhs)
        case .multiply: return operate_multiply(operandType, lhs, rhs)
        case .divide: return operate_divide(operandType, lhs, rhs)
        }
    }

    func testPassByReference_OpScalar() {
        let aa = CGFloat.random(in: -1000...1000)
        let bb = CGFloat.random(in: -1000...1000)
        let cc = CGFloat.random(in: -1000...1000)
        let dd = CGFloat.random(in: -1000...1000)
        let zero: (CGFloat, CGFloat) = (0.0, 0.0)

        continueAfterFailure = false
        XCTAssert(aa != 0 && bb != 0 && cc != 0 && dd != 0,
                  "Run again; got aa zero random number, won't work for division")
        continueAfterFailure = true

        let testSetForPassByReference = [
            TestEntry_PassByReference_OpScalar(.add, zero, aa, aa, aa),
            TestEntry_PassByReference_OpScalar(.add, (aa, bb), cc, aa + cc, bb + cc),
            TestEntry_PassByReference_OpScalar(.add, (dd, cc), bb, dd + bb, cc + bb),

            TestEntry_PassByReference_OpScalar(.subtract, zero, aa, -aa, -aa),
            TestEntry_PassByReference_OpScalar(.subtract, (aa, bb), cc, aa - cc, bb - cc),
            TestEntry_PassByReference_OpScalar(.subtract, (dd, cc), bb, dd - bb, cc - bb),

            TestEntry_PassByReference_OpScalar(.multiply, zero, aa, 0, 0),
            TestEntry_PassByReference_OpScalar(.multiply, (aa, bb), cc, aa * cc, bb * cc),
            TestEntry_PassByReference_OpScalar(.multiply, (dd, cc), bb, dd * bb, cc * bb),

            TestEntry_PassByReference_OpScalar(.divide, zero, aa, 0, 0),
            TestEntry_PassByReference_OpScalar(.divide, (aa, bb), cc, aa / cc, bb / cc),
            TestEntry_PassByReference_OpScalar(.divide, (dd, cc), bb, dd / bb, cc / bb)
        ]

        testSetForPassByReference.forEach { testEntry in
            let pp = (testEntry.lhs.0, testEntry.lhs.1)
            let ss = (testEntry.lhs.0, testEntry.lhs.1)
            let vv = (testEntry.lhs.0, testEntry.lhs.1)

            let pr = operate(testEntry.operation, .point, pp, testEntry.rhs)
            XCTAssertEqual(CGPoint(x: pr.0, y: pr.1), CGPoint(x: testEntry.aResult, y: testEntry.bResult))

            let sr = operate(testEntry.operation, .size, ss, testEntry.rhs)
            XCTAssertEqual(CGSize(width: sr.0, height: sr.1), CGSize(width: testEntry.aResult, height: testEntry.bResult))

            let vr = operate(testEntry.operation, .vector, vv, testEntry.rhs)
            XCTAssertEqual(CGVector(dx: vr.0, dy: vr.1), CGVector(dx: testEntry.aResult, dy: testEntry.bResult))
        }
    }
}
