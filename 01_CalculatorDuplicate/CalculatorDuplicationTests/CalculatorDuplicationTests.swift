//
//  CalculatorDuplicationTests.swift
//  CalculatorDuplicationTests
//
//  Created by Xinyang Li on 5/15/16.
//  Copyright © 2016 Xinyang Li. All rights reserved.
//

import XCTest

@testable import CalculatorDuplication

class CalculatorDuplicationTests: XCTestCase {
    
    var brain: CalculatorBrain?
    
    override func setUp() {
        super.setUp()
        brain = CalculatorBrain()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddition() {
        XCTAssert(1 == 1)
    }
    
    func testSubtraction() {
    }
    
    func testDivision() {
    }
    
    func testMutiplication() {
    }
}
