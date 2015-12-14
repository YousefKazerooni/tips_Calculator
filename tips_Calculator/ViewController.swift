//
//  ViewController.swift
//  tips_Calculator
//
//  Created by Yousef Kazerooni on 12/2/15.
//  Copyright © 2015 Yousef Kazerooni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

 

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    

    
    //opportunity to save everything
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updatePercentageTitle()
        updatePercentage()
    }
    
    
    
    func updatePercentageTitle ()
    {
        tipControl.setTitle("\(userDefaults.integerForKey(lowTipKey))%", forSegmentAtIndex:0)
        tipControl.setTitle("\(userDefaults.integerForKey(midTipKey))%", forSegmentAtIndex:1)
        tipControl.setTitle("\(userDefaults.integerForKey(highTipKey))%", forSegmentAtIndex:2)
    }
    
    func updatePercentage ()
    {
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.locale = NSLocale.currentLocale()
        
        let tipPercentages = [ Double(userDefaults.floatForKey(lowTipKey))/100.0, Double (userDefaults.floatForKey(midTipKey))/100.0, Double (userDefaults.floatForKey(highTipKey))/100.0]
        let tipPercentage = tipPercentages[ tipControl.selectedSegmentIndex]
        
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        //tipLabel.text = " $\(tip)"
        //totalLabel.text = " $\(total)"
        
        tipLabel.text = currencyFormatter.stringFromNumber(tip)
        totalLabel.text = currencyFormatter.stringFromNumber(total)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        self.billField.becomeFirstResponder()
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        //updatePercentage()
        
    }
    
    //Why does nothing happen as I add these?
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
    
        updatePercentage()
    }

    @IBAction func onTap(sender: AnyObject) {
    
        view.endEditing (true)
    }
    

    
}

