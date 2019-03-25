import XCTest

extension TestOverload2D {

    struct TestEntry_PassByValue_OpScalar {
        let aResult: CGFloat
        let bResult: CGFloat

        let lhs: NTuple2
        let rhs: CGFloat

        let operation: (CGFloat, CGFloat) -> CGFloat

        init(
            _ lhs: NTuple2, _ operation: @escaping (CGFloat, CGFloat) -> CGFloat,
            _ rhs: CGFloat, _ aResult: CGFloat, _ bResult: CGFloat
            ) {
            self.lhs = lhs; self.rhs = rhs; self.operation = operation
            self.aResult = aResult; self.bResult = bResult
        }
    }

    func testPassByValue_OpScalar() {
        let a = CGFloat.random(in: -1000...1000)
        let b = CGFloat.random(in: -1000...1000)
        let c = CGFloat.random(in: -1000...1000)
        let d = CGFloat.random(in: -1000...1000)
        let zero = CGFloat(0.0)

        continueAfterFailure = false
        XCTAssert(a != 0 && b != 0 && c != 0 && d != 0,
                  "Run again; got a zero random number, won't work for division")
        continueAfterFailure = true

        let testSetForPassByValue = [
            TestEntry_PassByValue_OpScalar((zero, zero), +, a, a, a),
            TestEntry_PassByValue_OpScalar((a, b), +, c, a + c, b + c),
            TestEntry_PassByValue_OpScalar((d, c), +, b, d + b, c + b),

            TestEntry_PassByValue_OpScalar((zero, zero), -, a, -a, -a),
            TestEntry_PassByValue_OpScalar((a, b), -, c, a - c, b - c),
            TestEntry_PassByValue_OpScalar((d, c), -, a, d - a, c - a),

            TestEntry_PassByValue_OpScalar((zero, zero), *, a, 0, 0),
            TestEntry_PassByValue_OpScalar((a, b), *, c, a * c, b * c),
            TestEntry_PassByValue_OpScalar((d, c), *, a, d * a, c * a),

            TestEntry_PassByValue_OpScalar((zero, zero), /, a, 0, 0),
            TestEntry_PassByValue_OpScalar((a, b), /, c, a / c, b / c),
            TestEntry_PassByValue_OpScalar((d, c), /, b, d / b, c / b)
        ]

        testSetForPassByValue.forEach { testEntry in
            let p = CGPoint(
                x: testEntry.operation(testEntry.lhs.0, testEntry.rhs),
                y: testEntry.operation(testEntry.lhs.1, testEntry.rhs)
            )

            let s = CGSize(
                width: testEntry.operation(testEntry.lhs.0, testEntry.rhs),
                height: testEntry.operation(testEntry.lhs.1, testEntry.rhs)
            )

            let v = CGVector(
                dx: testEntry.operation(testEntry.lhs.0, testEntry.rhs),
                dy: testEntry.operation(testEntry.lhs.1, testEntry.rhs)
            )

            XCTAssertEqual(p, CGPoint(x:    testEntry.aResult, y:      testEntry.bResult))
            XCTAssertEqual(s, CGSize(width: testEntry.aResult, height: testEntry.bResult))
            XCTAssertEqual(v, CGVector(dx:  testEntry.aResult, dy:     testEntry.bResult))
        }
    }
}
