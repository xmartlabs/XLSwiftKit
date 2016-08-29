//
//  UIColorTests.swift
//  XLFoundationSwiftKit
//
//  Created by mcousillas on 12/7/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import XCTest
@testable import XLSwiftKit

class UIColorTests: XCTestCase {

    func testRGBInit() {
        let color = UIColor(red: 250, green: 250, blue: 250)
        XCTAssertNotNil(color)
    }

    func testNetHExInit() {
        let color = UIColor(netHex: 950)
        XCTAssertNotNil(color)
    }

}
