//
//  SettingsViewController.swift
//  tippy
//
//  Created by phil_nachum on 7/16/16.
//  Copyright © 2016 phil_nachum. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    @IBOutlet weak var lowTipField: UITextField!
    @IBOutlet weak var midTipField: UITextField!
    @IBOutlet weak var highTipField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let defaultIndex = defaults.integerForKey("defaultTipIndex")
        defaultTipControl.selectedSegmentIndex = defaultIndex
        
        let tipFields = [lowTipField, midTipField, highTipField]
        for (index, option) in getTipOptions().enumerate() {
            let displayOption = Int(option * 100)
            defaultTipControl.setTitle("\(displayOption)%", forSegmentAtIndex: index)
            tipFields[index].text = "\(displayOption)"
        }
    }
    
    // Read and return the tip options from standardUserDefaults
    private func getTipOptions() -> Array<Double> {
        let defaults = NSUserDefaults.standardUserDefaults()
        let tipOptions = defaults.objectForKey("tipOptions")
        if (tipOptions == nil) {
            return [0.18, 0.2, 0.25]
        } else {
            return (tipOptions as! NSArray) as! Array<Double>
        }
    }
    
    // Set the given tip options to standardUserDefaults
    private func setTipOptions(options: Array<Double>) {
        print(options)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(options, forKey: "tipOptions")
        defaults.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Set the segmented control's value to be the default tip index
    @IBAction func setDefaultTip(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let selectedIndex = defaultTipControl.selectedSegmentIndex
        defaults.setInteger(selectedIndex, forKey: "defaultTipIndex")
        defaults.synchronize()
    }
    
    // Read the stored tip options, update one of them to the new value, 
    // and set it back. Also update the default tip control
    private func changeTipOption(index: Int, newValue: String) {
        var tipOptions = getTipOptions()
        let normalizedNewValue = newValue.isEmpty ? "0" : newValue
        let enteredInt = Int(normalizedNewValue)! ?? 0
        let enteredPercent = Double(enteredInt) / 100
        tipOptions[index] = enteredPercent
        setTipOptions(tipOptions)
        defaultTipControl.setTitle("\(enteredInt)%", forSegmentAtIndex: index)
    }
    
    // TODO: Enforce that the entered values are in the correct order
    // (ie low is less than mid, which is less than high), or re-order 
    // them as needed
    @IBAction func onLowTipChanged(sender: AnyObject) {
        changeTipOption(0, newValue: lowTipField.text!)
    }

    @IBAction func onMidTipChanged(sender: AnyObject) {
        changeTipOption(1, newValue: midTipField.text!)
    }
    
    @IBAction func onHighTipChanged(sender: AnyObject) {
        changeTipOption(2, newValue: highTipField.text!)
    }
    @IBAction func onTap(sender: AnyObject) {
        // TODO: Why does this break?
        // view.endEditing(true)
    }
}
