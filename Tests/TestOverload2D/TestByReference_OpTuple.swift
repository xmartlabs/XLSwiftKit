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

    func operate(_ operation: Operation, _ operandType: OperandType,
                 _ lhs: (CGFloat, CGFloat), _ rhs: (CGFloat, CGFloat)
        )

        -> (CGFloat, CGFloat) {
            switch operation {
            case .add:
                switch operandType {
                case .point:
                    var p = CGPoint(x: lhs.0, y: lhs.1)
                    p += CGPoint(x: rhs.0, y: rhs.1)
                    return (p.x, p.y)

                case .size:
                    var s = CGSize(width: lhs.0, height: lhs.1)
                    s += CGSize(width: rhs.0, height: rhs.1)
                    return (s.width, s.height)

                case .vector:
                    var v = CGVector(dx: lhs.0, dy: lhs.1)
                    v += CGVector(dx: rhs.0, dy: rhs.1)
                    return (v.dx, v.dy)
                }

            case .subtract:
                switch operandType {
                case .point:
                    var p = CGPoint(x: lhs.0, y: lhs.1)
                    p -= CGPoint(x: rhs.0, y: rhs.1)
                    return (p.x, p.y)

                case .size:
                    var s = CGSize(width: lhs.0, height: lhs.1)
                    s -= CGSize(width: rhs.0, height: rhs.1)
                    return (s.width, s.height)

                case .vector:
                    var v = CGVector(dx: lhs.0, dy: lhs.1)
                    v -= CGVector(dx: rhs.0, dy: rhs.1)
                    return (v.dx, v.dy)
                }

            case .multiply:
                switch operandType {
                case .point:
                    var p = CGPoint(x: lhs.0, y: lhs.1)
                    p *= CGPoint(x: rhs.0, y: rhs.1)
                    return (p.x, p.y)

                case .size:
                    var s = CGSize(width: lhs.0, height: lhs.1)
                    s *= CGSize(width: rhs.0, height: rhs.1)
                    return (s.width, s.height)

                case .vector:
                    var v = CGVector(dx: lhs.0, dy: lhs.1)
                    v *= CGVector(dx: rhs.0, dy: rhs.1)
                    return (v.dx, v.dy)
                }

            case .divide:
                switch operandType {
                case .point:
                    var p = CGPoint(x: lhs.0, y: lhs.1)
                    p /= CGPoint(x: rhs.0, y: rhs.1)
                    return (p.x, p.y)

                case .size:
                    var s = CGSize(width: lhs.0, height: lhs.1)
                    s /= CGSize(width: rhs.0, height: rhs.1)
                    return (s.width, s.height)

                case .vector:
                    var v = CGVector(dx: lhs.0, dy: lhs.1)
                    v /= CGVector(dx: rhs.0, dy: rhs.1)
                    return (v.dx, v.dy)
                }
            }
    }

    func testPassByReference_OpTuple() {
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
            TestEntry_PassByReference_OpTuple(.add, zero, (a, b), (a, b)),
            TestEntry_PassByReference_OpTuple(.add, (a, b), (c, d), (a + c, b + d)),
            TestEntry_PassByReference_OpTuple(.add, (d, c), (b, a), (d + b, c + a)),

            TestEntry_PassByReference_OpTuple(.subtract, zero, (a, b), (-a, -b)),
            TestEntry_PassByReference_OpTuple(.subtract, (a, b), (c, d), (a - c, b - d)),
            TestEntry_PassByReference_OpTuple(.subtract, (d, c), (b, a), (d - b, c - a)),

            TestEntry_PassByReference_OpTuple(.multiply, zero, (a, b), (0, 0)),
            TestEntry_PassByReference_OpTuple(.multiply, (a, b), (c, d), (a * c, b * d)),
            TestEntry_PassByReference_OpTuple(.multiply, (d, c), (b, a), (d * b, c * a)),

            TestEntry_PassByReference_OpTuple(.divide, zero, (a, b), (0, 0)),
            TestEntry_PassByReference_OpTuple(.divide, (a, b), (c, d), (a / c, b / d)),
            TestEntry_PassByReference_OpTuple(.divide, (d, c), (b, a), (d / b, c / a)),
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
