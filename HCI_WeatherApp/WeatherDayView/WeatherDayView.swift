//
//  WeatherDayView.swift
//  HCI_WeatherApp
//
//  Created by Alina Godun on 14.04.18.
//  Copyright © 2018 Alina Godun. All rights reserved.
//

//This class displays column of weather information
import UIKit

class WeatherDayView: UIView {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var todayTemperature: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var weekDayTemperature: UILabel!
    @IBOutlet weak var weekDayMinMax: UILabel!
    
    func setupWithModelData(model: WeatherModel) {
        timeLabel.text = model.time
        todayTemperature.text = model.dayTemperature
        weekDayLabel.text = model.weekDay
        weekDayTemperature.text = model.weekDayTemperature
        weekDayMinMax.text = model.weekMinMaxTemperature
    }
}
