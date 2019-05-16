//
//  TodayWeatherData.swift
//  SkyNow
//
//  Created by Fatimah Galhoum on 5/15/19.
//  Copyright © 2019 Fatimah Galhoum. All rights reserved.
//

import Foundation

struct WeatherData : Codable {
    let name : String
}

struct TodayWeatherData : Codable {
    let main : Temperatures
    let weather : [WeatherIconData]
}

struct Temperatures : Codable {
    let temp : Double
    let temp_min : Double
    let temp_max : Double
}

struct WeatherIconData : Codable {
    let description : String
    let icon : String
}

struct Date : Codable {
    let dt : Int
}

