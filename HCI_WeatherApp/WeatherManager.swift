//
//  WeatherManager.swift
//  HCI_WeatherApp
//
//  Created by Alina Godun on 11.04.18.
//  Copyright © 2018 Alina Godun. All rights reserved.
//

import UIKit

class WeatherManager {
    let weatherStates: [WeatherState]
    var weatherForDays: [Int: [WeatherState]] = [:]
    var currentState: WeatherState
    
    init (forStates _weatherStates: [WeatherState]) {
        weatherStates = _weatherStates
        currentState = weatherStates[0]
        loadWeatherForDays()
    }
    
    func loadWeatherForDays() {
        var day = getWeekDay(date: currentState.date)
        var dayWeather = [WeatherState]()

        for weatherState in weatherStates {
            let currentDay = getWeekDay(date: weatherState.date)
            
            if (day != currentDay) {
                weatherForDays[day] = dayWeather
                
                dayWeather.removeAll()
                day = currentDay
            }
            
            dayWeather.append(weatherState)
        }
        
        weatherForDays[day] = dayWeather
    }
    
    func getWeekTemperatures(temperatureType tempType: String) -> [Int] {
        var result = Array(repeating: 0, count: 7)
        for day in weatherForDays.keys {
            let dayTemperatures = get(temperatureType: tempType, forDay: day)
            result[day] = getAverage(for: dayTemperatures)
        }
        return adjustDayOrder(for: result)
    }
    
    func get(temperatureType tempType: String, forDay day: Int) -> [Double] {
        var result = [Double]()
        func get(forWeatherState ws: WeatherState) -> Double {
            switch (tempType) {
            case "temp" : return ws.temperature
            case "tempMin" : return ws.temperatureMin
            case "tempMax" : return ws.temperatureMax
            default : return 0.0
            }
        }
        
        for weatherState in weatherForDays[day]! {
            result.append(get(forWeatherState: weatherState))
        }
        
        return result;
    }
    
    func getAverage(for array: [Double]) -> Int {
        var sum = 0.0
        for num in array {
            sum += num
        }
        let average = sum/Double(array.count)
        return Int(round(average))
    }
    
    func adjustDayOrder(for array: [Int]) -> [Int]{
        let days = getWeekDays()
        var result = [Int]()
        for day in days {
            result.append(array[day])
        }
        return result
    }
    
    func getWeekDays() -> [Int] {
        var dayCounter = getWeekDay(date: currentState.date)
        var result = [Int]()
        
        while (result.count < 6 && dayCounter < 7) {
            result.append(dayCounter)
            dayCounter += 1
        }
        
        let daysFromBeginning = 6 - result.count
        for i in 0 ..< daysFromBeginning {
            result.append(i)
        }
        return result
    }
    
    func getWeekDay(date: Date) -> Int {
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.weekday], from: date)
        var dayOfWeek = comp.weekday! - 2
        
        if dayOfWeek < 0 {
            dayOfWeek += 7
        }
        return dayOfWeek
    }
}
