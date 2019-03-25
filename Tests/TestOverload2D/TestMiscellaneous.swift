import XCTest

extension TestOverload2D {

    func testUnaryMinus() {
        let a = CGFloat.random(in: -1000...1000)
        let b = CGFloat.random(in: -1000...1000)
        let c = CGFloat.random(in: -1000...1000)
        let d = CGFloat.random(in: -1000...1000)

        continueAfterFailure = false
        XCTAssert(a != 0 && b != 0 && c != 0 && d != 0,
                  "Run again; got a zero random number, won't work for division")
        continueAfterFailure = true

        XCTAssertEqual(-CGPoint(x: a, y: b), CGPoint(x: -a, y: -b))
        XCTAssertEqual(-CGSize(width: b, height: c), CGSize(width: -b, height: -c))
        XCTAssertEqual(-CGVector(dx: c, dy: d), CGVector(dx: -c, dy: -d))
    }

    func testAsOther() {
        let a = CGFloat.random(in: -1000...1000)
        let b = CGFloat.random(in: -1000...1000)
        let c = CGFloat.random(in: -1000...1000)
        let d = CGFloat.random(in: -1000...1000)

        continueAfterFailure = false
        XCTAssert(a != 0 && b != 0 && c != 0 && d != 0,
                  "Run again; got a zero random number, won't work for division")
        continueAfterFailure = true

        XCTAssertEqual(CGPoint(x: a, y: b), CGSize(width: a, height: b).asPoint())
        XCTAssertEqual(CGPoint(x: a, y: b), CGVector(dx: a, dy: b).asPoint())

        XCTAssertEqual(CGSize(width: b, height: c), CGPoint(x: b, y: c).asSize())
        XCTAssertEqual(CGSize(width: b, height: c), CGVector(dx: b, dy: c).asSize())

        XCTAssertEqual(CGVector(dx: c, dy: d), CGPoint(x: c, y: d).asVector())
        XCTAssertEqual(CGVector(dx: c, dy: d), CGSize(width: c, height: d).asVector())
    }

    func testCombinations() {
        let a = CGFloat.random(in: -1000...1000)
        let b = CGFloat.random(in: -1000...1000)
        let c = CGFloat.random(in: -1000...1000)
        let d = CGFloat.random(in: -1000...1000)

        let p = CGPoint(x: a, y: b) +
            2 * CGVector(dx: b, dy: c).asPoint() -
            (3 * CGSize(width: c, height: d)).asPoint()

        XCTAssertEqual(p, CGPoint(x: a + 2 * b - 3 * c, y: b + 2 * c - 3 * d))

        let s = CGSize(width: a, height: b) +
            4 * CGVector(dx: b, dy: c).asSize() -
            (5 * CGPoint(x: c, y: d)).asSize()

        XCTAssertEqual(s, CGSize(width: a + 4 * b - 5 * c, height: b + 4 * c - 5 * d))

        let v = CGVector(dx: a, dy: b) +
            6 * CGSize(width: b, height: c).asVector() -
            (7 * CGPoint(x: c, y: d)).asVector()

        XCTAssertEqual(v, CGVector(dx: a + 6 * b - 7 * c, dy: b + 6 * c - 7 * d))

    }

    func testOtherWithCombinations() {
        let a = CGFloat.random(in: -1000...1000)
        let b = CGFloat.random(in: -1000...1000)
        let c = CGFloat.random(in: -1000...1000)
        let d = CGFloat.random(in: -1000...1000)

        var p = CGPoint(x: d, y: a).asVector().asSize().asPoint()
        p *= CGPoint(x: a, y: b).asVector().asPoint().asSize().asPoint()
        p /= CGPoint(x: b, y: c).asSize().asPoint().asSize().asPoint()
        p += CGPoint(x: c, y: d).asSize().asVector().asPoint().asVector().asSize().asPoint()

        XCTAssertEqual(p, CGPoint(x: ((d * a) / b) + c, y: ((a * b) / c) + d))

        var s = CGSize(width: d, height: a).asVector().asPoint().asSize()
        s /= CGSize(width: a, height: b).asVector().asPoint().asVector().asSize()
        s += CGSize(width: b, height: c).asPoint().asVector().asPoint().asSize()
        s *= CGSize(width: c, height: d).asSize().asVector().asSize().asPoint().asVector().asSize()

        XCTAssertEqual(s, CGSize(width: ((d / a) + b) * c, height: ((a / b) + c) * d))

        var v = CGVector(dx: d, dy: a).asSize().asPoint().asVector()
        v += CGVector(dx: a, dy: b).asPoint().asVector().asSize().asVector()
        v *= CGVector(dx: b, dy: c).asPoint().asVector().asPoint().asVector()
        v /= CGVector(dx: c, dy: d).asSize().asVector().asPoint().asVector().asSize().asPoint().asVector()

        XCTAssertEqual(v, CGVector(dx: ((d + a) * b) / c, dy: ((a + b) * c) / d))
    }
}
