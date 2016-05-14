//
//  calculatorBrain.swift
//  CalculatorDuplication
//
//  Created by Xinyang Li on 5/13/16.
//  Copyright © 2016 Xinyang Li. All rights reserved.
//

import Foundation

class CalculatorBrain {
	// MARK: - Private
	private var accumulator = 0.0
	private var pending: PendingBinaryOperationInfo?
	private var isPartialResult = false
	private var description = " "

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
		"AC": Operation.Constant(0),
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

	func setOperand(operand: Double) {
		accumulator = operand
	}

	func performOperation(symbole: String) {
		if let operation = operations[symbole] {
			switch operation {
			case .UnaryOperation(let function):
				accumulator = function(accumulator)
			case .BinaryOperation(let function):
				pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
			case .Equals:
				if pending != nil {
					accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
					pending = nil
				}
			case .Random(let function):
				accumulator = function()
            case.Constant(let value):
				accumulator = value
			}
		}
	}
}