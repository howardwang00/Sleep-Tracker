//
//  StatisticsController.swift
//  Sleep Tracker
//
//  Created by Jacob Kim on 7/5/17.
//  Copyright © 2017 Howard Wang. All rights reserved.
//

import Foundation
import UIKit

class StatisticsController: UIViewController {
    
    var nights = [Night]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nights = CoreDataHelper.retrieveNights()
    }
}
