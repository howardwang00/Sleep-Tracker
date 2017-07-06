//
//  StatisticsController.swift
//  Sleep Tracker
//
//  Created by Jacob Kim on 7/5/17.
//  Copyright © 2017 Howard Wang. All rights reserved.
//

import Foundation
import UIKit
import Charts

class StatisticsController: UIViewController {
    
    @IBOutlet weak var barChartView: BarChartView!
    var nights = [Night]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nights = CoreDataHelper.retrieveNights()
//        var hoursSlept: [Double] = []
//        for night in nights {
//             hoursSlept.append(night.duration)
//        }
        let hoursSlept:[Double] = [3.0, 10.0, 5.0]
        setChart(values: hoursSlept)
    }
    func setChart(values: [Double]) {
        //To be changed.
        let myRange = Array(1...values.count)
        
        var dataEntries: [BarChartDataEntry] = []
        for i in 1...values.count {
            let dataEntry = BarChartDataEntry(x: Double(myRange[i-1]), y: values[i-1])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Hours Slept")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        
    }
}
