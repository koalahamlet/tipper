//
//  SettingsViewController.swift
//  tipper
//
//  Created by koalahamlet on 8/16/15.
//  Copyright (c) 2015 koalahamlet. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    private var defaults = NSUserDefaults.standardUserDefaults()
    
    private var tipPercentages = [18, 20, 22]
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    @IBOutlet weak var lowerLabel: UILabel!
    
    @IBOutlet weak var midLabel: UILabel!
    
    @IBOutlet weak var higherLabel: UILabel!
    
    @IBOutlet weak var lowStepper: UIStepper!
    
    @IBOutlet weak var midStepper: UIStepper!
    
    @IBOutlet weak var highStepper: UIStepper! //hee hee
    
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
        var currencyPosition = defaults.integerForKey("currency")
        
        currencyPicker.selectRow(currencyPosition, inComponent: 0,animated: true)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        if defaults.integerForKey("default_low_percentage") != 0 {
            tipPercentages[0] = defaults.integerForKey("default_low_percentage")
        }
        if defaults.integerForKey("default_medium_percentage") != 0 {
            tipPercentages[1] = defaults.integerForKey("default_medium_percentage")
        }
        if defaults.integerForKey("default_high_percentage") != 0 {
            tipPercentages[2] = defaults.integerForKey("default_high_percentage")
        }
        
        lowerLabel.text = "\(tipPercentages[0])%"
        lowStepper.value = Double(tipPercentages[0])
        midLabel.text = "\(tipPercentages[1])%"
        midStepper.value = Double(tipPercentages[1])
        higherLabel.text = "\(tipPercentages[2])%"
        highStepper.value = Double(tipPercentages[2])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onDone(sender: AnyObject) {
        println("wat")
        var currency = currencyPicker.selectedRowInComponent(0)
        defaults.setInteger(currency, forKey: "currency")
        defaults.setInteger(tipPercentages[0], forKey: "default_low_percentage")
        defaults.setInteger(tipPercentages[1], forKey: "default_medium_percentage")
        defaults.setInteger(tipPercentages[2], forKey: "default_high_percentage")
        defaults.synchronize()
                println("foo")
        dismissViewControllerAnimated(true, completion: nil)
                println("yay")
        
    }
    
    @IBAction func percentChanged(sender: UIStepper) {
        var i = 2
        var label = higherLabel;
        switch sender {
        case lowStepper:
            i = 0
            label = lowerLabel
        case midStepper:
            i = 1
            label = midLabel
        default:
            i = 2
            label = higherLabel
        }
        
        tipPercentages[i] = Int(sender.value)
        label.text = "\(tipPercentages[i])%"
        
    }
    
    
    @IBAction func percentageUp(sender: UIStepper) {
        var i = 2
        var label = higherLabel;
        switch sender {
        case lowStepper:
            i = 0
            label = lowerLabel
        case midStepper:
            i = 1
            label = midLabel
        default:
            i = 2
            label = higherLabel
        }
        
        tipPercentages[i] = Int(sender.value)
        label.text = "\(tipPercentages[i])%"
    }

}


extension SettingsViewController: UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Currency.allValues.count
    }
}

extension SettingsViewController: UIPickerViewDelegate {
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        var currency : String
        currency = "$"
        if var convertedRank = Currency(rawValue: row){
            currency = convertedRank.longVersion()
        }
        
        return currency
    }
    
}
