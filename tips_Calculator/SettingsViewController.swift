//
//  SettingsViewController.swift
//  tips_Calculator
//
//  Created by Yousef Kazerooni on 12/5/15.
//  Copyright © 2015 Yousef Kazerooni. All rights reserved.
//

import UIKit

let lowTipKey = "LowTipValue"
let midTipKey = "MidTipKey"
let highTipKey = "HighTipKey"
let segIndex = "LastSegIndex"

class SettingsViewController: UIViewController {

   
    @IBOutlet weak var tipChangeControl: UISegmentedControl!
    //increase
    @IBOutlet weak var increaseButton: UIButton!
    //decrease
    @IBOutlet weak var decreaseButton: UIButton!
    //back to default
    @IBOutlet weak var initialDefault: UIButton!
    
    //drop animation
    //increaseAnimation
    @IBOutlet weak var increaseAnimation: UIView!
    //decreaseAnimation
    @IBOutlet weak var decreaseAnimation: UIView!
    
    


    
   
    
    
    
    var lowest: Int=0
    var mid: Int=0
    var highest: Int=0
    
    var counterIncrease = 1
    var counterDecrease = 1
    
     let userDefaults = NSUserDefaults.standardUserDefaults()
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Checking which segIndex was selected on the previous page
        tipChangeControl.selectedSegmentIndex = userDefaults.integerForKey(segIndex)
        
        self.increaseAnimation.alpha = 0
        self.decreaseAnimation.alpha = 0
        

        
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //After loading we check to see
        //what is the value for lowest, mid, and highest
        //in user defaults, and whether such value exists
        lowest = userDefaults.integerForKey(lowTipKey)
        mid = userDefaults.integerForKey (midTipKey)
        highest = userDefaults.integerForKey(highTipKey)
    
        
        //in case, the defaults turn up zero, i.e, the
        //app is lunched for the first time
        //we assign preset values
        if (lowest == 0 && mid == 0 && highest == 0)
        {   lowest = 15
            mid = 20
            highest = 22}
    
        
        updatePercentageTitle()
        
        
        
        
    }
    
    
    
    
    
    
    //Changing the title of the segements

    func updatePercentageTitle () {
        tipChangeControl.setTitle("\(lowest)%", forSegmentAtIndex: 0)
        tipChangeControl.setTitle("\(mid)%", forSegmentAtIndex: 1)
        tipChangeControl.setTitle("\(highest)%", forSegmentAtIndex: 2)
        
        

        
    }
    
    //Increasing the percentage
    
    func percentageIncrease () {
        switch tipChangeControl.selectedSegmentIndex {
        case 0 :
            lowest = ++lowest
            tipChangeControl.setTitle("\(lowest)%", forSegmentAtIndex: 0)
        case 1 :
            mid = ++mid
            tipChangeControl.setTitle("\(mid)%", forSegmentAtIndex: 1)
        case 2 :
            highest = ++highest
             tipChangeControl.setTitle("\(highest)%", forSegmentAtIndex: 2)
        default:
            print("No increase")
        }
    }
    
    func percentageDecrease () {
        switch tipChangeControl.selectedSegmentIndex {
        case 0 :
            lowest = --lowest
            tipChangeControl.setTitle("\(lowest)%", forSegmentAtIndex: 0)
        case 1 :
            mid = --mid
            tipChangeControl.setTitle("\(mid)%", forSegmentAtIndex: 1)
        case 2 :
            highest = --highest
            tipChangeControl.setTitle("\(highest)%", forSegmentAtIndex: 2)
        default:
            print("No decrease")
        }
    }
        
        
        
  

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    //INCREASE: button Action
    @IBAction func increase(sender: AnyObject) {
        percentageIncrease()
        
        //animation-- disregard this line
        
        counterIncrease = counterIncrease + 1
        if (counterIncrease % 2 == 0) {
            UIView.animateWithDuration(1) { ()-> Void in
                self.increaseAnimation.transform = CGAffineTransformTranslate(self.increaseAnimation.transform, 0.0, 200.5  )
        
        }
            UIView.animateWithDuration(0.5, animations: {
                // This causes first view to fade in and second view to fade out
                self.increaseAnimation.alpha = 1
                
            })
            
      }
            
        else {
        
            UIView.animateWithDuration(1) { ()-> Void in
                self.increaseAnimation.transform = CGAffineTransformTranslate(self.increaseAnimation.transform, 0.0, -200.5  )
            }
        

        }
    
    }
    
    //DECREASE: button Action
    @IBAction func decrease(sender: AnyObject) {
        percentageDecrease()
        
        counterDecrease = counterDecrease + 1
       if ( counterDecrease % 2 == 0 ) {
            UIView.animateWithDuration(1) { ()-> Void in
                self.decreaseAnimation.transform = CGAffineTransformTranslate( self.decreaseAnimation.transform, 0.0, 200.5  )
        }
            UIView.animateWithDuration(0.5, animations: {
                // This causes first view to fade in and second view to fade out
                self.decreaseAnimation.alpha = 1
                
            })
      }
            
            
       else {
        
                UIView.animateWithDuration(1) { ()-> Void in
                    self.decreaseAnimation.transform = CGAffineTransformTranslate( self.decreaseAnimation.transform, 0.0, -200.5  )
                }
            }
       
       }
    
    
    
    
    // the "defaults%" button
    @IBAction func OriginalDefaults(sender: AnyObject) {
        lowest = 15
        tipChangeControl.setTitle("\(lowest)%", forSegmentAtIndex: 0)
        
        mid = 20
        tipChangeControl.setTitle("\(mid)%", forSegmentAtIndex: 1)
        
        highest = 22
        tipChangeControl.setTitle("\(highest)%", forSegmentAtIndex: 2)
       
        
        
    }
    
    

    
    
    //Saving the changed values to the userDefaults
    //before leaving the view
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        userDefaults.setInteger(lowest, forKey: lowTipKey )
        userDefaults.setInteger(mid , forKey: midTipKey )
        userDefaults.setInteger(highest, forKey: highTipKey )
        
        //Capturing which index is selected
        userDefaults.setInteger(tipChangeControl.selectedSegmentIndex, forKey: segIndex)
        
    }
    
 
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
