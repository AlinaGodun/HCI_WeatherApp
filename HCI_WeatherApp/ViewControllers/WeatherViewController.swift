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
    @IBOutlet weak var weekWeatherStackView: UIStackView!
    
    var weatherManager: WeatherManager?
    var cityName : String?
    var cityID: String?
    
    var dayTimeLabels = [UILabel]()
    var dayTemperatureLabels = [UILabel]()
    
    var weekDaysLabels = [UILabel]()
    var weekTemperatureLabels = [UILabel]()
    var weekMinMaxLabels = [UILabel]()
    
    let weekDaysNames = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    var modelArray: [WeatherModel] = [WeatherModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityNameLabel.text = cityName
        
        currentTemperature.text = "\(Int(round((weatherManager?.currentState.temperature)!)))°"
        todayMin.text = "current min: \(Int(round((weatherManager?.currentState.temperatureMin)!)))°"
        todayMax.text = "current max: \(Int(round((weatherManager?.currentState.temperatureMax)!)))°"
        
        fillModelWithData()
        fillUIWithData()
    }
    
    //This method creates array of data for WeatherDayView
    func fillModelWithData() {
        let times = weatherManager?.getDayTimes()
        let temperatures = weatherManager?.getDayTemperatures()
        let weekDays = weatherManager?.getWeekDays()
        let weekTemperatures = weatherManager?.getWeekTemperatures(forTemperatureType: .middle)
        let weekMin = weatherManager?.getWeekTemperatures(forTemperatureType: .min)
        let weekMax = weatherManager?.getWeekTemperatures(forTemperatureType: .max)
        
        for i in 0 ..< 6 {
            let time = (times![i] < 10 ? "0" : "") + "\(times![i]):00"
            let temperature = "\(temperatures![i])°"
            let weekDay = "\(weekDaysNames[weekDays![i]])"
            let weekDayTemperature = "\(weekTemperatures![i])°"
            let weekDayMinMax = "\(weekMin![i])° | \(weekMax![i])°"
            
            let wm = WeatherModel(time: time, dayTemperature: temperature, weekDay: weekDay, weekDayTemperature: weekDayTemperature, weekDayMinMax: weekDayMinMax)
            modelArray.append(wm)
        }
    }
    
    //This method puts columns with information on the screen
    func fillUIWithData() {
        weekWeatherStackView.axis  = UILayoutConstraintAxis.horizontal
        weekWeatherStackView.distribution  = UIStackViewDistribution.equalSpacing
        weekWeatherStackView.alignment = UIStackViewAlignment.center
        weekWeatherStackView.spacing   = 5.0
        
        for model: WeatherModel in modelArray {
            let dayView: WeatherDayView = .fromNib()
            dayView.setupWithModelData(model: model)
            weekWeatherStackView.addArrangedSubview(dayView)
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
