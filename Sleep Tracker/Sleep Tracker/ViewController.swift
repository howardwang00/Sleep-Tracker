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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sleepButton.layer.cornerRadius = 12
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sleepButtonPressed(_ sender: UIButton) {
        
    }


}

