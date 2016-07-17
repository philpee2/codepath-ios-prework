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
        
        defaultTipControl.selectedSegmentIndex = SavedDataService.getDefaultTipIndex()
        
        let tipFields = [lowTipField, midTipField, highTipField]
        for (index, option) in SavedDataService.getTipOptions().enumerate() {
            let displayOption = Int(option * 100)
            defaultTipControl.setTitle("\(displayOption)%", forSegmentAtIndex: index)
            tipFields[index].text = "\(displayOption)"
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        lowTipField.becomeFirstResponder()
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
        let selectedIndex = defaultTipControl.selectedSegmentIndex
        SavedDataService.setDefaultTipIndex(selectedIndex)
    }
    
    // Read the stored tip options, update one of them to the new value, 
    // and set it back. Also update the default tip control
    private func changeTipOption(index: Int, newValue: String) {
        var tipOptions = SavedDataService.getTipOptions()
        let normalizedNewValue = newValue.isEmpty ? "0" : newValue
        let enteredInt = Int(normalizedNewValue)! ?? 0
        let enteredPercent = Double(enteredInt) / 100
        tipOptions[index] = enteredPercent
        SavedDataService.setTipOptions(tipOptions)
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
