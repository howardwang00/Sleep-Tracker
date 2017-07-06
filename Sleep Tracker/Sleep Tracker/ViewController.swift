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
    //var currentNight: Night?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //currentNight = CoreDataHelper.returnNight()
        //sleeping = Sleeping.sleeping
        
        // Do any additional setup after loading the view, typically from a nib.
        sleepButton.layer.cornerRadius = 12
        
        if (sleeping == false) {
            self.sleepButton.backgroundColor = UIColor(hex: "97F9F9")
            self.view.backgroundColor = UIColor(hex: "A4DEF9")
            self.sleepButton.setTitleColor(UIColor(hex: "000000"), for: UIControlState.normal)
            
            self.firstZ.alpha = 0
            self.secondZ.alpha = 0
            self.thirdZ.alpha = 0
            
        } else {
            self.sleepButton.backgroundColor = UIColor(hex: "333333")
            self.view.backgroundColor = UIColor(hex: "191919")
            self.sleepButton.setTitleColor(UIColor(hex: "FF8000"), for: UIControlState.normal)
            self.sleepButton.setTitle("Wake Up:", for: UIControlState.normal)

            self.firstZ.alpha = 1
            self.secondZ.alpha = 1
            self.thirdZ.alpha = 1
            
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
                
                self.firstZ.alpha = 1
                self.secondZ.alpha = 1
                self.thirdZ.alpha = 1
            
            }) { _ in
                UIButton.animate(withDuration: 2, delay: 0.25, options: [.autoreverse, .repeat],animations: {
                    self.firstZ.frame.origin.y -= 20
                })
                UIButton.animate(withDuration: 1.5, delay: 0.25, options: [.autoreverse, .repeat],animations: {
                    self.secondZ.frame.origin.y += 15
                })
                UIButton.animate(withDuration: 1, delay: 0.25, options: [.autoreverse, .repeat],animations: {
                    self.thirdZ.frame.origin.y -= 10
                })
            }

            //currentNight.sleepTime = NSDate()

        } else {
            //animate to light
            UIButton.animate(withDuration: 2, animations:
                {
                self.sleepButton.backgroundColor = UIColor(hex: "97F9F9")
                self.view.backgroundColor = UIColor(hex: "A4DEF9")
                self.sleepButton.setTitleColor(UIColor(hex: "000000"), for: UIControlState.normal)
                self.sleepButton.setTitle("Go To Sleep", for: UIControlState.normal)
                    
                self.firstZ.alpha = 0
                self.secondZ.alpha = 0
                self.thirdZ.alpha = 0

            })
            firstZ.layer.removeAllAnimations()
            secondZ.layer.removeAllAnimations()
            thirdZ.layer.removeAllAnimations()

            firstZ.frame.origin.y = 529
            secondZ.frame.origin.y = 476
            thirdZ.frame.origin.y = 441
            

            //currentNight.wakeTime = NSDate()
            //currentNight.duration = currentNight.wakeTime!.timeIntervalSinceReferenceDate - currentNight.sleepTime!.timeIntervalSinceReferenceDate

        }
    }


}

