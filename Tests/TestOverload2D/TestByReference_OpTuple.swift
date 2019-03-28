import XCTest

extension TestOverload2D {
    struct TestEntry_PassByReference_OpTuple {
        let lhs: (CGFloat, CGFloat)
        let rhs: (CGFloat, CGFloat)
        let result: (CGFloat, CGFloat)

        let operation: Operation

        init(_ operation: Operation,
             _ lhs: (CGFloat, CGFloat), _ rhs: (CGFloat, CGFloat),
             _ result: (CGFloat, CGFloat)
            ) {
            self.lhs = lhs; self.rhs = rhs; self.operation = operation; self.result = result
        }
    }

    private func operation_add(
        _ operandType: OperandType,
        _ lhs: (CGFloat, CGFloat),
        _ rhs: (CGFloat, CGFloat)
        ) -> (CGFloat, CGFloat) {

        switch operandType {
        case .point:
            var pp = CGPoint(x: lhs.0, y: lhs.1)
            pp += CGPoint(x: rhs.0, y: rhs.1)
            return (pp.x, pp.y)

        case .size:
            var ss = CGSize(width: lhs.0, height: lhs.1)
            ss += CGSize(width: rhs.0, height: rhs.1)
            return (ss.width, ss.height)

        case .vector:
            var vv = CGVector(dx: lhs.0, dy: lhs.1)
            vv += CGVector(dx: rhs.0, dy: rhs.1)
            return (vv.dx, vv.dy)
        }

    }

    private func operation_subtract(
        _ operandType: OperandType,
        _ lhs: (CGFloat, CGFloat),
        _ rhs: (CGFloat, CGFloat)
        ) -> (CGFloat, CGFloat) {

        switch operandType {
        case .point:
            var pp = CGPoint(x: lhs.0, y: lhs.1)
            pp -= CGPoint(x: rhs.0, y: rhs.1)
            return (pp.x, pp.y)

        case .size:
            var ss = CGSize(width: lhs.0, height: lhs.1)
            ss -= CGSize(width: rhs.0, height: rhs.1)
            return (ss.width, ss.height)

        case .vector:
            var vv = CGVector(dx: lhs.0, dy: lhs.1)
            vv -= CGVector(dx: rhs.0, dy: rhs.1)
            return (vv.dx, vv.dy)
        }

    }

    private func operation_multiply(
        _ operandType: OperandType,
        _ lhs: (CGFloat, CGFloat),
        _ rhs: (CGFloat, CGFloat)
        ) -> (CGFloat, CGFloat) {

        switch operandType {
        case .point:
            var pp = CGPoint(x: lhs.0, y: lhs.1)
            pp *= CGPoint(x: rhs.0, y: rhs.1)
            return (pp.x, pp.y)

        case .size:
            var ss = CGSize(width: lhs.0, height: lhs.1)
            ss *= CGSize(width: rhs.0, height: rhs.1)
            return (ss.width, ss.height)

        case .vector:
            var vv = CGVector(dx: lhs.0, dy: lhs.1)
            vv *= CGVector(dx: rhs.0, dy: rhs.1)
            return (vv.dx, vv.dy)
        }
    }

    private func operation_divide(
        _ operandType: OperandType,
        _ lhs: (CGFloat, CGFloat),
        _ rhs: (CGFloat, CGFloat)
        ) -> (CGFloat, CGFloat) {

        switch operandType {
        case .point:
            var pp = CGPoint(x: lhs.0, y: lhs.1)
            pp /= CGPoint(x: rhs.0, y: rhs.1)
            return (pp.x, pp.y)

        case .size:
            var ss = CGSize(width: lhs.0, height: lhs.1)
            ss /= CGSize(width: rhs.0, height: rhs.1)
            return (ss.width, ss.height)

        case .vector:
            var vv = CGVector(dx: lhs.0, dy: lhs.1)
            vv /= CGVector(dx: rhs.0, dy: rhs.1)
            return (vv.dx, vv.dy)
        }
    }

    func operate(_ operation: Operation, _ operandType: OperandType,
                 _ lhs: (CGFloat, CGFloat), _ rhs: (CGFloat, CGFloat)) -> (CGFloat, CGFloat) {
        switch operation {
        case .add: return operation_add(operandType, lhs, rhs)
        case .subtract: return operation_subtract(operandType, lhs, rhs)
        case .multiply: return operation_multiply(operandType, lhs, rhs)
        case .divide: return operation_divide(operandType, lhs, rhs)
        }
    }

    func testPassByReference_OpTuple() {
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
            TestEntry_PassByReference_OpTuple(.add, zero, (aa, bb), (aa, bb)),
            TestEntry_PassByReference_OpTuple(.add, (aa, bb), (cc, dd), (aa + cc, bb + dd)),
            TestEntry_PassByReference_OpTuple(.add, (dd, cc), (bb, aa), (dd + bb, cc + aa)),

            TestEntry_PassByReference_OpTuple(.subtract, zero, (aa, bb), (-aa, -bb)),
            TestEntry_PassByReference_OpTuple(.subtract, (aa, bb), (cc, dd), (aa - cc, bb - dd)),
            TestEntry_PassByReference_OpTuple(.subtract, (dd, cc), (bb, aa), (dd - bb, cc - aa)),

            TestEntry_PassByReference_OpTuple(.multiply, zero, (aa, bb), (0, 0)),
            TestEntry_PassByReference_OpTuple(.multiply, (aa, bb), (cc, dd), (aa * cc, bb * dd)),
            TestEntry_PassByReference_OpTuple(.multiply, (dd, cc), (bb, aa), (dd * bb, cc * aa)),

            TestEntry_PassByReference_OpTuple(.divide, zero, (aa, bb), (0, 0)),
            TestEntry_PassByReference_OpTuple(.divide, (aa, bb), (cc, dd), (aa / cc, bb / dd)),
            TestEntry_PassByReference_OpTuple(.divide, (dd, cc), (bb, aa), (dd / bb, cc / aa))
        ]

        testSetForPassByReference.forEach { testEntry in
            let lhsP = (testEntry.lhs.0, testEntry.lhs.1)
            let rhsP = (testEntry.rhs.0, testEntry.rhs.1)

            let lhsS = (testEntry.lhs.0, testEntry.lhs.1)
            let rhsS = (testEntry.rhs.0, testEntry.rhs.1)

            let lhsV = (testEntry.lhs.0, testEntry.lhs.1)
            let rhsV = (testEntry.rhs.0, testEntry.rhs.1)

            let pr = operate(testEntry.operation, .point, lhsP, rhsP)
            XCTAssertEqual(CGPoint(x: pr.0, y: pr.1), CGPoint(x: testEntry.result.0, y: testEntry.result.1))

            let sr = operate(testEntry.operation, .size, lhsS, rhsS)
            XCTAssertEqual(CGSize(width: sr.0, height: sr.1), CGSize(width: testEntry.result.0, height: testEntry.result.1))

            let vr = operate(testEntry.operation, .vector, lhsV, rhsV)
            XCTAssertEqual(CGVector(dx: vr.0, dy: vr.1), CGVector(dx: testEntry.result.0, dy: testEntry.result.1))
        }
    }
}
