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
    let id : Int
    let icon : String
}

struct weatherDate : Codable {
    let dt : Double
}






class TodayWeatherDataIcons {
    
    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...300 :
            // conditionPic = "tstorm1-1"
            return "tstorm11"
            
        case 301...500 :
            //   conditionPic = "light-rain-1"
            return "light_rain1"
            
        case 501...600 :
            //conditionPic = "shower1"
            return "shower33"
            
        case 601...700 :
            //conditionPic = "snow1"
            return "snow55"
            
        case 701...771 :
            //conditionPic = "fog1"
            return "fog11"
            
        case 772...799 :
            //conditionPic = "tstorm1-2"
            return "tstorm33"
            
        case 800 :
            // conditionPic = "sun1"
            return "sunny1"
            
        case 801...804 :
            //conditionPic = "cloud1"
            return "cloudysun"
            
        case 900...903, 905...1000  :
            //conditionPic = "tstorm1-1"
            return "tstorm33"
            
        case 903 :
            //conditionPic = "snow2"
            return "snow55"
            
        case 904 :
            //conditionPic = "sun2"
            return "sunny1"
            
        default :
            return "dunno"
        }
        
    }
    
    
    func updateWeatherIconNight(conditionNight: Int) -> String {
        switch (conditionNight) {
            
        case 0...300 :
            // conditionPic = "tstorm1-1"
            return "tstorm11"
            
        case 301...500 :
            //   conditionPic = "light-rain-1"
            return "light_rain1"
            
        case 501...600 :
            //conditionPic = "shower1"
            return "shower33"
            
        case 601...700 :
            //conditionPic = "snow1"
            return "snow55"
            
        case 701...771 :
            //conditionPic = "fog1"
            return "fog11"
            
        case 772...799 :
            //conditionPic = "tstorm1-2"
            return "tstorm33"
            
        case 800 :
            // conditionPic = "sun1"
            return "moon"
            
        case 801...804 :
            //conditionPic = "cloud1"
            return "cloudynight"
            
        case 900...903, 905...1000  :
            //conditionPic = "tstorm1-1"
            return "tstorm33"
            
        case 903 :
            //conditionPic = "snow2"
            return "snow55"
            
        case 904 :
            //conditionPic = "sun2"
            return "moon"
            
        default :
            return "dunno"
        }
        
    }
    
        
        func updateWeatherIconGray(conditionGray: Int) -> String {
            
            switch (conditionGray) {
                
            case 0...300 :
                return "tstorm11gray"
                
            case 301...500 :
                return "light_rain1gray"
                
            case 501...600 :
                return "shower33gray"
                
            case 601...700 :
                return "snow55gray"
                
            case 701...771 :
                return "fog11gray"
                
            case 772...799 :
                return "tstorm33gray"
                
            case 800 :
                return "sunny1gray"
                
            case 801...804 :
                return "cloudysungray"
                
            case 900...903, 905...1000  :
                return "tstorm33gray"
                
            case 903 :
                return "snow55gray"
                
            case 904 :
                return "sunny1gray"
                
            default :
                return "dunno"
            }
            
        }
    
    
    
    
    
}

