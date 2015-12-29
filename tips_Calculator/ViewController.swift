//
//  ViewController.swift
//  tips_Calculator
//
//  Created by Yousef Kazerooni on 12/2/15.
//  Copyright © 2015 Yousef Kazerooni. All rights reserved.
//

import UIKit

let lastBillAmout = "Last_Bill_Amount"
let lastUsed = "Last_Used"
let splitAmount = "Last_Amount_Split"


class ViewController: UIViewController {


    

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var splitSwitch: UISwitch!
    
    //slider
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var splitPeople: UITextField!
    
    
    //animated UIViews
    //Top View-- color? or nothing ???+++++++++++
    @IBOutlet weak var tipView: UIView!
    //Middle View with the switch -- Moves down
    @IBOutlet weak var switchView: UIView!
    //Down View -- Fades in
    @IBOutlet weak var SplitView: UIView!
    
    
    //will be used to find out how many people are 
    //splitting the bill
    var countPeople: Int!
    
    //Declared total. It will then be divided
    //by the number of people paying
    var total : Double!
    
    //Counter used to determine the position of the switch view
    var counter = 0
    
    //var tip : Double!
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    
    
    
    //opportunity to save everything
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updatePercentageTitle()
        updatePercentage()
        tipControl.selectedSegmentIndex = userDefaults.integerForKey(segIndex)
        //animationMain()
        
       
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
        total = billAmount + tip
        //splitTotal()
        
        //tipLabel.text = " $\(tip)"
        //totalLabel.text = " $\(total)"
        
        tipLabel.text = currencyFormatter.stringFromNumber(tip)
        totalLabel.text = currencyFormatter.stringFromNumber(total)
        
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //+++++++++++++++++++++
        //self.navigationController?.navigationBarHidden = true
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //Checking when the app was last used
        let timeNow = NSDate()
        let timeLast = userDefaults.objectForKey(lastUsed) as? NSDate
        
        if ( timeLast != nil && timeNow.timeIntervalSinceDate(timeLast!) < 600)
        {
            billField.text = userDefaults.stringForKey(lastBillAmout)
        }

        
        //making the textfield as the first responder
        self.billField.becomeFirstResponder()
        
       
        //intializing the labels on the first launch
                totalLabel.text = "$0.00"
        
        
        UIView.animateWithDuration (0.01) { ()-> Void in self.switchView.transform = CGAffineTransformTranslate(self.switchView.transform, 0.0, -135.0)
        }
       
        
    }
    
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Switching On: SplitView fades in
    
    @IBAction func SplitSwitchonValueChanged(sender: UISwitch) {
        if (self.SplitView.alpha == 0) {
            UIView.animateWithDuration(0.5, animations: {
                // This causes first view to fade in and second view to fade out
                self.SplitView.alpha = 1
                
            })
            
        }
        else {
            UIView.animateWithDuration(0.5, animations: {
                // This causes first view to fade in and second view to fade out
                self.SplitView.alpha = 0
                
            })
            
        }
        
        
//        if (SplitView.alpha == 1) {
//           SplitView.alpha = 0
//        }
//        
//        else {
//            SplitView.alpha = 1
//        }
//
      }

    
    
    
    //slider
    @IBAction func slider(sender: AnyObject) {
        countPeople = Int (slider.value)
        splitPeople.text = "\( countPeople)"
        
        //let afterSplitting 
        
      //  total = total / Double (countPeople)
        
        
        
    }
    
//    func splitTotal () {
//        if (total != nil) {
//        total = total / Double(countPeople)
//        }
//    }
    
    
    //The SplitView slides up as user starts using the input field
    
    @IBAction func splitPeopleEditingBegin(sender: UITextField) {
        UIView.animateWithDuration (0.5) { ()-> Void in self.SplitView.transform = CGAffineTransformTranslate(self.SplitView.transform, 0.0, -190.0)
        }
    }
    
    
    @IBAction func splitPeoleEditingEnded(sender: UITextField) {
        UIView.animateWithDuration (0.5) { ()-> Void in self.SplitView.transform = CGAffineTransformTranslate(self.SplitView.transform, 0.0, 190.0)
        }
    }
    
    
    
    //As Bill Amount entered the Labels are updated and the switchView is moved down
    @IBAction func onEditingChanged(sender: AnyObject) {
    
        updatePercentage()
        counter = counter + 1
        if (counter == 1) {
        UIView.animateWithDuration (0.5) { ()-> Void in self.switchView.transform = CGAffineTransformTranslate(self.switchView.transform, 0.0, 137.0)
        }
      }
    
        
    }
    
    
   
   

    @IBAction func onTap(sender: AnyObject) {
    
        view.endEditing (true)
//        if (self.tipView.alpha == 0) {
//            UIView.animateWithDuration(0.5, animations: {
//                // This causes first view to fade in and second view to fade out
//                self.tipView.alpha = 1
//                
//            })
//            
//        }

    }
    
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        userDefaults.setObject(NSDate(), forKey: lastUsed)
        userDefaults.setObject(billField.text, forKey: lastBillAmout)
        
        //Capturing which index is selected
        userDefaults.setInteger(tipControl.selectedSegmentIndex, forKey: segIndex)
        
        userDefaults.synchronize()
        
        
    }

    
}

