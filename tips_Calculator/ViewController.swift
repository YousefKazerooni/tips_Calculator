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
    @IBOutlet weak var perPersonLabel: UILabel!
    //slider
    @IBOutlet weak var SplitPeople: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    
    
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
    var people: Int!
    var peopleTextField: Double!
    var perPerson: Double!
    
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
        
        //determining the value of the slider
        sliderValueDetermination()
        
        //assigning the value of the slider to the textfield
        SplitPeople.text = "\( people)"
        
        //Using the value inside the text field for calculations
        peopleTextField = NSString (string: SplitPeople.text!).doubleValue
        perPerson = total / peopleTextField
        
        
        
        //tipLabel.text = " $\(tip)"
        //totalLabel.text = " $\(total)"
        
        tipLabel.text = currencyFormatter.stringFromNumber(tip)
        totalLabel.text = currencyFormatter.stringFromNumber(total)
        perPersonLabel.text = currencyFormatter.stringFromNumber(perPerson)
    }
    
    
    
    
    func sliderValueDetermination () {
        //Splitting
        if (slider.value >= 2 && slider.value < 2.5){
            people = 2
        }
            
        else if (slider.value >= 2.5 && slider.value < 3.5){
            people = 3
        }
        else if ( slider.value >= 3.5 && slider.value < 4.5) {
            people = 4
        }
        else if ( slider.value >= 4.5 && slider.value < 5.5) {
            people = 5
        }
        else if ( slider.value >= 5.5 && slider.value < 6.5) {
            people = 6
        }
        else if ( slider.value >= 6.5 && slider.value < 7.5) {
            people = 7
        }
        else if ( slider.value >= 7.5 && slider.value < 8.5) {
            people = 8
        }
        else if ( slider.value >= 8.5 && slider.value < 9.5) {
            people = 9
        }
        else if ( slider.value >= 9.5 && slider.value <= 10) {
            people = 10
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        
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
        
      }

    
    
    
    //slider
    @IBAction func slider(sender: AnyObject) {
        updatePercentage()
        //splitPeople.text = "\( people)"
        
    
        
    }
    
    //The SplitView slides up as user starts using the input field
    
    
    
    //As Bill Amount entered the Labels are updated and the switchView is moved down
    @IBAction func onEditingChanged(sender: AnyObject) {
    
        updatePercentage()
        
        //switch view slides down when start editting
        counter = counter + 1
        if (counter == 1) {
        UIView.animateWithDuration (0.5) { ()-> Void in self.switchView.transform = CGAffineTransformTranslate(self.switchView.transform, 0.0, 137.0)
        }
      }
    
        
    }
    
    
   
   

    @IBAction func onTap(sender: AnyObject) {
    
        view.endEditing (true)
        
        //switch view slides down when tap anywhere on the mainview
        counter = counter + 1
        if (counter == 1) {
            UIView.animateWithDuration (0.5) { ()-> Void in self.switchView.transform = CGAffineTransformTranslate(self.switchView.transform, 0.0, 137.0)
            }
        }



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

