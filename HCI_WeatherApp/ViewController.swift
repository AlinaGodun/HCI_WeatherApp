//
//  ViewController.swift
//  HCI_WeatherApp
//
//  Created by Alina Godun on 08.04.18.
//  Copyright © 2018 Alina Godun. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var cities = [City(name: "Vienna", country: "AT", id: "2761369"),
                  City(name: "Paris", country: "FR", id: "2968815"),
                  City(name: "Barcelona", country: "ES", id: "6356055")]
    let apiManager = APIManager()
    var weatherData: [String: [WeatherState]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "YAWA by Alina Godun, 01569197"
        weatherData = apiManager.loadWeatherData(forCities: cities)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cityName = String(cities[indexPath.row].name)
        cell.textLabel?.text = cityName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let wvc = storyboard?.instantiateViewController(withIdentifier: "Weather") as? WeatherViewController {
            wvc.cityID = cities[indexPath.row].id
            wvc.cityName = cities[indexPath.row].name
            navigationController?.pushViewController(wvc, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
