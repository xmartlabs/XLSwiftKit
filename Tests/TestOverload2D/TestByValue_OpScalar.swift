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
        let aa = CGFloat.random(in: -1000...1000)
        let bb = CGFloat.random(in: -1000...1000)
        let ccc = CGFloat.random(in: -1000...1000)
        let dd = CGFloat.random(in: -1000...1000)
        let zero = CGFloat(0.0)

        continueAfterFailure = false
        XCTAssert(aa != 0 && bb != 0 && ccc != 0 && dd != 0,
                  "Run again; got aa zero random number, won't work for division")
        continueAfterFailure = true

        let testSetForPassByValue = [
            TestEntry_PassByValue_OpScalar((zero, zero), +, aa, aa, aa),
            TestEntry_PassByValue_OpScalar((aa, bb), +, ccc, aa + ccc, bb + ccc),
            TestEntry_PassByValue_OpScalar((dd, ccc), +, bb, dd + bb, ccc + bb),

            TestEntry_PassByValue_OpScalar((zero, zero), -, aa, -aa, -aa),
            TestEntry_PassByValue_OpScalar((aa, bb), -, ccc, aa - ccc, bb - ccc),
            TestEntry_PassByValue_OpScalar((dd, ccc), -, aa, dd - aa, ccc - aa),

            TestEntry_PassByValue_OpScalar((zero, zero), *, aa, 0, 0),
            TestEntry_PassByValue_OpScalar((aa, bb), *, ccc, aa * ccc, bb * ccc),
            TestEntry_PassByValue_OpScalar((dd, ccc), *, aa, dd * aa, ccc * aa),

            TestEntry_PassByValue_OpScalar((zero, zero), /, aa, 0, 0),
            TestEntry_PassByValue_OpScalar((aa, bb), /, ccc, aa / ccc, bb / ccc),
            TestEntry_PassByValue_OpScalar((dd, ccc), /, bb, dd / bb, ccc / bb)
        ]

        testSetForPassByValue.forEach { testEntry in
            let pp = CGPoint(
                x: testEntry.operation(testEntry.lhs.0, testEntry.rhs),
                y: testEntry.operation(testEntry.lhs.1, testEntry.rhs)
            )

            let ss = CGSize(
                width: testEntry.operation(testEntry.lhs.0, testEntry.rhs),
                height: testEntry.operation(testEntry.lhs.1, testEntry.rhs)
            )

            let vv = CGVector(
                dx: testEntry.operation(testEntry.lhs.0, testEntry.rhs),
                dy: testEntry.operation(testEntry.lhs.1, testEntry.rhs)
            )

            XCTAssertEqual(pp, CGPoint(x: testEntry.aResult, y: testEntry.bResult))
            XCTAssertEqual(ss, CGSize(width: testEntry.aResult, height: testEntry.bResult))
            XCTAssertEqual(vv, CGVector(dx: testEntry.aResult, dy: testEntry.bResult))
        }
    }
}
