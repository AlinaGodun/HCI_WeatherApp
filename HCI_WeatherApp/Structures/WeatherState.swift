//
//  WeatherState.swift
//  HCI_WeatherApp
//
//  Created by Alina Godun on 11.04.18.
//  Copyright © 2018 Alina Godun. All rights reserved.
//

import Foundation

struct WeatherState : CustomStringConvertible {
    var date: Date
    var weatherDescription: String
    
    var temperature: Double
    var temperatureMin: Double
    var temperatureMax: Double
    
    var humidity: Int
    var cloudiness: Int
    var windSpeed: Double
    
    var description: String {
        let description = String("Date: \(date) \nWeather description: \(weatherDescription)\n")
        let temp = String("Temperature: \(temperature) \nMinimal temperature: \(temperatureMin) \nMaximal temperature:  \(temperatureMax)\n")
        let other = String("Humidity: \(humidity) \nCloudiness: \(cloudiness) \nWind speed: \(windSpeed)")
        
        return description + temp + other
    }
    
    init(date _date: Date,
         weatherDescr _weatherDescription: String,
         temp _temperature: Double,
         tempMin _temperatureMin: Double,
         tempMax _temperatureMax: Double,
         hum _humidity: Int,
         clouds _cloudiness: Int,
         windSpeed _windSpeed: Double) {
        date = _date
        weatherDescription = _weatherDescription
        
        temperature = _temperature
        temperatureMin = _temperatureMin
        temperatureMax = _temperatureMax
        
        humidity = _humidity
        cloudiness = _cloudiness
        windSpeed = _windSpeed
    }
}
