//
//  ViewController.swift
//  tippy
//
//  Created by phil_nachum on 7/16/16.
//  Copyright © 2016 phil_nachum. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {

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
        setDefaultTipIndex()
        setTipOptionsControl(SavedDataService.getTipOptions())
        
        let savedBillAmount = SavedDataService.getSavedBillAmount()
        if (savedBillAmount != nil) {
            billField.text = String(savedBillAmount!)
        }
        calculateTipHelper()
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
        let tipPercent = SavedDataService.getTipOptions()[tipControl.selectedSegmentIndex]
        let tip = bill * tipPercent
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    // Get the default tip index from SavedDataService and
    // set it on the segmented control
    func setDefaultTipIndex() {
        tipControl.selectedSegmentIndex = SavedDataService.getDefaultTipIndex()
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        calculateTipHelper()
        // TODO: Probably unnecessary to save the bill amount when 
        // the tip amount changes. Separate it into two actions
        SavedDataService.setSavedBillAmount(billField.text!)
    }
    
}

