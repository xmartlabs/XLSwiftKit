import XCTest

extension TestOverload2D {

    struct TestEntry_PassByValue_OpTuple {
        let aResult: CGFloat
        let bResult: CGFloat

        let lhs: NTuple2
        let rhs: NTuple2

        let operation: (CGFloat, CGFloat) -> CGFloat

        init(
            _ lhs: NTuple2, _ operation: @escaping (CGFloat, CGFloat) -> CGFloat, _ rhs: NTuple2,
            _ aResult: CGFloat, _ bResult: CGFloat
            ) {
            self.lhs = lhs; self.rhs = rhs;
            self.operation = operation
            self.aResult = aResult; self.bResult = bResult
        }
    }

    func testPassByValue_OpTuple() {
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
            TestEntry_PassByValue_OpTuple((zero, zero), +, (a, b), zero + a, zero + b),
            TestEntry_PassByValue_OpTuple((a, b), +, (c, d), a + c, b + d),
            TestEntry_PassByValue_OpTuple((d, c), +, (b, a), d + b, c + a),

            TestEntry_PassByValue_OpTuple((zero, zero), -, (a, b), zero - a, zero - b),
            TestEntry_PassByValue_OpTuple((a, b), -, (c, d), a - c, b - d),
            TestEntry_PassByValue_OpTuple((d, c), -, (b, a), d - b, c - a),

            TestEntry_PassByValue_OpTuple((zero, zero), *, (a, b), zero * a, zero * b),
            TestEntry_PassByValue_OpTuple((a, b), *, (c, d), a * c, b * d),
            TestEntry_PassByValue_OpTuple((d, c), *, (b, a), d * b, c * a),

            TestEntry_PassByValue_OpTuple((zero, zero), /, (a, b), zero / a, zero / b),
            TestEntry_PassByValue_OpTuple((a, b), /, (c, d), a / c, b / d),
            TestEntry_PassByValue_OpTuple((d, c), /, (b, a), d / b, c / a),
        ]

        testSetForPassByValue.forEach { testEntry in
            let p = CGPoint(
                x: testEntry.operation(testEntry.lhs.0, testEntry.rhs.0),
                y: testEntry.operation(testEntry.lhs.1, testEntry.rhs.1)
            )

            let s = CGSize(
                width: testEntry.operation(testEntry.lhs.0, testEntry.rhs.0),
                height: testEntry.operation(testEntry.lhs.1, testEntry.rhs.1)
            )

            let v = CGVector(
                dx: testEntry.operation(testEntry.lhs.0, testEntry.rhs.0),
                dy: testEntry.operation(testEntry.lhs.1, testEntry.rhs.1)
            )

            XCTAssertEqual(p, CGPoint(x:    testEntry.aResult, y:      testEntry.bResult))
            XCTAssertEqual(s, CGSize(width: testEntry.aResult, height: testEntry.bResult))
            XCTAssertEqual(v, CGVector(dx:  testEntry.aResult, dy:     testEntry.bResult))
        }
    }
}
