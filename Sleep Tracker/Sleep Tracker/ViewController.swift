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
    @IBOutlet weak var moon: UIImageView!
    @IBOutlet weak var firstStar: UIImageView!
    @IBOutlet weak var secondStar: UIImageView!
    @IBOutlet weak var thirdStar: UIImageView!
    @IBOutlet weak var fourthStar: UIImageView!
    @IBOutlet weak var sun: UIImageView!
    @IBOutlet weak var firstCloud: UIImageView!
    @IBOutlet weak var secondCloud: UIImageView!
    
    var nights = [Night]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("View Did Load")
        print("Sleeping: \(UserDefaults.standard.bool(forKey: Constants.UserDefaults.sleeping))")
        
        nights = CoreDataHelper.retrieveNights()
        
        // Do any additional setup after loading the view, typically from a nib.
        sleepButton.layer.cornerRadius = 12
        
        if !UserDefaults.standard.bool(forKey: Constants.UserDefaults.sleeping) {
            tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "sun icon-1"), tag: 0)
            
            self.sleepButton.backgroundColor = UIColor(hex: "97F9F9")
            self.view.backgroundColor = UIColor(hex: "A4DEF9")
            self.sleepButton.setTitleColor(UIColor(hex: "000000"), for: UIControlState.normal)
            
            self.firstZ.alpha = 0
            self.secondZ.alpha = 0
            self.thirdZ.alpha = 0
            
            self.moon.alpha = 0
            self.firstStar.alpha = 0
            self.secondStar.alpha = 0
            self.thirdStar.alpha = 0
            self.fourthStar.alpha = 0
            
            self.sun.alpha = 1
            self.firstCloud.alpha = 1
            self.secondCloud.alpha = 1
            
            
        } else {
            tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "moon icon1-1"), tag: 0)
            
            self.sleepButton.backgroundColor = UIColor(hex: "333333")
            self.view.backgroundColor = UIColor(hex: "191919")
            self.sleepButton.setTitleColor(UIColor(hex: "FF8000"), for: UIControlState.normal)
            self.sleepButton.setTitle("Wake Up", for: UIControlState.normal)

            self.firstZ.alpha = 1
            self.secondZ.alpha = 1
            self.thirdZ.alpha = 1
            
            self.moon.alpha = 1
            self.firstStar.alpha = 1
            self.secondStar.alpha = 1
            self.thirdStar.alpha = 1
            self.fourthStar.alpha = 1
            
            self.sun.alpha = 0
            self.firstCloud.alpha = 0
            self.secondCloud.alpha = 0

            
            
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sleepButtonPressed(_ sender: UIButton) {
        print("Sleep Button Pressed")
        
        UserDefaults.standard.set(!UserDefaults.standard.bool(forKey: Constants.UserDefaults.sleeping), forKey: Constants.UserDefaults.sleeping)
        
        if UserDefaults.standard.bool(forKey: Constants.UserDefaults.sleeping) {
            if nights.count >= 7 {
                nights.remove(at: 0)
            }
            nights.append(CoreDataHelper.createNight())
            nights[nights.count - 1].sleepTime = Date() as NSDate
            CoreDataHelper.saveCoreData()
            
            //animate to dark
            
            tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Cloud-Moon-icon"), tag: 0)
            
            UIButton.animate(withDuration: 2, animations: {
                self.sleepButton.backgroundColor = UIColor(hex: "333333")
                self.view.backgroundColor = UIColor(hex: "191919")
                self.sleepButton.setTitleColor(UIColor(hex: "FF8000"), for: UIControlState.normal)
                self.sleepButton.setTitle("Wake Up", for: UIControlState.normal)
                
                self.firstZ.alpha = 1
                self.secondZ.alpha = 1
                self.thirdZ.alpha = 1
                
                self.moon.alpha = 1
                self.firstStar.alpha = 1
                self.secondStar.alpha = 1
                self.thirdStar.alpha = 1
                self.fourthStar.alpha = 1
                
                self.sun.alpha = 0
                self.firstCloud.alpha = 0
                self.secondCloud.alpha = 0
            
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
                UIButton.animate(withDuration: 1, delay: 0.25, options: [.autoreverse, .repeat],animations: {
                    self.firstStar.alpha -= 1
                })
                UIButton.animate(withDuration: 2, delay: 0.25, options: [.autoreverse, .repeat],animations: {
                    self.secondStar.alpha -= 1
                })
                UIButton.animate(withDuration: 3, delay: 0.25, options: [.autoreverse, .repeat],animations: {
                    self.thirdStar.alpha -= 1
                })
                UIButton.animate(withDuration: 1.5, delay: 0.25, options: [.autoreverse, .repeat],animations: {
                    self.fourthStar.alpha -= 1
                })
            }
            firstCloud.layer.removeAllAnimations()
            secondCloud.layer.removeAllAnimations()
            sun.layer.removeAllAnimations()

        } else {
            //animate to light
            
            tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Sun-icon-1"), tag: 0)
            
            UIButton.animate(withDuration: 2, animations:
                {
                self.sleepButton.backgroundColor = UIColor(hex: "97F9F9")
                self.view.backgroundColor = UIColor(hex: "A4DEF9")
                self.sleepButton.setTitleColor(UIColor(hex: "000000"), for: UIControlState.normal)
                self.sleepButton.setTitle("Go To Sleep", for: UIControlState.normal)
                    
                self.firstZ.alpha = 0
                self.secondZ.alpha = 0
                self.thirdZ.alpha = 0
                    
                self.moon.alpha = 0
                self.firstStar.alpha = 0
                self.secondStar.alpha = 0
                self.thirdStar.alpha = 0
                self.fourthStar.alpha = 0
                    
                self.sun.alpha = 1
                self.firstCloud.alpha = 1
                self.secondCloud.alpha = 1

            })
            UIButton.animate(withDuration: 1, delay: 0.25, options: [.autoreverse, .repeat],animations: {
                self.firstCloud.frame.origin.x += 15
            })
            UIButton.animate(withDuration: 2, delay: 0.25, options: [.autoreverse, .repeat],animations: {
                self.secondCloud.frame.origin.x -= 10
            })
            UIButton.animate(withDuration: 1.5, delay: 0.25, options: [.autoreverse, .repeat],animations: {
                self.sun.transform = CGAffineTransform(rotationAngle: 20)
            })
            
            firstZ.layer.removeAllAnimations()
            secondZ.layer.removeAllAnimations()
            thirdZ.layer.removeAllAnimations()
            
            firstStar.layer.removeAllAnimations()
            secondStar.layer.removeAllAnimations()
            thirdStar.layer.removeAllAnimations()
            fourthStar.layer.removeAllAnimations()

            firstZ.frame.origin.y = 529
            secondZ.frame.origin.y = 476
            thirdZ.frame.origin.y = 441
            
            let night = nights[nights.count - 1]
            night.wakeTime = Date() as NSDate
            let timeDifference = night.wakeTime!.timeIntervalSinceReferenceDate - night.sleepTime!.timeIntervalSinceReferenceDate
            night.duration = CoreDataHelper.roundNightDuration(duration: timeDifference / 60.0) //Conversion from seconds to minutes (change to hours for official)
            
            CoreDataHelper.saveCoreData()
            print("Duration: \(night.duration)")

        }
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View Did Appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("View Will Disappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("View Did Disappear")
    }
    
}

