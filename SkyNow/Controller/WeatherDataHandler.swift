//
//  WeatherDataHandler.swift
//  SkyNow
//
//  Created by Fatimah Galhoum on 5/15/19.
//  Copyright © 2019 Fatimah Galhoum. All rights reserved.
//

import Foundation

class WeatherDataHandler {
    let data: Data
    var weatherDataJSON: WeatherData?
    var weatherDataTemperaturesJSON : TodayWeatherData?
    var weatherDataDateJSON : Date?
    
    
    
    init(data: Data) {
        self.data = data
    }
    
    
    func decodeData() {
        let decoder = JSONDecoder()
        do {
            weatherDataJSON = try decoder.decode(WeatherData.self, from: self.data)
            weatherDataTemperaturesJSON = try decoder.decode(TodayWeatherData.self, from: self.data)
            weatherDataDateJSON = try decoder.decode(Date.self, from: self.data)

            if let weatherData = weatherDataJSON {
                print(weatherData)
                let weatherDataTemperatures = weatherDataTemperaturesJSON
                print(weatherDataTemperatures!)
                let weatherDataDate = weatherDataDateJSON
                print(weatherDataDate!)

            }
            
        } catch {
            print(error)
        }
    }
    
    
    
}

