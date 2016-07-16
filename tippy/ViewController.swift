//
//  ViewController.swift
//  tippy
//
//  Created by phil_nachum on 7/16/16.
//  Copyright © 2016 phil_nachum. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        getDefaultTipIndex()
        setTipOptionsControl(getTipOptions())
        calculateTipHelper()
        
        let savedBillAmount = getSavedBillAmount()
        if (savedBillAmount != nil) {
            billField.text = String(savedBillAmount!)
        }
        billField.becomeFirstResponder()
    }
    
    // Set the given tip options as the titles on the segmented 
    // control
    private func setTipOptionsControl(options: Array<Double>) {
        for (index, option) in options.enumerate() {
            let displayOption = Int(option * 100)
            tipControl.setTitle("\(displayOption)%", forSegmentAtIndex: index)
        }
    }
    
    private func calculateTipHelper() {
        let bill = Double(billField.text!) ?? 0
        let tipPercent = getTipOptions()[tipControl.selectedSegmentIndex]
        let tip = bill * tipPercent
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    // Get the default tip index from standardUserDefaults and 
    // set it on the segmented control
    func getDefaultTipIndex() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let defaultIndex = defaults.integerForKey("defaultTipIndex")
        tipControl.selectedSegmentIndex = defaultIndex
    }
    
    // TODO: How to share code between View Controllers, so this method
    // isn't repeated?
    private func getTipOptions() -> Array<Double> {
        let defaults = NSUserDefaults.standardUserDefaults()
        let storedOptions = defaults.objectForKey("tipOptions")
        if (storedOptions == nil) {
            return [0.18, 0.2, 0.25]
        } else {
            return (storedOptions as! NSArray) as! Array<Double>
        }
    }
    
    // Get the current bill amount from the field and save it
    private func saveBillAmount() {
        let bill = Double(billField.text!) ?? 0
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(bill, forKey: "savedBillAmount")
        defaults.setObject(NSDate(), forKey: "savedBillTime")
    }
    
    private func getSavedBillAmount() -> Double? {
        let defaults = NSUserDefaults.standardUserDefaults()
        let savedBillAmount = defaults.doubleForKey("savedBillAmount")
        let savedBillTimeObj = defaults.objectForKey("savedBillTime")
        
        if (savedBillTimeObj == nil) {
            return nil
        }
        
        let savedBillTime = savedBillTimeObj as! NSDate
        
        
        // If there is no saved value, doubleForKey returns 0. In this
        // case, return nil, since initializing the field to 0 would
        // require backspacing to remove it
        let noSavedValue = savedBillAmount == 0
        let valueExpired = savedBillTime.timeIntervalSinceNow * -1 > 10 * 60
        if (noSavedValue || valueExpired) {
            return nil
        } else {
            return savedBillAmount
        }

        
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        calculateTipHelper()
        // TODO: Probably unnecessary to save the bill amount when 
        // the tip amount changes. Separate it into two actions
        saveBillAmount()
    }
    
}

