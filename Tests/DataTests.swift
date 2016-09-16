//
//  File.swift
//  XLSwiftKit
//
//  Created by Mathias Claassen on 9/16/16.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import XCTest
@testable import XLSwiftKit

class DataTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testIsOver18YearTrue() {
        let data = "{\"key\": \"value\"}".data(using: .utf8)

        XCTAssertNotNil(data?.toJSON())

        let wrongJson = "{\"key\": }".data(using: .utf8)
        XCTAssertNil(wrongJson?.toJSON())
    }
}
