//
//  CalculatorViewController.swift
//  Calculadora
//
//  Created by Gustavo on 31/07/20.
//  Copyright © 2020 Gustavo. All rights reserved.
//

import UIKit

enum Operation: String {
    
    case add = "+"
    case subtract = "−"
    case divide = "÷"
    case multiply = "*"
    case null = "Null"
    case percent = "%"
    case plusMinus = "⁺∕-"
    case AC = "C"
}

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnSubtract: UIButton!
    @IBOutlet weak var btnDivide: UIButton!
    @IBOutlet weak var btnMultiply: UIButton!
    @IBOutlet weak var btnEquals: UIButton!
    @IBOutlet weak var btnPercent: UIButton!
    @IBOutlet weak var btnPlusMinus: UIButton!
    @IBOutlet weak var btnAllClear: UIButton!
    
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = "0"
    var currentOperation:Operation =  .null
    let defaults = UserDefaults.standard
    let backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblCount?.text = result
        lblCount?.adjustsFontSizeToFitWidth = true
        
        if let placeholder = txtName?.placeholder {
            txtName?.attributedPlaceholder = NSAttributedString(string: placeholder,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)])
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func operation(operation: Operation) {
        
        if currentOperation != .null {
            
            if runningNumber != "" {
                rightValue = runningNumber
                runningNumber = ""
                
                if currentOperation == .add {
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                } else if currentOperation == .subtract {
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                } else if currentOperation == .multiply {
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                } else if currentOperation == .divide {
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
        
        if #available(iOS 13.0, *) {
            let savesViewController = storyboard?.instantiateViewController(identifier: "SavesView") as! SavesViewController
            self.present(savesViewController, animated: true, completion: nil)
        } else {
            let storyboard = UIStoryboard(name: "SavesView", bundle: nil)
            let storyboardVC = storyboard.instantiateViewController(withIdentifier: "SavesView")
            self.present(storyboardVC, animated: true)
        }
        
        let dictionary = ["name": txtName?.text ?? "", "result": lblCount?.text ?? ""]
        
        if var numbersDictionary = UserDefaults.standard.value(forKey: "results") as? Array<Dictionary<String,String>> {
            
            numbersDictionary.append(dictionary)
            UserDefaults.standard.set(numbersDictionary, forKey: "results")
            UserDefaults.standard.synchronize()
        } else {
            UserDefaults.standard.set([dictionary], forKey: "results")
        }
        txtName?.text = ""
    }
    
    @IBAction func goToSavedCounts() {
        
        if #available(iOS 13.0, *) {
            let savesViewController = storyboard?.instantiateViewController(identifier: "SavesView") as! SavesViewController
            self.present(savesViewController, animated: true, completion: nil)
        } else {
            let storyboard = UIStoryboard(name: "SavesView", bundle: nil)
            let storyboardVC = storyboard.instantiateViewController(withIdentifier: "SavesView")
            self.present(storyboardVC, animated: true)
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        
        if runningNumber.count <= 9 {
            runningNumber += "\(sender.tag)"
            lblCount?.text = runningNumber
            buttonsPressed()
        }
            btnAllClear.setTitle("C", for: .normal)
    }
    
    @IBAction func allClearPressed(_ sender: UIButton) {
        
        runningNumber = ""
        leftValue = ""
        rightValue = ""
        result = ""
        currentOperation = .null
        lblCount?.text = "0"
        btnAllClear.setTitle("AC", for: .normal)
    }
    
    @IBAction func dotPressed(_ sender: UIButton) {
        
        if runningNumber.count <= 9 {
            runningNumber += ","
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
        operation(operation: .add)
        
        btnAdd?.backgroundColor = UIColor.white
        btnAdd?.setTitleColor(UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0), for: UIControl.State.normal)
        
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
        operation(operation: .subtract)
        
        btnSubtract?.backgroundColor = UIColor.white
        btnSubtract?.setTitleColor(UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0), for: UIControl.State.normal)
               
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
        operation(operation: .multiply)
        
        btnMultiply?.backgroundColor = UIColor.white
        btnMultiply?.setTitleColor(UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0), for: UIControl.State.normal)
        
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
        operation(operation: .divide)
        
        btnDivide?.backgroundColor = UIColor.white
        btnDivide?.setTitleColor(UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0), for: UIControl.State.normal)
        
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
    
    @IBAction func plusMinusPressed(_ sender: UIButton) {
        
        lblCount.text = "\(Int(runningNumber)! * -1)"
    }
    
    @IBAction func percentPressed(_ sender: UIButton) {
        
        lblCount.text = "\(Double(runningNumber)! / 100)"
    }
}
