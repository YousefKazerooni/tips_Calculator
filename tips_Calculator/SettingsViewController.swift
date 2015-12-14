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

    //lowest
    @IBOutlet weak var lowestTip: UILabel!
    @IBOutlet weak var lowestIncrease: UIButton!
    @IBOutlet weak var lowestDecrease: UIButton!
    //mid
    @IBOutlet weak var midTip: UILabel!
    @IBOutlet weak var midIncrease: UIButton!
    @IBOutlet weak var midDecrease: UIButton!
    //highest
    @IBOutlet weak var highestTip: UILabel!
    @IBOutlet weak var highestIncrease: UIButton!
    @IBOutlet weak var highestDecrease: UIButton!
    //back to default
    @IBOutlet weak var initialDefault: UIButton!
    
    var lowest: Int=0
    var mid: Int=0
    var highest: Int=0
    
     let userDefaults = NSUserDefaults.standardUserDefaults()
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lowest = userDefaults.integerForKey(lowTipKey)
        mid = userDefaults.integerForKey (midTipKey)
        highest = userDefaults.integerForKey(highTipKey)
    
        
        if (lowest == 0 && mid == 0 && highest == 0)
        {   lowest = 15
            mid = 20
            highest = 22}
    
        //userDefaults does not work because I created it once but then deleted it!
        
        lowestTip.text = "\(lowest)"
        midTip.text = "\(mid)"
        highestTip.text = "\(highest)"
        
        // Set up values --- ViewDid Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //buttons plus and minus
    @IBAction func lowestIncrease(sender: AnyObject) {
        lowest = ++lowest
        lowestTip.text = "\(lowest)"
        userDefaults.setInteger(lowest, forKey: lowTipKey )
    
        
        
    }

    
    @IBAction func lowestDecrease(sender: AnyObject) {
        lowest = --lowest
        lowestTip.text = "\(lowest)"
        userDefaults.setInteger(lowest, forKey: lowTipKey )
        
        
    }

    @IBAction func midIncrease(sender: AnyObject) {
        mid = ++mid
        midTip.text = "\(mid)"
        userDefaults.setInteger(mid , forKey: midTipKey )
        
    }
    
    @IBAction func midDecrease(sender: AnyObject) {
        mid = --mid
        midTip.text = "\(mid)"
        userDefaults.setInteger(mid , forKey: midTipKey )
        
    }
    
    @IBAction func highestIncrease(sender: AnyObject) {
        highest = ++highest
        highestTip.text = "\(highest)"
        userDefaults.setInteger(highest, forKey: highTipKey )
        
    }
    
    @IBAction func highestDecrease(sender: AnyObject) {
        highest = --highest
        highestTip.text = "\(highest)"
        userDefaults.setInteger(highest, forKey: highTipKey )
        
    }
    
    // the defaults button
    @IBAction func OriginalDefaults(sender: AnyObject) {
        lowest = 15
        lowestTip.text = "\(lowest)"
        userDefaults.setInteger(lowest, forKey: lowTipKey )
        
        mid = 20
        midTip.text = "\(mid)"
        userDefaults.setInteger(mid , forKey: midTipKey )
        
        highest = 22
        highestTip.text = "\(highest)"
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
