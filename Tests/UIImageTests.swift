//
//  UIImageTests.swift
//  XLFoundationSwiftKit
//
//  Created by Miguel Revetria on 12/7/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import XCTest

@testable import XLSwiftKit

class UIImageTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testImageWithColor() {
        let testColor = UIColor(red: 0.25, green: 0.5, blue: 0.13, alpha: 1.0)
        let image = UIImage.imageWithColor(testColor, size: CGSize(width: 2, height: 2))
        XCTAssertEqual(image.size.width, 2)
        XCTAssertEqual(image.size.height, 2)

        let pixelData = (image.cgImage)?.dataProvider?.data
        let data = CFDataGetBytePtr(pixelData)

        for pixel in stride(from: 0, to: Int(image.size.width * image.size.height), by: 4) {
            let blue = CGFloat((data?[pixel + 0])!),
            green = CGFloat((data?[pixel + 1])!),
            red = CGFloat((data?[pixel + 2])!)

            let maxValue = CGFloat(255)
            let round = roundTo(2)
            let imageColor = UIColor(red: round(red / maxValue), green: round(green / maxValue), blue: round(blue / maxValue), alpha: 1.0)
            XCTAssertEqual(testColor, imageColor)
        }
    }

    func testImageWithView() {
        let label = UILabel()
        label.text = "testing"
        label.sizeToFit()

        let image = UIImage.imageWithView(label)
        let scale = UIScreen.main.scale
        XCTAssertEqual(label.frame.width, CGFloat(image.size.width / scale))
        XCTAssertEqual(label.frame.height, CGFloat(image.size.height / scale))
    }

    func testImageWithImage() {
        let image = UIImage.imageWithColor(.red, size: CGSize(width: 128, height: 128))
        let scaledImage = image.imageScaledToSize(CGSize(width: 32, height: 64))
        let scale = UIScreen.main.scale

        XCTAssertEqual(scaledImage.size.width, 32 * scale)
        XCTAssertEqual(scaledImage.size.height, 64 * scale)

        let scaledImage2 = UIImage.imageWithImage(image, scaledToSize: CGSize(width: 256, height: 256))

        XCTAssertEqual(scaledImage2.size.width, 256 * scale)
        XCTAssertEqual(scaledImage2.size.height, 256 * scale)
    }

    func testSaveToCameraRoll() {
        let image = UIImage.imageWithColor(.red)
        image.saveToCameraRoll()
        XCTAssertTrue(true)
        image.saveToCameraRoll { _ in }
        XCTAssertTrue(true)
    }

    fileprivate func roundTo(_ digits: Int) -> (_ value: CGFloat) -> CGFloat {
        let factor = CGFloat(pow(10.0, Double(digits)))
        return { (round($0 * factor) / factor) }
    }

}
