//
//  StringTests.swift
//  XLFoundationSwiftKit
//
//  Created by mcousillas on 12/7/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import XCTest
@testable import XLSwiftKit

class StringTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // MARK: isValidAsEmail tests
    func testIsValidAsEmail() {
        let email = "ab@a.com"
        XCTAssert(email.isValidAsEmail())
    }

    func testInvalidEmailNoDot() {
        let email = "ab@a"
        XCTAssertFalse(email.isValidAsEmail())
    }

    func testInvalidEmailTwoAts() {
        let email = "ab@a@b.com"
        XCTAssertFalse(email.isValidAsEmail())
    }

    // MARK: isValidAsPhone tests
    func testIsValidAsPhone() {
        let phone = "999999999"
        XCTAssert(phone.isValidAsPhone())
    }

    func testIsValidAsPhoneWithLines() {
        let phone = "999-999-999"
        XCTAssert(phone.isValidAsPhone())
    }

    func testInvalidPhoneTooShort() {
        let phone = "9999999"
        XCTAssertFalse(phone.isValidAsPhone())
    }

    func testInvalidPhoneTooLong() {
        let phone = "1234567891234567"
        XCTAssertFalse(phone.isValidAsPhone())
    }

    func testInvalidPhoneChar() {
        let phone = "123.123123"
        XCTAssertFalse(phone.isValidAsPhone())
    }

    func testInvalidPhoneLetter() {
        let phone = "123A123123"
        XCTAssertFalse(phone.isValidAsPhone())
    }

    // MARK: isNumberString tests
    func testValidNumberString() {
        let number = "999999"
        XCTAssert(number.isNumberString())
    }

    func testInvalidNumberString() {
        let number = "9abc"
        XCTAssertFalse(number.isNumberString())
    }

    func testValidNumberWithLines() {
        let number = "99-9-9"
        XCTAssert(number.isNumberString())
    }

    // MARK: findFirstNumberInString tests
    func testFirstNumberFromString() {
        let string = "99999--absdas...--a-dakdsa99123"
        XCTAssertEqual(string.findFirstNumberInString(), "99999")
    }

    func testFirstNumberFromStringNil() {
        let string = "abscasdasd--=-=+++_asdad<>}}}"
        XCTAssertNil(string.findFirstNumberInString())
    }

    func testRenderedHeight() {
        let font = UIFont.systemFont(ofSize: 17)
        let testString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation"

        let lineHeight = CGFloat(20.287109)
        let round = roundTo(2)

        // Just one line
        let h1 = testString.renderedHeightWithFont(font, width: 2000)
        XCTAssertEqual(round(lineHeight), round(h1))

        // Two lines of text
        let h2 = testString.renderedHeightWithFont(font, width: 1000)
        XCTAssertEqual(round(lineHeight * 2), round(h2))

        // Many lines of text
        let h3 = testString.renderedHeightWithFont(font, width: 100)
        XCTAssertEqual(round(18 * lineHeight), round(h3))
    }

    fileprivate func roundTo(_ digits: Int) -> (_ value: CGFloat) -> CGFloat {
        let factor = CGFloat(pow(10.0, Double(digits)))
        return { (round($0 * factor) / factor) }
    }

    // MARK: Test first last name
    func testFirstLastName() {
        let string = "Sir Alex Ferguson"
        let name = string.getFirstAndLastName()
        XCTAssertNotNil(name)
        XCTAssertEqual(name?.0, "Sir Alex")
        XCTAssertEqual(name?.1, "Ferguson")
    }

    func testFirstLastNameEmpty() {
        let string = "Ferguson  "
        let name = string.getFirstAndLastName()
        XCTAssertNil(name)
    }

    // MARK: Test Parametrized String
    func testStringParameters() {
        let string = "Hey {0}, do you want to {1}?"
        let expected = "Hey dude, do you want to play tennis?"
        XCTAssert(string.parametrize("dude", "play tennis") == expected)
        XCTAssert(string.parametrize("dude", "play tennis", "will not show") == expected)
        XCTAssert(string.parametrize(withDictonary: [0: "dude", 1: "play tennis"]) == expected)
        XCTAssert(string.parametrize(withDictonary: [4: "will not show", 0: "dude", 1: "play tennis"]) == expected)
    }

    func testStringEmptyParameters() {
        var string = "Hey {0}, do you want to {1}?"
        XCTAssert(string.parametrize() == string)
        XCTAssert(string.parametrize(withDictonary: [:]) == string)
        XCTAssert(string.parametrize(withDictonary: [4: "will not show", 5: Date()]) == string)

        string = "No parameters"
        XCTAssert(string.parametrize(1, 2, 3, "hi!") == string)
        XCTAssert(string.parametrize(withDictonary: [-1: "nothing", 4: "will not show", 5: Date()]) == string)

    }

    func testStringConvertibleParameters() {
        var string = "It's been about {0} years now."
        var expected = "It's been about 3 years now."
        XCTAssert(string.parametrize(3) == expected)
        XCTAssert(string.parametrize(withDictonary: [0: 3]) == expected)

        let now = Date()
        string = "{1} > {0}?"
        expected = "2.3 > \(now)?"
        XCTAssert(string.parametrize(now, 2.3) == expected)
        XCTAssert(string.parametrize(withDictonary: [0: now, 1: 2.3]) == expected)
    }

}

// We need to actively conform to the ParametrizedString protocol
// in order to use the .parametrize(...) function.

extension String: ParametrizedString {

    public var parameterFormat: String {
        return "{i}"
    }

}
