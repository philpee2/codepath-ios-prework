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
    @IBOutlet weak var tipDetailsContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setDefaultTipIndex()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setTipOptionsControl(SavedDataService.getTipOptions())
        
        let savedBillAmount = SavedDataService.getSavedBillAmount()
        if (savedBillAmount != nil) {
            billField.text = String(savedBillAmount!)
        }
        calculateTipHelper()
        if (billField.text!.isEmpty) {
            hideTipDetails()
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
    
    // TODO: Figure out how to do this without
    // magic hardcoded numbers
    private func showTipDetails() {
        tipDetailsContainer.frame = CGRectMake(0.0, 129.0, 320.0, 161.0)
    }
    
    private func hideTipDetails() {
        tipDetailsContainer.frame = CGRectMake(0.0, 290, 320.0, 0)
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        calculateTipHelper()
        // TODO: Probably unnecessary to save the bill amount when 
        // the tip amount changes. Separate it into two actions
        let billValue = billField.text ?? ""
        SavedDataService.setSavedBillAmount(billValue)
        print(tipDetailsContainer.frame)
        UIView.animateWithDuration(0.2, animations: {
            if (billValue.isEmpty) {
                self.hideTipDetails()
            } else {
                self.showTipDetails()
            }
        })
    }
    
}

