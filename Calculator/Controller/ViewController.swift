//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    private var calculatorBrain = CalculatorBrain()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        if let symbol = sender.currentTitle {
            displayLabel.text = calculatorBrain.compute(symbol)
        }
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        if let value = sender.currentTitle {
            displayLabel.text = calculatorBrain.updateDisplayValue(value)
        }
    }
}
