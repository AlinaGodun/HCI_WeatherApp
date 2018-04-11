//
//  City.swift
//  HCI_WeatherApp
//
//  Created by Alina Godun on 11.04.18.
//  Copyright © 2018 Alina Godun. All rights reserved.
//

import Foundation

struct City {
    let name : String
    let country : String
    let id : String
    
    init (name _name: String, country _country: String, id _id: String) {
        name = _name
        country = _country
        id = _id
    }
}
