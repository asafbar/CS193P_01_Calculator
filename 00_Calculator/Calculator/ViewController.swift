//
//  ViewController.swift
//  Calculator
//
//  Created by Xinyang Li on 5/7/16.
//  Copyright © 2016 Xinyang Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	private var isInMiddleOfTyping = false
	private var brain = CalculatorBrain()

	// Computed property
	private var displayValue: Double {
		get {
			// Crash if display.text is not convertable
			return Double(display.text!)!
		}
		set {
			display.text = String(newValue)
		}
	}

	@IBOutlet private weak var display: UILabel!

	@IBAction private func touchDigit(sender: UIButton) {
		let digit = sender.currentTitle!

		if !isInMiddleOfTyping {
			display.text = digit
		} else {
			display.text! += digit
		}

		isInMiddleOfTyping = true
	}

	@IBAction private func performOperation(sender: UIButton) {

		if isInMiddleOfTyping {
			brain.setOperand(displayValue)
			isInMiddleOfTyping = false
		}

		if let mathematicalSymbol = sender.currentTitle {
			brain.performOperation(mathematicalSymbol)
		}
		displayValue = brain.result
	}
}

