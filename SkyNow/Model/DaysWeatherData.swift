//
//  DaysWeatherData.swift
//  SkyNow
//
//  Created by Fatimah Galhoum on 5/17/19.
//  Copyright © 2019 Fatimah Galhoum. All rights reserved.
//

import Foundation

struct DaysWeatherData :Codable {
    let city : CityInformation
    let list : [DaysList]
    
}

struct CityInformation :Codable {
    let name : String
}

struct DaysList : Codable {
    let dt : Double
    let temp : DaysTemperatures
    let weather : [WeatherInformation]
}

struct DaysTemperatures : Codable {
    let day : Double
    let min : Double
    let max : Double
}

struct WeatherInformation : Codable {
    let id : Int
    let description : String
    let icon : String
}


class ForcastWeather {
    
    
    var tempArray = [Int]()
    var tempMaxArray = [Int]()
    var tempFArray = [Int]()
    var tempMaxFArray = [Int]()
    var conArray = [Int]()
    var iconArray = [String]()
    var dateArray = [String]()
    
    
}
