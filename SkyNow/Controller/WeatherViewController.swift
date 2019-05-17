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



class WeatherViewController: UIViewController,CLLocationManagerDelegate, changeCityDelegate, UITableViewDataSource, UITableViewDelegate {

    //Outlets
    @IBOutlet weak var cityLable: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tempSwitch: UISwitch!
    @IBOutlet weak var tempTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    

    var iconBool : Bool?
    

    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "7c609f73c5df2dff2f32e3e3cc33cd23"
    
    //task
    let DAYS_API_URL = "http://api.openweathermap.org/data/2.5/forecast/daily"
    
    //TODO: Declare instance variables here
    let locationManger = CLLocationManager()
    let todayWeatherIcon = TodayWeatherDataIcons()
    let forcastWeatherDays = ForcastWeather()
    
    //today
    var weatherDataJSON: WeatherData?
    var weatherDataTemperaturesJSON : TodayWeatherData?
    var weatherDataDateJSON : weatherDate?
    
    //days
    var daysWeatherDataJson : DaysWeatherData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
        tableView.delegate = self
        tableView.dataSource = self
        
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
    
    
    func getWeatherDataForDays(url : String, parameters: [String : String]){
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success! Got the weather data")
                var data : Data?
                data = response.data
                //print(data!)
                let decoder = JSONDecoder()
                self.daysWeatherDataJson = try? decoder.decode(DaysWeatherData.self, from: data!)
                self.uiDisplayDaysWeatherData()
            } else {
                print("Error \(response.result.error.debugDescription)")
                self.cityLable.text = "Connection Issues"
            }
        }
    }
    
    
    
    
    //Ui handle
    /**************************************************/
    func uiDisplayTodayWeatherData () {
        
        //Labels
        cityLable.text = weatherDataJSON?.name
        
        //Weather Type degree
        if tempSwitch.isOn == true {
        tempLabel.text = String(Int((weatherDataTemperaturesJSON?.main
            .temp)! - 273.15)) + "°"
        tempMaxLabel.text = String(Int((weatherDataTemperaturesJSON?.main.temp_max)! - 273.15))
        tempMinLabel.text = String(Int((weatherDataTemperaturesJSON?.main.temp_min)! - 273.15))
        } else {
            tempLabel.text = String(Int((weatherDataTemperaturesJSON?.main
                .temp)!)) + "°"
            tempMaxLabel.text = String(Int((weatherDataTemperaturesJSON?.main.temp_max)!))
            tempMinLabel.text = String(Int((weatherDataTemperaturesJSON?.main.temp_min)!))
        }
        
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
        let weatherIcon = weatherDataTemperaturesJSON?.weather[0].icon
        
        if  (weatherIcon ==  "01d") || (weatherIcon == "02d") || (weatherIcon == "03d") || (weatherIcon == "04d") || (weatherIcon == "09d") || (weatherIcon == "10d") || (weatherIcon == "11d") || (weatherIcon == "13d") || (weatherIcon == "50d") {
            iconImage.image = UIImage(named: weatherIconName)
            backgroundImage.image = UIImage(named: "sunsmall")
                iconBool = true
            } else {
            iconImage.image = UIImage(named: weatherIconNameNight)
            backgroundImage.image = UIImage(named: "nightsmall")
                iconBool = false
            }
        
//        if iconBool == true {
////        iconImage.image = UIImage(named: weatherIconName)
////        backgroundImage.image = UIImage(named: "sun")
//        } else {
////        iconImage.image = UIImage(named: weatherIconNameNight)
////        backgroundImage.image = UIImage(named: "night")
//
//        }
        
    }
    
    /**************************************************/

    func uiDisplayDaysWeatherData(){

        //cityLable.text = daysWeatherDataJson?.city.name
        
        for item in 2...9 {

        forcastWeatherDays.tempMaxArray.append(Int((daysWeatherDataJson?.list[item].temp.max)!))
        
        if let date = daysWeatherDataJson?.list[item].dt{
            let rawDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            forcastWeatherDays.dateArray.append("\(rawDate.dayOfTheWeek())")
        }
        }
        print(forcastWeatherDays.dateArray)
        print(forcastWeatherDays.tempMaxArray)

        self.tableView.reloadData()

    }
    
    
    
    
    
    
    
    
    
    //Handle location
    /**************************************************/
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManger.stopUpdatingLocation()
            //to stop getting multiple lon and lat
            locationManger.delegate = nil
            
            //print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")

            let params : [String : String] = ["lat" : String(location.coordinate.latitude), "lon" : String(location.coordinate.longitude), "appid" : APP_ID]
            let paramsForcast : [String : String] = ["lat" : String(location.coordinate.latitude), "lon" : String(location.coordinate.longitude), "cnt" : "16", "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
            getWeatherDataForDays(url: DAYS_API_URL, parameters: paramsForcast)
            
        }
    }
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLable.text = "Location Unavailable"
    }
    /**************************************************/
    
    
    
    //Switch
    /**************************************************/
    @IBAction func tempType(_ sender: UISwitch) {
        
        if (sender.isOn == true) {            
            tempTypeLabel.text = "C°"
            uiDisplayTodayWeatherData()
        } else {
            tempTypeLabel .text = "F°"
            uiDisplayTodayWeatherData()
        }

    }
    /**************************************************/

    
    
    //TabelView
    /**************************************************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DaysWeatherTableViewCell
        
        
        cell.maxTempLabel.text = String(forcastWeatherDays.tempMaxArray[indexPath.row])
        cell.dayNameLabel.text = forcastWeatherDays.dateArray[indexPath.row]
        
        return cell
        
    }
    /**************************************************/

    
    

    //New City
    /**************************************************/
    func userEnteredANewCityName(city: String) {
        //step17
        let params : [String : String] = ["q" : city, "appid" : APP_ID]
        let paramsDays : [String : String] = ["q" : city,"cnt" : "16", "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: params)
        getWeatherDataForDays(url: DAYS_API_URL, parameters: paramsDays)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        }
    }
}



