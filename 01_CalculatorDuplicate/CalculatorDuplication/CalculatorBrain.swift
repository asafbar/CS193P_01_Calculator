//
//  calculatorBrain.swift
//  CalculatorDuplication
//
//  Created by Xinyang Li on 5/13/16.
//  Copyright © 2016 Xinyang Li. All rights reserved.
//

import Foundation

extension String {
	func replace(target: String, withString: String) -> String {
		return self.stringByReplacingOccurrencesOfString(target, withString: withString,
			options: NSStringCompareOptions.LiteralSearch,
			range: nil)
	}
}

class CalculatorBrain {
	// MARK: - Private
	private var accumulator = 0.0
	private var pending: PendingBinaryOperationInfo?

	// Description of the sequence of operands and operations
	private var description: String = ""

	// Whether there is a binary operation pending
	private var isPartialResult: Bool = true

	private enum Operation {
		case Equals
		case Random(() -> Double)
		case Constant(Double)
		case UnaryOperation((Double) -> Double)
		case BinaryOperation((Double, Double) -> Double)
	}

	private struct PendingBinaryOperationInfo {
		var binaryFunction: (Double, Double) -> Double
		var firstOperand: Double
	}

	private var operations: Dictionary<String, Operation> = [
		"%": Operation.UnaryOperation({ $0 / 100.0 }),
		"±": Operation.UnaryOperation({ $0 * -1.0 }),

		// TODO: Perhaps change this into unaryoperation
		"AC": Operation.Constant(0),

		"π": Operation.Constant(M_PI),
		"+": Operation.BinaryOperation({ $0 + $1 }),
		"-": Operation.BinaryOperation({ $0 - $1 }),
		"×": Operation.BinaryOperation({ $0 * $1 }),
		"÷": Operation.BinaryOperation({ $0 / $1 }),
		"=": Operation.Equals,
		"RAD": Operation.Random({ Double(arc4random()) / Double(UInt32.max) })
	]

	// MARK: - Public
	// Read-only Property
	var result: Double {
		return accumulator
	}

	var operationDescription: String {
		return description
	}

	func setOperand(operand: Double) {
		description += String(operand)
		accumulator = operand
	}

	func performOperation(symbole: String) {

		if let operation = operations[symbole] {
			switch operation {
			case .UnaryOperation(let function):
				accumulator = function(accumulator)
				description = "(\(description))"
				if symbole == "±" {
					description = symbole + description
				}
			case .BinaryOperation(let function):
				pending = PendingBinaryOperationInfo(binaryFunction: function,
					firstOperand: accumulator)

				if symbole == "÷" || symbole == "×" {
					description = "(\(description))"
				}

				description += symbole + "..."
			case .Equals:
				if pending != nil {

					description = description.replace("...", withString: "")

					accumulator = pending!.binaryFunction(pending!.firstOperand,
						accumulator)

					pending = nil
				}
			case .Random(let function):
				accumulator = function()
				description += symbole
				case.Constant(let value):
				accumulator = value
			}
		}

		switch symbole {
		case "AC":
			description = String()
			pending = nil
		default:
			break
		}
	}
}