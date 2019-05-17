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
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    //Array
    var iconArray = ["01d", "02d", "03d", "04d", "09d", "10d", "11d", "13d", "50d"]
    var iconBool : Bool?
    

    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "7c609f73c5df2dff2f32e3e3cc33cd23"
    
    //task
    let FORCAST_API_URL = "http://api.openweathermap.org/data/2.5/forecast/daily"
    
    //TODO: Declare instance variables here
    let locationManger = CLLocationManager()
    let todayWeatherIcon = TodayWeatherDataIcons()
    var weatherDataJSON: WeatherData?
    var weatherDataTemperaturesJSON : TodayWeatherData?
    var weatherDataDateJSON : weatherDate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
        
        
    }

    
    //handle data
    /**************************************************/
    func getWeatherData(url : String, parameters: [String : String]){
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success! Got the weather data")
                
                var data : Data?
                data = response.data
                //print(json!)
                let decoder = JSONDecoder()
                
                do {
                self.weatherDataJSON = try? decoder.decode(WeatherData.self, from: data!)
                self.weatherDataTemperaturesJSON = try decoder.decode(TodayWeatherData.self, from: data!)
                self.weatherDataDateJSON = try decoder.decode(weatherDate.self, from: data!)
                    
                    if let weatherData = self.weatherDataJSON{
                        print(weatherData)
                        let weatherDataTemperatures = self.weatherDataTemperaturesJSON
                        print(weatherDataTemperatures!)
                        let weatherDataDate = self.weatherDataDateJSON
                                        print(weatherDataDate!)
                    }
                self.uiDisplayTodayWeatherData()
                } catch {
                    print(error)
                    print("error")
                    self.cityLable.text = "Weather Unavailable"
                }
                
            } else {
                print("Error \(response.result.error.debugDescription)")
                self.cityLable.text = "Connection Issues"
            }
        }
        
    }
    
    
    
    
    func uiDisplayTodayWeatherData () {
        
        //Labels
        cityLable.text = weatherDataJSON?.name

        tempLabel.text = String(Int((weatherDataTemperaturesJSON?.main
            .temp)! - 273.15)) + "°"
        
        tempMaxLabel.text = String(Int((weatherDataTemperaturesJSON?.main.temp_max)! - 273.15))
        
        tempMinLabel.text = String(Int((weatherDataTemperaturesJSON?.main.temp_min)! - 273.15))
        
        
        //Date
        if let date = weatherDataDateJSON?.dt {
            let rawDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            todayLabel.text = "\(rawDate.dayOfTheWeek())"
        }
        
        
        //description
        descriptionLabel.text = weatherDataTemperaturesJSON?.weather[0].description
        
        
        //Weather Icon
        let weatherIconName = todayWeatherIcon.updateWeatherIcon(condition: (weatherDataTemperaturesJSON?.weather[0].id)!)
        let weatherIconNameNight = todayWeatherIcon.updateWeatherIconNight(conditionNight: (weatherDataTemperaturesJSON?.weather[0].id)!)

        weatherIconCheck()
        
        if iconBool == true {
        iconImage.image = UIImage(named: weatherIconName)
        backgroundImage.image = UIImage(named: "sun")
        } else {
        iconImage.image = UIImage(named: weatherIconNameNight)
        backgroundImage.image = UIImage(named: "night")

        }
        
    }
    
    
    func weatherIconCheck() {
        
        let weatherIcon = weatherDataTemperaturesJSON?.weather[0].icon
        
        for item in 0...8 {
            if weatherIcon == iconArray[item] {
                iconBool = true
            } else {
                iconBool = false
            }
        }
        
    }
    
    
    //Handle location
    /**************************************************/
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
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        //cityLabel.text = "Location Unavailable"
    }
    /**************************************************/
}



