//
//  ViewController.swift
//  tipper
//
//  Created by koalahamlet on 8/15/15.
//  Copyright (c) 2015 koalahamlet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
            
    }

    func calculateBill() {
        var tipPercentages = [0.15,0.2,0.25]
        var tipPercent = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = (billField.text as NSString).doubleValue
        
        var tip = billAmount * tipPercent
        var total = billAmount + tip
        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    
    }
    
    @IBAction func onValueChanged(sender: AnyObject) {
        calculateBill()
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        println("user edited a thing")
        println("User edited bill")
        
        calculateBill()
    }
}

