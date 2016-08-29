//
//  NumberTests.swift
//  XLFoundationSwiftKit
//
//  Created by Miguel Revetria on 8/12/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import XCTest

class NumberTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDoubelToCurrency() {
        let value = 11.23124123
        XCTAssertEqual("$11.23", value.currencyString())
    }

    func testIntToCurrency() {
        let value = 11
        XCTAssertEqual("$11.00", value.currencyString())
    }

}
