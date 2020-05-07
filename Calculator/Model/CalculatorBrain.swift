//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Azure May Burmeister on 3/24/20.
//  Copyright © 2020 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorBrain {
//    TODO: implement order of operations
    private var resetDisplay: Bool = true
    private var operations: (value: Double, operator: String)?
    private var displayText: String = "0"
    private var displayValue: Double {
        get {
            guard let value = Double(displayText) else {
                fatalError("Cannot convert display text to double")
            }
            return value
        }
        set {
            displayText = newValue.trim
        }
    }
    
    mutating func updateDisplayValue(_ char: String) -> String {
        if char == "." {
            let isInt = floor(displayValue) == displayValue
            if !isInt { return displayText }
            if displayValue == 0 {
                displayText.append(char)
                resetDisplay = false
                return displayText
            }
        } else if resetDisplay {
            displayText = char
            resetDisplay = false
            return displayText
        }
        displayText.append(char)
        return displayText
    }
    
    mutating func compute(_ symbol: String) -> String {
        switch symbol {
        case "AC":
            displayValue = 0
            resetDisplay = true
        case "+/-":
            displayValue *= -1
        case "%":
            displayValue *= 0.01
            resetDisplay = true
        case "=":
            if let result = performOperation() {
                displayValue = result
                resetDisplay = true
            }
        default:
            operations = (value: displayValue, operator: symbol)
            resetDisplay = true
        }
        return displayText
    }

    private func performOperation() -> Double? {
        if let value = operations?.value, let symbol = operations?.operator {
            switch symbol {
            case "+":
                return value + displayValue
            case "-":
                return value - displayValue
            case "×":
                return value * displayValue
            case "÷":
                return value / displayValue
            default:
                fatalError("The operation passed in cannot be identified.")
            }
        }
        return nil
    }
}

extension Double {
    fileprivate var trim: String {
        let format = NumberFormatter()
        format.usesSignificantDigits = true
        format.minimumSignificantDigits = 0
        return format.string(from: NSNumber(value: self))!
    }
}
