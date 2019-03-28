import XCTest

extension TestOverload2D {

    func testHypoteneusesAndRandomizers() {
        let aa = CGPoint.random(in: CGFloat(-1000.0)..<CGFloat(1000.0))
        let bb = CGPoint.random(in: CGFloat(-1000.0)..<CGFloat(1000.0))
        let cc = CGSize.random(in: CGFloat(-1000.0)..<CGFloat(1000.0))
        let dd = CGVector.random(in: CGFloat(-1000.0)..<CGFloat(1000.0))

        let ccSquared = (bb.x - aa.x) * (bb.x - aa.x) + (bb.y - aa.y) * (bb.y - aa.y)
        let distanceAtoB = sqrt(ccSquared)
        let hypoteneuseC = sqrt(cc.width * cc.width + cc.height * cc.height)
        let magnitudeD = sqrt(dd.dx * dd.dx + dd.dy * dd.dy)

        XCTAssertEqual(magnitudeD, sqrt(dd.dx * dd.dx + dd.dy * dd.dy))
        XCTAssertEqual(CGVector(dx: 1.0, dy: 1.0).magnitude(), sqrt(2.0))
        XCTAssertEqual(CGVector(dx: 3.0, dy: 4.0).magnitude(), 5.0)

        XCTAssertEqual(hypoteneuseC, sqrt(cc.width * cc.width + cc.height * cc.height))
        XCTAssertEqual(
            CGSize(width: 1.0, height: 1.0).asPoint().distance(to: CGSize.zero.asPoint()), sqrt(2.0)
        )

        XCTAssertEqual(CGPoint(x: 3.0, y: 4.0).distance(to: CGSize.zero.asPoint()), 5)

        XCTAssertEqual(
            distanceAtoB,
            sqrt((bb.x - aa.x) * (bb.x - aa.x) + (bb.y - aa.y) * (bb.y - aa.y))
        )

        XCTAssertEqual(CGPoint(x: 1.0, y: 1.0).distance(to: CGPoint.zero), sqrt(2.0))
        XCTAssertEqual(CGPoint(x: 3.0, y: 4.0).distance(to: CGPoint.zero), 5)
    }

    func testUnaryMinus() {
        let aa = CGFloat.random(in: -1000...1000)
        let bb = CGFloat.random(in: -1000...1000)
        let cc = CGFloat.random(in: -1000...1000)
        let dd = CGFloat.random(in: -1000...1000)

        continueAfterFailure = false
        XCTAssert(aa != 0 && bb != 0 && cc != 0 && dd != 0,
                  "Run again; got aa zero random number, won't work for division")
        continueAfterFailure = true

        XCTAssertEqual(-CGPoint(x: aa, y: bb), CGPoint(x: -aa, y: -bb))
        XCTAssertEqual(-CGSize(width: bb, height: cc), CGSize(width: -bb, height: -cc))
        XCTAssertEqual(-CGVector(dx: cc, dy: dd), CGVector(dx: -cc, dy: -dd))
    }

    func testAsOther() {
        let aa = CGFloat.random(in: -1000...1000)
        let bb = CGFloat.random(in: -1000...1000)
        let cc = CGFloat.random(in: -1000...1000)
        let dd = CGFloat.random(in: -1000...1000)

        continueAfterFailure = false
        XCTAssert(aa != 0 && bb != 0 && cc != 0 && dd != 0,
                  "Run again; got aa zero random number, won't work for division")
        continueAfterFailure = true

        XCTAssertEqual(CGPoint(x: aa, y: bb), CGSize(width: aa, height: bb).asPoint())
        XCTAssertEqual(CGPoint(x: aa, y: bb), CGVector(dx: aa, dy: bb).asPoint())

        XCTAssertEqual(CGSize(width: bb, height: cc), CGPoint(x: bb, y: cc).asSize())
        XCTAssertEqual(CGSize(width: bb, height: cc), CGVector(dx: bb, dy: cc).asSize())

        XCTAssertEqual(CGVector(dx: cc, dy: dd), CGPoint(x: cc, y: dd).asVector())
        XCTAssertEqual(CGVector(dx: cc, dy: dd), CGSize(width: cc, height: dd).asVector())
    }

    func testCombinations() {
        let aa = CGFloat.random(in: -1000...1000)
        let bb = CGFloat.random(in: -1000...1000)
        let cc = CGFloat.random(in: -1000...1000)
        let dd = CGFloat.random(in: -1000...1000)

        let pp = CGPoint(x: aa, y: bb) +
            2 * CGVector(dx: bb, dy: cc).asPoint() -
            (3 * CGSize(width: cc, height: dd)).asPoint()

        XCTAssertEqual(pp, CGPoint(x: aa + 2 * bb - 3 * cc, y: bb + 2 * cc - 3 * dd))

        let ss = CGSize(width: aa, height: bb) +
            4 * CGVector(dx: bb, dy: cc).asSize() -
            (5 * CGPoint(x: cc, y: dd)).asSize()

        XCTAssertEqual(ss, CGSize(width: aa + 4 * bb - 5 * cc, height: bb + 4 * cc - 5 * dd))

        let vv = CGVector(dx: aa, dy: bb) +
            6 * CGSize(width: bb, height: cc).asVector() -
            (7 * CGPoint(x: cc, y: dd)).asVector()

        XCTAssertEqual(vv, CGVector(dx: aa + 6 * bb - 7 * cc, dy: bb + 6 * cc - 7 * dd))

    }

    func testOtherWithCombinations() {
        let aa = CGFloat.random(in: -1000...1000)
        let bb = CGFloat.random(in: -1000...1000)
        let cc = CGFloat.random(in: -1000...1000)
        let dd = CGFloat.random(in: -1000...1000)

        var pp = CGPoint(x: dd, y: aa).asVector().asSize().asPoint()
        pp *= CGPoint(x: aa, y: bb).asVector().asPoint().asSize().asPoint()
        pp /= CGPoint(x: bb, y: cc).asSize().asPoint().asSize().asPoint()
        pp += CGPoint(x: cc, y: dd).asSize().asVector().asPoint().asVector().asSize().asPoint()

        XCTAssertEqual(pp, CGPoint(x: ((dd * aa) / bb) + cc, y: ((aa * bb) / cc) + dd))

        var ss = CGSize(width: dd, height: aa).asVector().asPoint().asSize()
        ss /= CGSize(width: aa, height: bb).asVector().asPoint().asVector().asSize()
        ss += CGSize(width: bb, height: cc).asPoint().asVector().asPoint().asSize()
        ss *= CGSize(width: cc, height: dd).asSize().asVector().asSize().asPoint().asVector().asSize()

        XCTAssertEqual(ss, CGSize(width: ((dd / aa) + bb) * cc, height: ((aa / bb) + cc) * dd))

        var vv = CGVector(dx: dd, dy: aa).asSize().asPoint().asVector()
        vv += CGVector(dx: aa, dy: bb).asPoint().asVector().asSize().asVector()
        vv *= CGVector(dx: bb, dy: cc).asPoint().asVector().asPoint().asVector()
        vv /= CGVector(dx: cc, dy: dd).asSize().asVector().asPoint().asVector().asSize().asPoint().asVector()

        XCTAssertEqual(vv, CGVector(dx: ((dd + aa) * bb) / cc, dy: ((aa + bb) * cc) / dd))
    }
}
