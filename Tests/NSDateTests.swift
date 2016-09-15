//
//  NSDateTests.swift
//  XLFoundationSwiftKit
//
//  Created by mcousillas on 12/7/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import XCTest
@testable import XLSwiftKit

class NSDateTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testIsOver18YearTrue() {
        var dateComps = DateComponents()
        dateComps.year = 1994
        dateComps.month = 8
        dateComps.day = 6
        let date = Calendar.current.date(from: dateComps)!
        XCTAssert(date.isOver18Years())
    }

    func testIsOver18YearFalse() {
        var dateComps = DateComponents()
        dateComps.year = 2014
        dateComps.month = 8
        dateComps.day = 6
        let date = Calendar.current.date(from: dateComps)!
        XCTAssert(!date.isOver18Years())
    }

    func testYearString() {
        var dateComps = DateComponents()
        dateComps.year = 1994
        dateComps.month = 8
        dateComps.day = 6
        let date = Calendar.current.date(from: dateComps)!
        XCTAssertEqual(date.year(), "1994")
    }

    func testMonthNameString() {
        var dateComps = DateComponents()
        dateComps.year = 1994
        dateComps.month = 8
        dateComps.day = 6
        let date = Calendar.current.date(from: dateComps)!
        XCTAssertEqual(date.monthName(), "August")
    }

    func testDayString() {
        var dateComps = DateComponents()
        dateComps.year = 1994
        dateComps.month = 8
        dateComps.day = 6
        let date = Calendar.current.date(from: dateComps)!
        XCTAssertEqual(date.day(), "06")
    }

}
