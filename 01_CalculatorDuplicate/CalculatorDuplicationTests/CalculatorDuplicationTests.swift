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
        brain!.setOperand(10)
        brain!.performOperation("+")
        brain!.setOperand(10)
        XCTAssert(brain!.result == 20.0)
    }
    
    func testSubtraction() {
        brain!.setOperand(10)
        brain!.performOperation("-")
        brain!.setOperand(10)
        XCTAssert(brain!.result == 0.0)
    }
    
    func testDivision() {
        brain!.setOperand(10)
        brain!.performOperation("÷")
        brain!.setOperand(2)
        XCTAssert(brain!.result == 5.0)
    }
    
    func testMutiplication() {
        brain?.setOperand(10)
        brain?.performOperation("×")
        brain?.setOperand(10)
        XCTAssert(brain!.result == 100.0)
    }
}
