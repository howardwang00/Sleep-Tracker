//
//  ViewController.swift
//  Sleep Tracker
//
//  Created by Howard Wang on 7/5/17.
//  Copyright © 2017 Howard Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sleepButton: UIButton!
    @IBOutlet weak var firstZ: UILabel!
    @IBOutlet weak var secondZ: UILabel!
    @IBOutlet weak var thirdZ: UILabel!
    
    var sleeping: Bool = false
    var currentNight = Night()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sleepButton.layer.cornerRadius = 12
        
        //Get sleeping from CoreData
        
        if (sleeping == false) {
            self.sleepButton.backgroundColor = UIColor(hex: "97F9F9")
            self.view.backgroundColor = UIColor(hex: "A4DEF9")
            self.sleepButton.setTitleColor(UIColor(hex: "000000"), for: UIControlState.normal)
            
            self.firstZ.textColor = UIColor(hex: "A4DEF9")
            self.secondZ.textColor = UIColor(hex: "A4DEF9")
            self.thirdZ.textColor = UIColor(hex: "A4DEF9")
        } else {
            self.sleepButton.backgroundColor = UIColor(hex: "333333")
            self.view.backgroundColor = UIColor(hex: "191919")
            self.sleepButton.setTitleColor(UIColor(hex: "FF8000"), for: UIControlState.normal)
            self.sleepButton.setTitle("Wake Up:", for: UIControlState.normal)

            self.firstZ.textColor = UIColor.white
            self.secondZ.textColor = UIColor.white
            self.thirdZ.textColor = UIColor.white
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sleepButtonPressed(_ sender: UIButton) {
        sleeping = !sleeping
        if (sleeping == true) {
            //animate to dark
            UIButton.animate(withDuration: 2, animations: {
                self.sleepButton.backgroundColor = UIColor(hex: "333333")
                self.view.backgroundColor = UIColor(hex: "191919")
                self.sleepButton.setTitleColor(UIColor(hex: "FF8000"), for: UIControlState.normal)
                self.sleepButton.setTitle("Wake Up", for: UIControlState.normal)
                
                UIView.transition(with: self.firstZ, duration: 0.3, options: .transitionCrossDissolve, animations: { self.firstZ.textColor = UIColor.white }, completion: nil)
                UIView.transition(with: self.secondZ, duration: 0.3, options: .transitionCrossDissolve, animations: { self.secondZ.textColor = UIColor.white }, completion: nil)
                UIView.transition(with: self.thirdZ, duration: 0.3, options: .transitionCrossDissolve, animations: { self.thirdZ.textColor = UIColor.white }, completion: nil)
            
            }) { _ in
                UIButton.animate(withDuration: 2, delay: 0.25, options: [.autoreverse, .repeat],animations: {
                    self.firstZ.frame.origin.y -= 20
                    self.secondZ.frame.origin.y += 15
                    self.thirdZ.frame.origin.y += 10
                })
            }
        
            currentNight.sleepTime = NSDate()
        } else {
            //animate to light
            UIButton.animate(withDuration: 2, animations:
                {
                self.sleepButton.backgroundColor = UIColor(hex: "97F9F9")
                self.view.backgroundColor = UIColor(hex: "A4DEF9")
                self.sleepButton.setTitleColor(UIColor(hex: "000000"), for: UIControlState.normal)
                self.sleepButton.setTitle("Go To Sleep", for: UIControlState.normal)
                    
                    UIView.transition(with: self.firstZ, duration: 0.3, options: .transitionCrossDissolve, animations: { self.firstZ.textColor = UIColor(hex: "A4DEF9") }, completion: nil)
                    UIView.transition(with: self.secondZ, duration: 0.3, options: .transitionCrossDissolve, animations: { self.secondZ.textColor = UIColor(hex: "A4DEF9") }, completion: nil)
                    UIView.transition(with: self.thirdZ, duration: 0.3, options: .transitionCrossDissolve, animations: { self.thirdZ.textColor = UIColor(hex: "A4DEF9") }, completion: nil)
            })
            firstZ.layer.removeAllAnimations()
            secondZ.layer.removeAllAnimations()
            thirdZ.layer.removeAllAnimations()
            
            currentNight.wakeTime = NSDate()
            currentNight.duration = currentNight.wakeTime!.timeIntervalSinceReferenceDate - currentNight.sleepTime!.timeIntervalSinceReferenceDate
        }
    }


}

