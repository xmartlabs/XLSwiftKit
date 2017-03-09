//
//  DictionaryTests.swift
//  XLFoundationSwiftKit
//
//  Created by mcousillas on 12/7/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import XCTest
@testable import XLSwiftKit

class DictionaryTests: XCTestCase {

    func testMerge() {
        var dict1 = ["a": "1", "b": "2", "c": "3"]
        let dict2 = ["a": "0", "b": "8", "c": "9", "d": "4"]
        dict1.merge(dict2)
        XCTAssert(dict1["a"] == "0" && dict1["b"] == "8" && dict1["c"] == "9" && dict1["d"] == "4")
    }

    func testMergeWithEmptyDict() {
        var dict1 = ["a": "1", "b": "2", "c": "3"]
        let dict2 = [String: String]()
        dict1.merge(dict2)
        XCTAssert(dict1["a"] == "1" && dict1["b"] == "2" && dict1["c"] == "3")
    }

    func testMergeToEmptyDict() {
        var dict1 = [String: String]()
        let dict2 = ["a": "0", "b": "8", "c": "9", "d": "4"]
        dict1.merge(dict2)
        XCTAssert(dict1["a"] == "0" && dict1["b"] == "8" && dict1["c"] == "9" && dict1["d"] == "4")
    }

    func testMergeTwoEmpty() {
        var dict1 = [String: String] ()
        dict1.merge([String: String]())
        XCTAssert(dict1.isEmpty)
    }

}
