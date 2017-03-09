//
//  GCDHelperTests.swift
//  XLFoundationSwiftKit
//
//  Created by Miguel Revetria on 12/7/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import XCTest

@testable import XLSwiftKit

class GCDHelperTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDelay() {
        let before = Date()
        GCDHelper.delay(0.5) {
            let delay = before.timeIntervalSinceNow
            XCTAssertEqual(delay, 0.5)
        }
    }

    func testRunOnMainThread() {
        GCDHelper.runOnBackgroundThread {
            GCDHelper.runOnMainThread {
                XCTAssertTrue(Thread.isMainThread)
            }
        }
    }

    func testRunOnBackgroundThread() {
        GCDHelper.runOnBackgroundThread {
            XCTAssertFalse(Thread.isMainThread)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
