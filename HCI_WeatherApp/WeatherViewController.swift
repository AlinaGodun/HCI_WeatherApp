//
//  WeatherViewController.swift
//  HCI_WeatherApp
//
//  Created by Alina Godun on 08.04.18.
//  Copyright © 2018 Alina Godun. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet var currentTemperature: UILabel!
    @IBOutlet var todayMin: UILabel!
    @IBOutlet var todayMax: UILabel!
    @IBOutlet var cityNameLabel: UILabel!
    
    var weatherManager: WeatherManager?
    var cityName : String?
    var cityID: String?
    
    var dayTimeLabels = [UILabel]()
    var dayTemperatureLabels = [UILabel]()
    
    var weekDaysLabels = [UILabel]()
    var weekTemperatureLabels = [UILabel]()
    var weekMinMaxLabels = [UILabel]()
    
    let weekDaysNames = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityNameLabel.text = cityName
        
        currentTemperature.text = "\(Int(round((weatherManager?.currentState.temperature)!)))°"
        todayMin.text = "today's min: \(Int(round((weatherManager?.currentState.temperatureMin)!)))°"
        todayMax.text = "today's min: \(Int(round((weatherManager?.currentState.temperatureMax)!)))°"

        mapLabelsToArrays()
        initialize()
    }
    
    //This method gathers view's labels into arrays
    func mapLabelsToArrays() {
        for sb in view.subviews where sb.tag == 1001 {
            for subview in sb.subviews {
                let label = subview as! UILabel
                dayTimeLabels.append(label)
            }
        }
        
        for sb in view.subviews where sb.tag == 1002 {
            for subview in sb.subviews {
                let label = subview as! UILabel
                dayTemperatureLabels.append(label)
            }
        }
        
        for subview in view.subviews where subview.tag == 1003 {
            let label = subview as! UILabel
            weekDaysLabels.append(label)
        }
        
        for sb in view.subviews where sb.tag == 1004 {
            for subview in sb.subviews {
                let label = subview as! UILabel
                weekTemperatureLabels.append(label)
            }
        }
        
        for sb in view.subviews where sb.tag == 1005 {
            for subview in sb.subviews  {
                let label = subview as! UILabel
                weekMinMaxLabels.append(label)
            }
        }
    }
    
    //This method and it's derived once initialize labels with computed values
    func initialize() {
        initializeDayTimes()
        initializeDayTemperatures()
        initializeWeekDays()
        initializeWeekTemperatures()
        initializeWeekMinMax()
    }
    
    func initializeDayTimes() {
        let times = weatherManager?.getDayTimes()
        if (dayTimeLabels.count == times?.count) {
            dayTimeLabels[0].text = "Now"
            for i in 1 ..< dayTimeLabels.count {
                let time = (times![i] < 10 ? "0" : "") + "\(times![i]):00"
                dayTimeLabels[i].text = String("\(time)")
            }
        }
    }
    
    func initializeDayTemperatures() {
        let temperatures = weatherManager?.getDayTemperatures()
        if (dayTemperatureLabels.count == temperatures?.count) {
            for i in 0 ..< dayTemperatureLabels.count {
                dayTemperatureLabels[i].text = String("\(temperatures![i])°")
            }
        }
    }
    
    func initializeWeekDays() {
        let weekDays = weatherManager?.getWeekDays()
        if (weekDaysLabels.count == weekDays?.count) {
            weekDaysLabels[0].text = "Today"
            for i in 1 ..< weekDaysLabels.count {
                weekDaysLabels[i].text = String("\(weekDaysNames[weekDays![i]])")
            }
        }
    }
    
    func initializeWeekTemperatures() {
        let weekTemperatures = weatherManager?.getWeekTemperatures(forTemperatureType: .middle)
        if weekTemperatureLabels.count == weekTemperatures?.count {
            for i in 0 ..< weekTemperatureLabels.count {
                let weekTemp = String("\(weekTemperatures![i])°")
                weekTemperatureLabels[i].text = weekTemp
            }
        }
    }
    
    func initializeWeekMinMax() {
        let weekMin = weatherManager?.getWeekTemperatures(forTemperatureType: .min)
        let weekMax = weatherManager?.getWeekTemperatures(forTemperatureType: .max)
        if weekTemperatureLabels.count == weekMin?.count && weekTemperatureLabels.count == weekMax?.count{
            for i in 0 ..< weekTemperatureLabels.count {
                weekTemperatureLabels[i].text = String("\(weekMin![i])° | \(weekMax![i])°")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
