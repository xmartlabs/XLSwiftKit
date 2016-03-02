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
    
    //MARK: isValidAsEmail tests
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
    
    //MARK: isValidAsPhone tests
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
    
    //MARK: isNumberString tests
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
    
    //MARK: findFirstNumberInString tests
    func testFirstNumberFromString() {
        let string = "99999--absdas...--a-dakdsa99123"
        XCTAssertEqual(string.findFirstNumberInString(), "99999")
    }
    
    func testFirstNumberFromStringNil() {
        let string = "abscasdasd--=-=+++_asdad<>}}}"
        XCTAssertNil(string.findFirstNumberInString())
    }
    
    //MARK: ISO8601Date tests
    func testISO8601Date() {
        let string = "2008-09-22T14:01:54.47Z"
        XCTAssertNotNil(string.ISO8601Date())
    }
    
    func testNilISO8601Date() {
        let string = "2014-08-0600:00"
        XCTAssertNil(string.ISO8601Date())
    }
    
    func testRenderedHeight() {
        let font = UIFont.systemFontOfSize(17)
        let testString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation"
        
        let lineHeight = CGFloat(20.287109)
        let round = roundTo(2)
        
        // Just one line
        let h1 = testString.renderedHeightWithFont(font, width: 2000)
        XCTAssertEqual(round(value: lineHeight), round(value: h1))
        
        // Two lines of text
        let h2 = testString.renderedHeightWithFont(font, width: 1000)
        XCTAssertEqual(round(value: lineHeight * 2), round(value: h2))
        
        // Many lines of text
        let h3 = testString.renderedHeightWithFont(font, width: 100)
        XCTAssertEqual(round(value: 18 * lineHeight), round(value: h3))
    }
    
    private func roundTo(digits: Int)(value: CGFloat) -> CGFloat {
        let factor = CGFloat(pow(10.0, Double(digits)))
        return (round(value * factor) / factor)
    }
    
    //MARK: Test first last name 
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
}
