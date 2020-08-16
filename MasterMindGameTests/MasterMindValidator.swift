//
//  MasterMindValidator.swift
//  MasterMindGameTests
//
//  Created by Nikhil on 16/08/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import XCTest
@testable import MasterMindGame

class MasterMindValidator: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testGenerateRandomString() {
        let length = 4
        let textValidator = TextValidateViewController()
        let randomString = textValidator.generateRandomString(length: 4)
        XCTAssertEqual(randomString.count, length)
        XCTAssert(randomString.count == 4)
    }
    func testGenerateColour() {
        let textValidator = TextValidateViewController()
        let greenColour: UIColor = textValidator.validateAndSetBackgroundColour(tag: 0, text: "H", randomString: "HELO")
        let orangeColour: UIColor = textValidator.validateAndSetBackgroundColour(tag: 2, text: "E", randomString: "HELO")
        let redColour: UIColor = textValidator.validateAndSetBackgroundColour(tag: 0, text: "I", randomString: "HELO")
        XCTAssertEqual(greenColour, UIColor.green)
        XCTAssertEqual(orangeColour, UIColor.orange)
        XCTAssertEqual(redColour, UIColor.red)
    }
}
