//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Xinyang Li on 5/10/16.
//  Copyright © 2016 Xinyang Li. All rights reserved.
//

// Foundation is the core service layer
import Foundation

class CalculatorBrain {

	private var accumulator = 0.0

	private var operations: Dictionary<String, Operation> = [
		"π": Operation.Constant(M_PI),
		"e": Operation.Constant(M_E),
		"√": Operation.UnaryOperation(sqrt),
		"COS": Operation.UnaryOperation(cos),
		"±": Operation.UnaryOperation({ -$0 }),
		"×": Operation.BinaryOperation({ $0 * $1 }),
		"÷": Operation.BinaryOperation({ $0 / $1 }),
		"+": Operation.BinaryOperation({ $0 + $1 }),
		"−": Operation.BinaryOperation({ $0 - $1 }),
		"=": Operation.Equals
	]

	// enum pass by value (Like struct)
	private enum Operation {
		case Constant(Double)
		case UnaryOperation((Double) -> Double)
		case BinaryOperation((Double, Double) -> Double)
		case Equals
	}

	// struct very much like Class with NO inheritance
	// It pass by value
	private struct PendingBinaryOperationInfo {
		var binaryFunction: (Double, Double) -> Double
		var firstOperand: Double
	}

	private var pending: PendingBinaryOperationInfo?

	// Public (External)

	// Read-only Property
	var result: Double {
		get {
			return accumulator
		}
	}

	func setOperand(operand: Double) {
		accumulator = operand
	}

	func performOperation(symbol: String) {
		if let operation = operations[symbol] {
			switch operation {
			case .Constant(let value):
				accumulator = value
			case .UnaryOperation(let function):
				accumulator = function(accumulator)
			case .BinaryOperation(let function):
				pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
			case .Equals:
				if pending != nil {
					accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
					pending = nil
				}
			}
		}
	}
}