//
//  APIManager.swift
//  HCI_WeatherApp
//
//  Created by Alina Godun on 11.04.18.
//  Copyright © 2018 Alina Godun. All rights reserved.
//

import Foundation

class APIManager {
    let forecastRequestUrl = "https://api.openweathermap.org/data/2.5/forecast?"
    let APPID = "f3487ce5aa5d51af154844e2d24c94f8"
    
    var weatherData: [String: [WeatherState]] = [:]
    
    init() {
    }
    
    func loadWeatherData(forCities cities: [City]) -> [String: [WeatherState]] {
        var weatherData = [String: [WeatherState]]()
        
        for city in cities {
            let urlString = "\(forecastRequestUrl)id=\(city.id)&APPID=\(APPID)"
            
            if let url = URL(string: urlString) {
                if let data = try? String(contentsOf: url) {
                    let json = JSON(parseJSON: data)
                    weatherData[city.id] = parse(json: json)
                }
            }
        }
        
        return weatherData
    }
    
    func parse(json: JSON) -> [WeatherState] {
        var weatherStates = [WeatherState]()
        
        for data in json["list"].arrayValue {
            let dt = NSDate(timeIntervalSince1970: data["dt"].doubleValue)
            
            let main = data["main"]
            let temperature = main["temp"].doubleValue
            let temperatureMin = main["temp_min"].doubleValue
            let temperatureMax = main["temp_max"].doubleValue
            
            let weather = data["weather"]
            let weatherDescription = weather["main"].stringValue
            let humidity = weather["humidity"].intValue
            let cloudiness = weather["cloudiness"].intValue
            
            let wind = data["wind"]
            let windSpeed = wind["speed"].doubleValue
            
            let currentState = WeatherState(time: dt, weatherDescr: weatherDescription, temp: temperature, tempMin: temperatureMin, tempMax: temperatureMax, hum: humidity, clouds: cloudiness, windSpeed: windSpeed)
            print(currentState)
            weatherStates.append(currentState)
        }
        
        return weatherStates
    }
    
    func getWeatherData(forCity city: City) -> [WeatherState]? {
        return weatherData[city.id];
    }
}
