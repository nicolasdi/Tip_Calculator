//
//  ResultViewController.swift
//  CalculadoraPropina
//
//  Created by Diana Nicolas on 08/10/24.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var billAlloc: UILabel!
    @IBOutlet var tipAlloc: UILabel!
    @IBOutlet var total: UILabel!
    
    var billValue: Double = 0.0

    // 0 : 10%, 1: 15%, 2: 20%
    var selectedTip: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // formatting output
        billAlloc.text = formatMoney(billValue)
        let finalAmount = totalTip(billValue, selectedTip)
        tipAlloc.text = formatMoney(finalAmount)
        total.text = formatMoney(finalAmount + billValue)
    }
    
    private func totalTip(_ billValue: Double, _ selectedTip: Int) -> Double {
        var finalTip: Double = 0

        switch selectedTip {
        // according to the UISegmentedControl values
        case 0: finalTip = 0.1 // 10%
        case 1: finalTip = 0.15 //15%
        case 2: finalTip = 0.2 // 20%
        default: finalTip = 0
        }
        
        return billValue * finalTip
    }
    
    private func formatMoney(_ value: Double) -> String {
        return "$ \(value)"
    }

}
