//
//  ViewController.swift
//  SkyNow
//
//  Created by Fatimah Galhoum on 5/15/19.
//  Copyright © 2019 Fatimah Galhoum. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON




struct WeatherData : Codable {
    let list : [TodayWeatherData]
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
    let icon : String
}

struct Date : Codable {
    let dt : String
}

class WeatherViewController: UIViewController,CLLocationManagerDelegate {

    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "7c609f73c5df2dff2f32e3e3cc33cd23"
    
    //task
    let FORCAST_API_URL = "http://api.openweathermap.org/data/2.5/forecast/daily"
    
    //TODO: Declare instance variables here
    let locationManger = CLLocationManager()
    //var weatherDataHandler : WeatherDataHandler!
    //var weatherDataJSON: WeatherData?
    var heroes = [WeatherData]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
        
    }

    func getWeatherData(url : String, parameters: [String : String]){
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success! Got the weather data")
                
                
                let json = response.data
                
                do{
                    //created the json decoder
                    let decoder = JSONDecoder()
                    
                    //using the array to put values
                    self.heroes = try decoder.decode([WeatherData].self, from: json!)
                    
                    //printing all the hero names
                    for hero in self.heroes{
                        print(hero)
                    }
                    
                }catch let err{
                    print(err)
                }

                
            } else {
                print("Error \(response.result.error.debugDescription)")
                //self.cityLabel.text = "Connection Issues"
            }
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManger.stopUpdatingLocation()
            //to stop getting multiple lon and lat
            locationManger.delegate = nil
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            //let paramsForcast : [String : String] = ["lat" : latitude, "lon" : longitude, "cnt" : "16", "appid" : APP_ID]
            
            // step 6
            getWeatherData(url: WEATHER_URL, parameters: params)
            
            //getWeatherDataForcast(url: FORCAST_API_URL, parameters: paramsForcast)
            
        }
    }
    
    
    //Write the didFailWithError method here:
    //step 5
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        //cityLabel.text = "Location Unavailable"
    }
    

    
    
    
    

}


