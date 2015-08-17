//
//  ViewController.swift
//  tipper
//
//  Created by koalahamlet on 8/15/15.
//  Copyright (c) 2015 koalahamlet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let valueDefault = "value"
    let valueDateDefault = "value_date"
    let percentageDefault = "percentage"
    
    private var tipPercentages = [18, 20, 22]
    
    private var currency = "$"
    
    private var defaults = NSUserDefaults.standardUserDefaults()

    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        // Do any additional setup after loading the view, typically from a nib.
        
        var savedValue : String? = defaults.objectForKey(valueDefault) as? String
        var savedValueAt : NSDate? = defaults.objectForKey(valueDateDefault) as? NSDate
        
        var earlier = NSDate().dateByAddingTimeInterval(-5*60)
        if (savedValue != nil && savedValueAt?.compare(earlier).rawValue > 0) {
            billField.text = savedValue!
        }
        
        billField.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(animated)
        var currencyPosition = defaults.integerForKey("currency")
        
        if var convertedRank = Currency(rawValue: currencyPosition){
            currency = convertedRank.shortVersion()
        }
        
        var savedPercentate = defaults.integerForKey(percentageDefault)
        
        if defaults.integerForKey("default_low_percentage") != 0 {
            tipPercentages[0] = defaults.integerForKey("default_low_percentage")
        }
        if defaults.integerForKey("default_medium_percentage") != 0 {
            tipPercentages[1] = defaults.integerForKey("default_medium_percentage")
        }
        if defaults.integerForKey("default_high_percentage") != 0 {
            tipPercentages[2] = defaults.integerForKey("default_high_percentage")
        }
        
        tipControl.removeAllSegments()
        for (index, percentage) in enumerate(tipPercentages) {
            tipControl.insertSegmentWithTitle("\(percentage)%", atIndex: index, animated: true)
        }
        tipControl.selectedSegmentIndex = savedPercentate
        
        calculateBill()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        defaults.setObject(billField.text, forKey: valueDefault)
        defaults.setObject(NSDate(), forKey: valueDateDefault)
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: percentageDefault)
    }

    private func updateLabel(label: UILabel, value: Double){
        var nf = NSNumberFormatter()
        nf.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        nf.currencySymbol = currency
        
        label.text = nf.stringFromNumber(value)
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
            
    }

    func calculateBill() {

        var tipPercent = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = (billField.text as NSString).doubleValue
        
        var tip = billAmount * Double(tipPercent) / 100
        var total = billAmount + tip

        updateLabel(tipLabel, value: tip)
        updateLabel(totalLabel, value: total)
        
//        tipLabel.text = "$\(tip)"
//        totalLabel.text = "$\(total)"
//        
//        tipLabel.text = String(format: "$%.2f", tip)
//        totalLabel.text = String(format: "$%.2f", total)
    
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

