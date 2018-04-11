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
    
    func getMockData (forCities cities: [City]) -> [String: [WeatherState]] {
        var weatherData = [String: [WeatherState]]()
        
        if let mockDataFilePath = Bundle.main.path(forResource: "mockData", ofType: ".txt") {
            if let mockContents = try? String(contentsOfFile: mockDataFilePath) {
                let json = JSON(parseJSON: mockContents)
                let weatherStates = parse(json: json)
                
                for city in cities {
                    weatherData[city.id] = weatherStates
                }
            }
        }
        
        return weatherData
    }
    
    func getWeatherData(forCities cities: [City]) -> [String: [WeatherState]] {
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
            
            let temperature = data["main"]["temp"].doubleValue
            let temperatureMin = data["main"]["temp_min"].doubleValue
            let temperatureMax = data["main"]["temp_max"].doubleValue
            let humidity = data["main"]["humidity"].intValue
            
            let weather = data["weather"].arrayValue
            let weatherDescription = weather[0]["description"].stringValue
            
            let cloudiness = data["clouds"]["all"].intValue
            let windSpeed = data["wind"]["speed"].doubleValue
            
            let currentState = WeatherState(time: dt, weatherDescr: weatherDescription, temp: temperature, tempMin: temperatureMin, tempMax: temperatureMax, hum: humidity, clouds: cloudiness, windSpeed: windSpeed)
            
            weatherStates.append(currentState)
        }
        
        return weatherStates
    }
}
