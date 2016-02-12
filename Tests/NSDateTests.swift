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
        let dateComps = NSDateComponents()
        dateComps.year = 1994
        dateComps.month = 8
        dateComps.day = 6
        let date = NSCalendar.currentCalendar().dateFromComponents(dateComps)!
        XCTAssert(date.isOver18Years())
    }
    
    func testIsOver18YearFalse() {
        let dateComps = NSDateComponents()
        dateComps.year = 2014
        dateComps.month = 8
        dateComps.day = 6
        let date = NSCalendar.currentCalendar().dateFromComponents(dateComps)!
        XCTAssert(!date.isOver18Years())
    }
    
    func testISO8601DateString() {
        let dateComps = NSDateComponents()
        dateComps.year = 1994
        dateComps.month = 8
        dateComps.day = 6
        let date = NSCalendar.currentCalendar().dateFromComponents(dateComps)!
        XCTAssertEqual(date.ISO8601DateString(), "1994-08-06")
    }
    
    func testISO8601String() {
        let dateComps = NSDateComponents()
        dateComps.year = 1994
        dateComps.month = 8
        dateComps.day = 6
        dateComps.hour = 12
        dateComps.minute = 32
        dateComps.second = 15
        dateComps.timeZone = NSTimeZone(forSecondsFromGMT: -3 * 60 * 60)
        let date = NSCalendar.currentCalendar().dateFromComponents(dateComps)!
        let dateString = date.ISO8601String()
        XCTAssertEqual(dateString, "1994-08-06T12:32:15.000-0300")
    }
    
    func testYearString() {
        let dateComps = NSDateComponents()
        dateComps.year = 1994
        dateComps.month = 8
        dateComps.day = 6
        let date = NSCalendar.currentCalendar().dateFromComponents(dateComps)!
        XCTAssertEqual(date.year(), "1994")
    }

    func testMonthNameString() {
        let dateComps = NSDateComponents()
        dateComps.year = 1994
        dateComps.month = 8
        dateComps.day = 6
        let date = NSCalendar.currentCalendar().dateFromComponents(dateComps)!
        XCTAssertEqual(date.monthName(), "August")
    }
    
    func testDayString() {
        let dateComps = NSDateComponents()
        dateComps.year = 1994
        dateComps.month = 8
        dateComps.day = 6
        let date = NSCalendar.currentCalendar().dateFromComponents(dateComps)!
        XCTAssertEqual(date.day(), "06")
    }
}
