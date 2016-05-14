//
//  ViewController.swift
//  CalculatorDuplication
//
//  Created by Xinyang Li on 5/13/16.
//  Copyright © 2016 Xinyang Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	private let DECIMAL_POINT = "."
	private var calculatorBrain = CalculatorBrain()
	private var isInMiddleOfTyping = false
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

	@IBOutlet private weak var display: UILabel!

	@IBAction private func touchedDigit(sender: UIButton) {

		let incomingDigit = sender.currentTitle!

		if !isInMiddleOfTyping {
			if incomingDigit == DECIMAL_POINT {
				display.text! += DECIMAL_POINT
			} else {
				display.text = incomingDigit
			}
			isInMiddleOfTyping = true
		} else {
			if incomingDigit == DECIMAL_POINT {
				for char in display.text!.characters {
					if char == Character(DECIMAL_POINT) {
						return
					}
				}
			}
			display.text! += incomingDigit
		}
	}

	@IBAction private func touchedOperation(sender: UIButton) {

		if isInMiddleOfTyping {
			calculatorBrain.setOperand(Double(display.text!)!)
			isInMiddleOfTyping = false
		}

		calculatorBrain.performOperation(sender.currentTitle!)

		let result = calculatorBrain.result
		if Double(Int(result)) == result {
			display.text = String(Int(result))
		} else {
			display.text = String(calculatorBrain.result)
		}
	}
}

