//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var weatherCondition: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        searchTextField.delegate = self
        searchTextField.attributedPlaceholder = NSAttributedString(string: "search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
        weatherManager.delegate = self
        
        // Do any additional setup after loading the view.
    }
}

//MARK - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        weatherManager.fetchData(with: searchTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == ""{
            textField.placeholder = "type something"
            
            return false
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        weatherManager.fetchData(with: textField.text!)
    }
}

//MARK WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ manager: WeatherManager, weather: Weather) {
        temperatureLabel.text = weather.formattedTemp
        weatherCondition.image = UIImage.init(systemName: weather.condition)
        cityLabel.text = weather.city
    }
    
    func didFailedWithErrors(error: Error) {
        print(error)
    }
    
    @IBAction func resetLocationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

//MARK CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            manager.stopUpdatingLocation()
            
            var lat = location.coordinate.latitude
            var long = location.coordinate.longitude
            print(lat)
            weatherManager.fetchData(lat: lat, long: long)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            manager.requestLocation()
        }
        
        print("aceita ae cusao")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("deu erro caraio")
    }
}
