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
    
    @IBOutlet weak var minutesSleptLabel: UILabel!
    @IBOutlet weak var barChartView: BarChartView!
    var nights = [Night]()
    
    var labels = ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun"]
    
    let today = Date()
    
    var hoursSlept: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLabels()

        setChart(values: hoursSlept)
    }
    
    func setChart(values: [Double]) {
        //To be changed.
//        guard values.count > 0 else { return }
//        let myRange = Array(1...values.count)
//        
//        var dataEntries: [BarChartDataEntry] = []
//        for i in myRange { //1...values.count
//            let dataEntry = BarChartDataEntry(x: Double(myRange[i-1]), y: values[i-1])
//            dataEntries.append(dataEntry)
//        }
        let generatedValues = generateChartValues()
        
        let chartDataSet = BarChartDataSet(values: generatedValues.entries, label: "Minutes Slept")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
       
        
        //color and ui
        barChartView.chartDescription?.text = ""
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.labelPosition = .bottom
        barChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5)
        let limitLine = ChartLimitLine(limit: 8.0, label: "Goal")
        barChartView.rightAxis.addLimitLine(limitLine)
        
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)
        
        if !UserDefaults.standard.bool(forKey: Constants.UserDefaults.sleeping) {
            chartDataSet.colors = ChartColorTemplates.vordiplom()
            barChartView.xAxis.labelTextColor = UIColor.black
            barChartView.leftAxis.labelTextColor = UIColor.black
            barChartView.rightAxis.labelTextColor = UIColor.black
            self.view.backgroundColor = UIColor(hex: "A4DEF9")
            barChartView.backgroundColor = UIColor.white
            minutesSleptLabel.textColor = UIColor.black
            limitLine.lineColor = UIColor.red
            chartData.setValueTextColor(UIColor.black)
            barChartView.legend.textColor = UIColor.black
        } else {
            chartDataSet.colors = ChartColorTemplates.pastel()
            barChartView.xAxis.labelTextColor = UIColor.white
            barChartView.rightAxis.labelTextColor = UIColor.white
            barChartView.leftAxis.labelTextColor = UIColor.white
            self.view.backgroundColor = UIColor(hex: "191919")
            barChartView.backgroundColor = UIColor(hex: "4C4C4C")
            minutesSleptLabel.textColor = UIColor(hex: "FF8000")
            limitLine.lineColor = UIColor(hex: "FF8000")
            chartData.setValueTextColor(UIColor.white)
            barChartView.legend.textColor = UIColor.white
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        barChartView.pinchZoomEnabled = false
        barChartView.doubleTapToZoomEnabled = false
        barChartView.notifyDataSetChanged()
        barChartView.reloadInputViews()
        
        nights = CoreDataHelper.retrieveNights()
        
        for night in nights {
            //guard let duration = night.duration else { return }
            hoursSlept.append(night.duration)
        }
        
        setChart(values: hoursSlept)
    }

    func generateChartValues () -> (entries: [BarChartDataEntry], labels:[String]) {
        let weekdayLabel = ["Sun","Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"]
        let weekAgo = Date(timeInterval: -60*60*24*6,since: today)
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let todayWeekDay = calendar.component(.weekday, from: today)
        var xValues: [String] = []
        for x in todayWeekDay..<todayWeekDay+7 {
            xValues.append(weekdayLabel[(x + 6 - todayWeekDay) % 7])
        }
        var arr = [[Double]]()
        for i in (1...7) {arr.append([Double]())}
        for i in (0..<nights.count).reversed() {
            print(nights[i].duration);
            let currentNight = nights[i].sleepTime! as Date
            if (currentNight > weekAgo) {
                let day = calendar.component(.weekday, from: currentNight)
                arr[day + (6-todayWeekDay) % 7].insert(nights[i].duration, at: 0)
            }
        }
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<7 {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: arr[i], data:xValues[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        return (dataEntries, xValues)
    }
    
    func getDayOfWeek () -> String {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let components = calendar!.components([.weekday], from: today as Date)
        
        switch components.weekday! {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tues"
        case 4:
            return "Wed"
        case 5:
            return "Thurs"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            return "Invalid"
    }
    }
    
    func updateLabels () {
        let weekday: String = getDayOfWeek()
        while (labels[labels.count - 1] != weekday) {
            labels.insert(labels.remove(at: labels.count - 1), at: 0)
        }
    }
}
