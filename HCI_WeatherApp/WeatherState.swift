//
//  WeatherState.swift
//  HCI_WeatherApp
//
//  Created by Alina Godun on 11.04.18.
//  Copyright © 2018 Alina Godun. All rights reserved.
//

import Foundation

struct WeatherState : CustomStringConvertible {
    var time: NSDate
    var weatherDescription: String
    
    var temperature: Double
    var temperatureMin: Double
    var temperatureMax: Double
    
    var humidity: Int
    var cloudiness: Int
    var windSpeed: Double
    
    var description: String {
        let description = String("Time: \(time) \nWeather description: \(weatherDescription)")
        let temp = String("Temperature: \(temperature) \nMinimal temperature: \(temperatureMin) \nMaximal temperature:  \(temperatureMax)")
        let other = String("Humidity: \(humidity) \nCloudiness: \(cloudiness) \nWind speed: \(windSpeed)")
        
        return description + temp + other
    }
    
    init(time _time: NSDate,
         weatherDescr _weatherDescription: String,
         temp _temperature: Double,
         tempMin _temperatureMin: Double,
         tempMax _temperatureMax: Double,
         hum _humidity: Int,
         clouds _cloudiness: Int,
         windSpeed _windSpeed: Double) {
        time = _time
        weatherDescription = _weatherDescription
        
        temperature = _temperature
        temperatureMin = _temperatureMin
        temperatureMax = _temperatureMax
        
        humidity = _humidity
        cloudiness = _cloudiness
        windSpeed = _windSpeed
    }
}
