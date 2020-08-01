//
//  NumbersCells.swift
//  Calculadora
//
//  Created by Gustavo on 31/07/20.
//  Copyright © 2020 Gustavo. All rights reserved.
//

import Foundation
import UIKit

class NumbersCell: UITableViewCell {
    
    @IBOutlet var lblName: UILabel?
    @IBOutlet var lblResult: UILabel?
    
    func loadUI(item: Result) {
        
        lblName?.text = item.name
        lblResult?.text = item.result
    }
}
