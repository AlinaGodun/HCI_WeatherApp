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
    
    var cityName : String?
    var cityID: String?
    
    var dayTimeLabels = [UILabel]()
    var dayTemperatureLabels = [UILabel]()
    
    var dayTimes = ["Now", "20:00", "23:00", "02:00", "05:00", "08:00", "11:00"]
    var dayTemperatures = ["23", "20", "18", "18", "19", "21", "22"]
    
    //    var dayTimes = [String]()
    //    var dayTemperatures = [String]()
    
    var weekDaysLabels = [UILabel]()
    var weekTemperatureLabels = [UILabel]()
    var weekMinMaxLabels = [UILabel]()
    
    let weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    var weekTemperature = ["23", "14", "18", "19", "22", "20", "18"]
    var weekMin = ["15", "14", "17", "17", "20", "17", "13"]
    var weekMax = ["29", "21", "32", "20", "22", "21", "19"]
    
    //    var weekTemperatures = [String]()
    //    var weekMins = [String]()
    //    var weekMaxs = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = cityName {
            cityNameLabel.text = name
        }
        
        currentTemperature.text = "21°"
        todayMin.text = "today's min: 17°"
        todayMax.text = "today's max: 23°"

        mapLabelsToArrays()
        fillLabels()
        print("good")
        // Do any additional setup after loading the view.
    }
    
    func mapLabelsToArrays() {
        for subview in view.subviews where subview.tag == 1001 {
            let label = subview as! UILabel
            dayTimeLabels.append(label)
        }
        
        for subview in view.subviews where subview.tag == 1002 {
            let label = subview as! UILabel
            dayTemperatureLabels.append(label)
        }
        
        for subview in view.subviews where subview.tag == 1003 {
            let label = subview as! UILabel
            weekDaysLabels.append(label)
        }
        
        for subview in view.subviews where subview.tag == 1004 {
            let label = subview as! UILabel
            weekTemperatureLabels.append(label)
        }
        
        for subview in view.subviews where subview.tag == 1005 {
            let label = subview as! UILabel
            weekMinMaxLabels.append(label)
        }
    }
    
    func fillLabels() {
        if (dayTimeLabels.count == dayTimes.count) {
            for i in 0 ..< dayTimeLabels.count {
                dayTimeLabels[i].text = dayTimes[i]
            }
        }
        
        if (dayTemperatureLabels.count == dayTemperatures.count) {
            for i in 0 ..< dayTemperatureLabels.count {
                dayTemperatureLabels[i].text = dayTemperatures[i] + "°"
            }
        }
        
        if (weekDaysLabels.count == weekDays.count) {
            for i in 0 ..< weekDaysLabels.count {
                weekDaysLabels[i].text = weekDays[i]
            }
        }
        
        if (weekTemperatureLabels.count == weekTemperature.count) {
            for i in 0 ..< weekTemperatureLabels.count {
                weekTemperatureLabels[i].text = weekTemperature[i]
            }
        }
        
        if (weekMinMaxLabels.count == weekMin.count && weekMin.count == weekMax.count) {
            for i in 0 ..< weekMinMaxLabels.count {
                weekMinMaxLabels[i].text = weekMin[i]  + "° | " + weekMax[i] + "°"
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
