//
//  WeatherModel.swift
//  HCI_WeatherApp
//
//  Created by Alina Godun on 14.04.18.
//  Copyright © 2018 Alina Godun. All rights reserved.
//

import UIKit

class WeatherModel: NSObject {
    var time: String
    var dayTemperature: String
    var weekDay: String
    var weekDayTemperature: String
    var weekMinMaxTemperature: String
    
    init(time t: String,
         dayTemperature dt: String,
         weekDay wd: String,
         weekDayTemperature wdt: String,
        weekDayMinMax wdmm: String) {
        time = t
        dayTemperature = dt
        weekDay = wd
        weekDayTemperature = wdt
        weekMinMaxTemperature = wdmm
    }
}
