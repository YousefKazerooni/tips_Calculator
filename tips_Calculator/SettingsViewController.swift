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
    //DecreaseAnimation
    @IBOutlet weak var decreaseAnimation: UIView!
    
   //diagonal animation
    @IBOutlet weak var animatedUIViewRed: UIView!
    @IBOutlet weak var animatedUIviewPurple: UIView!
    @IBOutlet weak var animatedUIViewBlack: UIView!
    //vertical animation
    
    @IBOutlet weak var animatedUIViewMorphing: UIView!
    @IBOutlet weak var animatedUIViewBlue: UIView!
    
    
    
    
    var lowest: Int=0
    var mid: Int=0
    var highest: Int=0
    
     let userDefaults = NSUserDefaults.standardUserDefaults()
    
//***************************************************
    //Animation Function
    
    func animationSettings () {
        
        //Diagonal Animation
        
        //Red Square
        UIView.animateWithDuration(2.5) { ()-> Void in
            self.animatedUIViewRed.transform = CGAffineTransformTranslate( self.animatedUIViewRed.transform, 293.0, 0.0  )
        }
        
        //Purple Square
        UIView.animateWithDuration(2.9) { ()-> Void in
            self.animatedUIviewPurple.transform = CGAffineTransformTranslate( self.animatedUIviewPurple.transform, 266.5, 0.0  )
        }
        
        //Black Square
        UIView.animateWithDuration(3.2) { ()-> Void in
            self.animatedUIViewBlack.transform = CGAffineTransformTranslate( self.animatedUIViewBlack.transform, 240.0, 0.0  )
        }
        
        
        
        //Vertical animation
        UIView.animateWithDuration(1) { ()-> Void in
            self.animatedUIViewBlue.transform = CGAffineTransformTranslate( self.animatedUIViewBlue.transform, 0.0, 126.5  )
        }
        
        //Morphing Vertical animation
        
        //defining the final color
        let blue = UIColor(red: 41.0/255.0,
            green: 0.5,
            blue: 185/255.0,
            alpha: 1.0)
        
        
        UIView.animateWithDuration(2) { ()-> Void in
            self.animatedUIViewMorphing.transform = CGAffineTransformTranslate( self.animatedUIViewMorphing.transform, 0.0, 126.5  )
            self.animatedUIViewMorphing.backgroundColor = blue
        }
    }
    
    
    //*********************************************************
    
   
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
        
        animationSettings()
        
    }
    
    
    
    
    
    
    //Changing the title of the segements

    func updatePercentageTitle () {
        tipChangeControl.setTitle("\(lowest)", forSegmentAtIndex: 0)
        tipChangeControl.setTitle("\(mid)", forSegmentAtIndex: 1)
        tipChangeControl.setTitle("\(highest)", forSegmentAtIndex: 2)
        
    }
    
    //Increasing the percentage
    
    func percentageIncrease () {
        switch tipChangeControl.selectedSegmentIndex {
        case 0 :
            lowest = ++lowest
            tipChangeControl.setTitle("\(lowest)", forSegmentAtIndex: 0)
        case 1 :
            mid = ++mid
            tipChangeControl.setTitle("\(mid)", forSegmentAtIndex: 1)
        case 2 :
            highest = ++highest
             tipChangeControl.setTitle("\(highest)", forSegmentAtIndex: 2)
        default:
            print("No increase")
        }
    }
    
    func percentageDecrease () {
        switch tipChangeControl.selectedSegmentIndex {
        case 0 :
            lowest = --lowest
            tipChangeControl.setTitle("\(lowest)", forSegmentAtIndex: 0)
        case 1 :
            mid = --mid
            tipChangeControl.setTitle("\(mid)", forSegmentAtIndex: 1)
        case 2 :
            highest = --highest
            tipChangeControl.setTitle("\(highest)", forSegmentAtIndex: 2)
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
        
    

        //animation
        
        
        UIView.animateWithDuration(1) { ()-> Void in
           self.increaseAnimation.transform = CGAffineTransformTranslate(self.increaseAnimation.transform, 0.0, 300.5  )
        }
    
    }
    
    //DECREASE: button Action
    @IBAction func decrease(sender: AnyObject) {
        percentageDecrease()
        
        
        UIView.animateWithDuration(1) { ()-> Void in
            self.decreaseAnimation.transform = CGAffineTransformTranslate( self.decreaseAnimation.transform, 0.0, 300.5  )
        }
    }
    
    
    // the "defaults%" button
    @IBAction func OriginalDefaults(sender: AnyObject) {
        lowest = 15
        tipChangeControl.setTitle("\(lowest)", forSegmentAtIndex: 0)
        
        mid = 20
        tipChangeControl.setTitle("\(mid)", forSegmentAtIndex: 1)
        
        highest = 22
        tipChangeControl.setTitle("\(highest)", forSegmentAtIndex: 2)
       
        
        
    }
    
   
    
    
    //Saving the changed values to the userDefaults
    //before leaving the view
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        userDefaults.setInteger(lowest, forKey: lowTipKey )
        userDefaults.setInteger(mid , forKey: midTipKey )
        userDefaults.setInteger(highest, forKey: highTipKey )
        
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
