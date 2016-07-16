//
//  SavedDataService.swift
//  tippy
//
//  Created by phil_nachum on 7/16/16.
//  Copyright © 2016 phil_nachum. All rights reserved.
//

import Foundation

let DEFAULT_TIP_OPTIONS = [0.18, 0.2, 0.25]

class SavedDataService: NSObject {
    
    private static func getUserDefaults() -> NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }
    
    static func getDefaultTipIndex() -> Int {
        let defaults = SavedDataService.getUserDefaults()
        return defaults.integerForKey("defaultTipIndex")
    }
    
    static func setDefaultTipIndex(selectedIndex: Int) {
        let defaults = SavedDataService.getUserDefaults()
        defaults.setInteger(selectedIndex, forKey: "defaultTipIndex")
        defaults.synchronize()
    }
    
    static func getTipOptions() -> Array<Double> {
        let defaults = SavedDataService.getUserDefaults()
        let tipOptions = defaults.objectForKey("tipOptions")
        if (tipOptions == nil) {
            return DEFAULT_TIP_OPTIONS
        } else {
            return (tipOptions as! NSArray) as! Array<Double>
        }
    }
    
    static func setTipOptions(options: Array<Double>) {
        let defaults = SavedDataService.getUserDefaults()
        defaults.setObject(options, forKey: "tipOptions")
        defaults.synchronize()
    }
    
    // Returns nil if there is no saved bill, or if it has expired
    static func getSavedBillAmount() -> Double? {
        let defaults = SavedDataService.getUserDefaults()
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
    
    // Handles converting the String from a text field to a Double
    static func setSavedBillAmount(newValue: String) {
        let bill = Double(newValue) ?? 0
        let defaults = SavedDataService.getUserDefaults()
        defaults.setDouble(bill, forKey: "savedBillAmount")
        defaults.setObject(NSDate(), forKey: "savedBillTime")
    }
    
}