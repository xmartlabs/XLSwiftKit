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
            self.lhs = lhs; self.rhs = rhs
            self.operation = operation
            self.aResult = aResult; self.bResult = bResult
        }
    }

    func testPassByValue_OpTuple() {
        let aa = CGFloat.random(in: -1000...1000)
        let bb = CGFloat.random(in: -1000...1000)
        let cc = CGFloat.random(in: -1000...1000)
        let dd = CGFloat.random(in: -1000...1000)
        let zero = CGFloat(0.0)

        continueAfterFailure = false
        XCTAssert(aa != 0 && bb != 0 && cc != 0 && dd != 0,
                  "Run again; got aa zero random number, won't work for division")
        continueAfterFailure = true

        let testSetForPassByValue = [
            TestEntry_PassByValue_OpTuple((zero, zero), +, (aa, bb), zero + aa, zero + bb),
            TestEntry_PassByValue_OpTuple((aa, bb), +, (cc, dd), aa + cc, bb + dd),
            TestEntry_PassByValue_OpTuple((dd, cc), +, (bb, aa), dd + bb, cc + aa),

            TestEntry_PassByValue_OpTuple((zero, zero), -, (aa, bb), zero - aa, zero - bb),
            TestEntry_PassByValue_OpTuple((aa, bb), -, (cc, dd), aa - cc, bb - dd),
            TestEntry_PassByValue_OpTuple((dd, cc), -, (bb, aa), dd - bb, cc - aa),

            TestEntry_PassByValue_OpTuple((zero, zero), *, (aa, bb), zero * aa, zero * bb),
            TestEntry_PassByValue_OpTuple((aa, bb), *, (cc, dd), aa * cc, bb * dd),
            TestEntry_PassByValue_OpTuple((dd, cc), *, (bb, aa), dd * bb, cc * aa),

            TestEntry_PassByValue_OpTuple((zero, zero), /, (aa, bb), zero / aa, zero / bb),
            TestEntry_PassByValue_OpTuple((aa, bb), /, (cc, dd), aa / cc, bb / dd),
            TestEntry_PassByValue_OpTuple((dd, cc), /, (bb, aa), dd / bb, cc / aa)
        ]

        testSetForPassByValue.forEach { testEntry in
            let pp = CGPoint(
                x: testEntry.operation(testEntry.lhs.0, testEntry.rhs.0),
                y: testEntry.operation(testEntry.lhs.1, testEntry.rhs.1)
            )

            let ss = CGSize(
                width: testEntry.operation(testEntry.lhs.0, testEntry.rhs.0),
                height: testEntry.operation(testEntry.lhs.1, testEntry.rhs.1)
            )

            let vv = CGVector(
                dx: testEntry.operation(testEntry.lhs.0, testEntry.rhs.0),
                dy: testEntry.operation(testEntry.lhs.1, testEntry.rhs.1)
            )

            XCTAssertEqual(pp, CGPoint(x: testEntry.aResult, y: testEntry.bResult))
            XCTAssertEqual(ss, CGSize(width: testEntry.aResult, height: testEntry.bResult))
            XCTAssertEqual(vv, CGVector(dx: testEntry.aResult, dy: testEntry.bResult))
        }
    }
}
