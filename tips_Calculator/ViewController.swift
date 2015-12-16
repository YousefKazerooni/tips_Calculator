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

//Counter becomes greater than zero after the first time viewing
//It is then used to create a dark dividing line in the middle of the page
var counter = 0

class ViewController: UIViewController {


    

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    //animated UIViews
    @IBOutlet weak var animatedView: UIView!
    @IBOutlet weak var animatedViewRed: UIView!
    @IBOutlet weak var animatedViewLowest: UIView!
    
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    
    
    
    //opportunity to save everything
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updatePercentageTitle()
        updatePercentage()
        
        
        
        counter = counter + 1
        if (counter > 1) {
            
            let dividingLine = UIView()
            
            // set background color to blue
            dividingLine.backgroundColor = UIColor.blackColor()
            
            // set frame (position and size) of the square
            // iOS coordinate system starts at the top left of the screen
            // so this square will be at top left of screen, 50x50pt
            // CG in CGRect stands for Core Graphics
            dividingLine.frame = CGRect(x: 0, y: 300, width: 400, height: 20)
            
            // finally, add the square to the screen
            self.view.addSubview(dividingLine)
        }
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
    
    //*********************************************
    //animation fuction
    
    func animationMain () {
        //defining the final color
        let blue = UIColor(red: 41.0/255.0,
            green: 0.5,
            blue: 185/255.0,
            alpha: 1.0)
        //defining repetition
        let options = UIViewAnimationOptions.Repeat
        
        //the function for animation
        //animating movement and color
        //and incorporating repetition
        
        
        //Animating the RED UIView
        UIView.animateWithDuration(2.0, delay: 0.0, options: options, animations: {
            
            // any changes entered in this block will be animated
            self.animatedViewRed.transform = CGAffineTransformTranslate( self.animatedViewRed.transform, -330.0, 0.0  )
            self.animatedViewRed.backgroundColor = blue
            
            }, completion: nil)
        
        
        //Animating the WHITE UIView
        UIView.animateWithDuration(3.0, delay: 0.0, options: options, animations: {
            
            // any changes entered in this block will be animated
            self.animatedView.transform = CGAffineTransformTranslate( self.animatedView.transform, 330.0, 0.0  )
            self.animatedView.backgroundColor = blue
            
            }, completion: nil)
        
        
        
        //Animating the Lowest UIView
        UIView.animateWithDuration(4.0, delay: 0.0, options: options, animations: {
            
            // any changes entered in this block will be animated
            self.animatedViewLowest.transform = CGAffineTransformTranslate( self.animatedViewLowest.transform, 330.0, 0.0  )
            self.animatedViewLowest.backgroundColor = blue
            }, completion: nil)
        
    }
    //*********************************************
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
       

        //calling animation
        animationMain()
        
    }
    
    
   
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
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        userDefaults.setObject(NSDate(), forKey: lastUsed)
        userDefaults.setObject(billField.text, forKey: lastBillAmout)
        userDefaults.synchronize()
        
    }

    
}

