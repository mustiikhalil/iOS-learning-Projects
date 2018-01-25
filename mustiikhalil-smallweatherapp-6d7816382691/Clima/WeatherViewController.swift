//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import ProgressHUD

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    

    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    var weatherDataModel = WeatherDataModel()
    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO:Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let button = UIButton()
        button.addTarget(self, action: #selector(refreshButton), for: .touchUpInside)
        button.frame = CGRect(x: 10, y: (self.view.frame.height - 100), width: 100, height: 70)
        button.setTitle("Refresh", for: .normal)
        self.view.addSubview(button)
    }
    
    @objc func refreshButton(){
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    
    func getWeatherData(from currentURL: String, for location: [String: String]){
        
        ProgressHUD.spinnerColor(UIColor(hexNumber: 0xC6342A))
        ProgressHUD.show("connecting")
        Alamofire.request(currentURL, method: .get, parameters: location).responseJSON {
            response in
            if response.result.isSuccess{
                
                self.parse(json: JSON(response.result.value!))
                
            } else {
                ProgressHUD.dismiss()
                print("error: \(String(describing: response.result.error))")
                self.cityLabel.text = "connection issues"
            }
        }
        
    }

   
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    
    //Write the updateWeatherData method here:
    
    func parse(json: JSON){
        
        if let temperatureResult = json["main"]["temp"].double{
            
            let cityName = String(describing: json["name"])
            
            self.weatherDataModel.cityName = cityName
            self.weatherDataModel.temp = Int(temperatureResult - 273.15)
            
            self.weatherDataModel.condition = json["weather"][0]["id"].int!
            self.weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition!)
            updateUIWithWeatherData()
        }
        
    }
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    func updateUIWithWeatherData() {
        
        temperatureLabel.text = "\(weatherDataModel.temp!)°"
        cityLabel.text = weatherDataModel.cityName
        weatherIcon.image = UIImage(named: "\(weatherDataModel.weatherIconName!)")
        ProgressHUD.dismiss()
        
    }
    
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count-1]
        if location.horizontalAccuracy > 0 {
            
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            let params: [String: String] = ["lat": latitude, "lon": longitude, "appid": APP_ID]
            
            getWeatherData(from: API_URL, for: params)
            
            
        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error)
        cityLabel.text = "location Unavailable"
    }
    
    
    
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    func userEnteredCity(name: String) {
        let pramas: [String: String] = ["q": name, "appid": APP_ID]
        getWeatherData(from: API_URL, for: pramas)
    }
    
    
    //Write the PrepareForSegue Method here
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName"{
            
            let destinationVC = segue.destination as! ChangeCityViewController
            
            destinationVC.delegate = self
            
        }
    }
    
    
    
    
}


