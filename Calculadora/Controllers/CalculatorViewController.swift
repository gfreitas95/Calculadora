//
//  CalculatorViewController.swift
//  Calculadora
//
//  Created by Gustavo on 31/07/20.
//  Copyright © 2020 Gustavo. All rights reserved.
//

import UIKit

enum Operation: String {
    
    case Add = "+"
    case Subtract = "-"
    case Divide = "/"
    case Multiply = "*"
    case Null = "Null"
}

class CalculatorViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    let backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnSubtract: UIButton!
    @IBOutlet weak var btnDivide: UIButton!
    @IBOutlet weak var btnMultiply: UIButton!
    @IBOutlet weak var btnEquals: UIButton!
    
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation:Operation =  .Null
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblCount?.text = result
        
        if let placeholder = txtName?.placeholder {
            txtName?.attributedPlaceholder = NSAttributedString(string: placeholder,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)])
        }
    }
    
    func operation(operation: Operation) {
        
        if currentOperation != .Null {
            
            if runningNumber != "" {
                rightValue = runningNumber
                runningNumber = ""
                
                if currentOperation == .Add {
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                } else if currentOperation == .Subtract {
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                } else if currentOperation == .Multiply {
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                } else if currentOperation == .Divide {
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                }
                leftValue = result
                
                if (Double(result)!.truncatingRemainder(dividingBy: 1) == 0) {
                    result = "\(Int(Double(result)!))"
                }
                lblCount?.text = result
            }
            currentOperation = operation
        } else {
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
    func buttonsPressed() {
        
        UIView.animate(withDuration: 0.5) {
            self.btnAdd?.backgroundColor = self.backgroundColor
            self.btnAdd?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnDivide?.backgroundColor = self.backgroundColor
            self.btnDivide?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnMultiply?.backgroundColor = self.backgroundColor
            self.btnMultiply?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnSubtract?.backgroundColor = self.backgroundColor
            self.btnSubtract?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnEquals?.backgroundColor = self.backgroundColor
            self.btnEquals?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func saveCount() {
        
        let savesViewController = storyboard?.instantiateViewController(identifier: "SavesView") as! SavesViewController
        
        let dictionary = ["name": txtName?.text ?? "", "result": lblCount?.text ?? ""]
        
        if var numbersDictionary = UserDefaults.standard.value(forKey: "results") as? Array<Dictionary<String,String>> {
            
            numbersDictionary.append(dictionary)
            UserDefaults.standard.set(numbersDictionary, forKey: "results")
            UserDefaults.standard.synchronize()
        } else {
            UserDefaults.standard.set([dictionary], forKey: "results")
        }
        txtName?.text = ""
        self.present(savesViewController, animated: true, completion: nil)
    }
    
    @IBAction func goToSavedCounts() {
        
        let savesViewController = storyboard?.instantiateViewController(identifier: "SavesView") as! SavesViewController
        
        self.present(savesViewController, animated: true, completion: nil)
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        
        if runningNumber.count <= 9 {
            runningNumber += "\(sender.tag)"
            lblCount?.text = runningNumber
            buttonsPressed()
        }
    }
    
    @IBAction func allClearPressed(_ sender: UIButton) {
        
        runningNumber = ""
        leftValue = ""
        rightValue = ""
        result = ""
        currentOperation = .Null
        lblCount?.text = "0"
    }
    
    @IBAction func dotPressed(_ sender: UIButton) {
        
        if runningNumber.count <= 9 {
        runningNumber += "."
        lblCount?.text = runningNumber
        }
    }
    
    @IBAction func equalPressed(_ sender: UIButton) {
        operation(operation: currentOperation)
        
        btnEquals?.backgroundColor = UIColor.white
        btnEquals?.setTitleColor(UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0), for: UIControl.State.normal)
        
        UIView.animate(withDuration: 0.5) {
            self.btnAdd?.backgroundColor = self.backgroundColor
            self.btnAdd?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnDivide?.backgroundColor = self.backgroundColor
            self.btnDivide?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnMultiply?.backgroundColor = self.backgroundColor
            self.btnMultiply?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnSubtract?.backgroundColor = self.backgroundColor
            self.btnSubtract?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnEquals?.backgroundColor = self.backgroundColor
            self.btnEquals?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        operation(operation: .Add)
        
        btnAdd?.backgroundColor = UIColor.white
        btnAdd?.setTitleColor(UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0), for: UIControl.State.normal)
        
        UIView.animate(withDuration: 0.5) {
            self.btnAdd?.backgroundColor = self.backgroundColor
            self.btnAdd?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnDivide?.backgroundColor = self.backgroundColor
            self.btnDivide?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnMultiply?.backgroundColor = self.backgroundColor
            self.btnMultiply?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnSubtract?.backgroundColor = self.backgroundColor
            self.btnSubtract?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnEquals?.backgroundColor = self.backgroundColor
            self.btnEquals?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
    }
    
    @IBAction func subtractPressed(_ sender: UIButton) {
        operation(operation: .Subtract)
        
        btnSubtract?.backgroundColor = UIColor.white
        btnSubtract?.setTitleColor(UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0), for: UIControl.State.normal)
        
        UIView.animate(withDuration: 0.5) {
            self.btnSubtract?.backgroundColor = self.backgroundColor
            self.btnSubtract?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnAdd?.backgroundColor = self.backgroundColor
            self.btnAdd?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnDivide?.backgroundColor = self.backgroundColor
            self.btnDivide?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnMultiply?.backgroundColor = self.backgroundColor
            self.btnMultiply?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnEquals?.backgroundColor = self.backgroundColor
            self.btnEquals?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
    }
    
    @IBAction func multiplyPressed(_ sender: UIButton) {
        operation(operation: .Multiply)
        
        btnMultiply?.backgroundColor = UIColor.white
        btnMultiply?.setTitleColor(UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0), for: UIControl.State.normal)
        
        UIView.animate(withDuration: 0.5) {
            self.btnMultiply?.backgroundColor = self.backgroundColor
            self.btnMultiply?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnAdd?.backgroundColor = self.backgroundColor
            self.btnAdd?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnDivide?.backgroundColor = self.backgroundColor
            self.btnDivide?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnSubtract?.backgroundColor = self.backgroundColor
            self.btnSubtract?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnEquals?.backgroundColor = self.backgroundColor
            self.btnEquals?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
    }
    
    @IBAction func dividePressed(_ sender: UIButton) {
        operation(operation: .Divide)
        
        btnDivide?.backgroundColor = UIColor.white
        btnDivide?.setTitleColor(UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0), for: UIControl.State.normal)
        
        UIView.animate(withDuration: 0.5) {
            self.btnDivide?.backgroundColor = self.backgroundColor
            self.btnDivide?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnAdd?.backgroundColor = self.backgroundColor
            self.btnAdd?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnMultiply?.backgroundColor = self.backgroundColor
            self.btnMultiply?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnSubtract?.backgroundColor = self.backgroundColor
            self.btnSubtract?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.btnEquals?.backgroundColor = self.backgroundColor
            self.btnEquals?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
    }
}
