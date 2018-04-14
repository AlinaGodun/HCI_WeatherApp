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
    
    static let numberOfDaysInWeek = 7
    static let arraySize = 6    //size of array containing labels in the view
    
    init (forStates _weatherStates: [WeatherState]) {
        weatherStates = _weatherStates
        currentState = weatherStates[0]
        loadWeatherForDays()
    }
    
    //This method analyses array of weatherStates and maps weatherStates to the day the belong to
    func loadWeatherForDays() {
        var day = getWeekDayNumber(date: currentState.date)
        var dayWeather = [WeatherState]()

        for weatherState in weatherStates {
            let currentDay = getWeekDayNumber(date: weatherState.date)
            
            if (day != currentDay) {
                weatherForDays[day] = dayWeather
                
                dayWeather.removeAll()
                day = currentDay
            }
            
            dayWeather.append(weatherState)
        }
        
        weatherForDays[day] = dayWeather
    }
    
    func getDayTimes(_ day: Int = 0) -> [Int] {
        let today = getWeekDays()[day]
        let weatherToday = weatherForDays[today]
        let calendar = Calendar.current
        var result = [Int]()
        
        for weather in weatherToday! {
            let hour = calendar.component(.hour, from: weather.date)
            result.append(hour)
             if result.count == WeatherManager.arraySize {
                break
            }
        }

        if result.count < WeatherManager.arraySize && day == 0 {
            let tomorrow = day + 1
            result.append(contentsOf: getDayTimes(tomorrow))
        }
        
        return result
    }

    func getDayTemperatures(_ day: Int = 0) -> [Int] {
        let today = getWeekDays()[day]
        let weatherToday = weatherForDays[today]
        var result = [Int]()
        
        for weather in weatherToday! {
            let temperature = Int(round(weather.temperature))
            result.append(temperature)
            if result.count == WeatherManager.arraySize {
                break
            }
        }
        
        if result.count < WeatherManager.arraySize && day == 0 {
            let tomorrow = day + 1
            result.append(contentsOf: getDayTemperatures(tomorrow))
        }
        
        return result
    }
    
    //This method returns array containing numbers of week days starting with today
    func getWeekDays() -> [Int] {
        var dayCounter = getWeekDayNumber(date: currentState.date)
        var result = [Int]()
        
        while (result.count < WeatherManager.arraySize && dayCounter < WeatherManager.numberOfDaysInWeek) {
            result.append(dayCounter)
            dayCounter += 1
        }
        
        let daysFromBeginning = WeatherManager.arraySize - result.count
        for i in 0 ..< daysFromBeginning {
            result.append(i)
        }
        return result
    }
    
    //This method returns weekTemperature.
    //forTemperatureType specifies which temperature to be returned: middle, min or max
    func getWeekTemperatures(forTemperatureType tempType: TemperatureType) -> [Int] {
        var result = Array(repeating: 0, count: WeatherManager.numberOfDaysInWeek)
        for day in weatherForDays.keys {
            let dayTemperatures = get(forTemperatureType: tempType, forDay: day)
            result[day] = getAverage(for: dayTemperatures)
        }
        return adjustDayOrder(for: result)
    }
    
    //Helper methods
    
    //This method gets array of temperatures.
    //forTemperatureType states which temperatures need to be returen: middle, minimum or maximum.
    //forDay states for which day should it be made
    func get(forTemperatureType tempType: TemperatureType, forDay day: Int) -> [Double] {
        var result = [Double]()
        func get(forWeatherState ws: WeatherState) -> Double {
            switch (tempType) {
            case .middle : return ws.temperature
            case .min : return ws.temperatureMin
            case .max : return ws.temperatureMax
            }
        }
        
        for weatherState in weatherForDays[day]! {
            result.append(get(forWeatherState: weatherState))
        }
        
        return result;
    }
    
    //This method calculates middle temperature
    func getAverage(for array: [Double]) -> Int {
        var sum = 0.0
        for num in array {
            sum += num
        }
        let average = sum/Double(array.count)
        return Int(round(average))
    }
    
    //This method adjusts days so that the first element of the array is today
    func adjustDayOrder(for array: [Int]) -> [Int]{
        let days = getWeekDays()
        var result = [Int]()
        for day in days {
            result.append(array[day])
        }
        return result
    }
    
    //This method maps days from the Gregorian calendar (when Sunday has number 1) to
    //week where Monday is number 0
    func getWeekDayNumber(date: Date) -> Int {
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.weekday], from: date)
        var dayOfWeek = comp.weekday! - 2
        
        if dayOfWeek < 0 {
            dayOfWeek += 7
        }
        return dayOfWeek
    }
}
