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



class WeatherViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var cityLable: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    

    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "7c609f73c5df2dff2f32e3e3cc33cd23"
    
    //task
    let FORCAST_API_URL = "http://api.openweathermap.org/data/2.5/forecast/daily"
    
    //TODO: Declare instance variables here
    let locationManger = CLLocationManager()
    var weatherDataHandler : WeatherDataHandler!
    
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
                //print(json!)
                self.weatherDataHandler = WeatherDataHandler(data: json!)
                self.weatherDataHandler.decodeData()
                
                self.uiDisplayTodayWeatherData()
                
            } else {
                print("Error \(response.result.error.debugDescription)")
                self.cityLable.text = "Connection Issues"
            }
        }
        
    }
    
    func uiDisplayTodayWeatherData () {
        
        cityLable.text = weatherDataHandler.weatherDataJSON?.name

    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManger.stopUpdatingLocation()
            //to stop getting multiple lon and lat
            locationManger.delegate = nil
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")

            let params : [String : String] = ["lat" : String(location.coordinate.latitude), "lon" : String(location.coordinate.longitude), "appid" : APP_ID]
            
            //let paramsForcast : [String : String] = ["lat" : latitude, "lon" : longitude, "cnt" : "16", "appid" : APP_ID]
            
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


