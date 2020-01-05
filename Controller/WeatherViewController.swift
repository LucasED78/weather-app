//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    var weatherManager = WeatherManager()
    
    @IBOutlet weak var weatherCondition: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
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
    
    func didUpdateWeather(_ manager: WeatherManager, weather: Weather) {
        temperatureLabel.text = weather.formattedTemp
        weatherCondition.image = UIImage.init(systemName: weather.condition)
        cityLabel.text = weather.city
    }
    
    func didFailedWithErrors(error: Error) {
        print(error)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        searchTextField.attributedPlaceholder = NSAttributedString(string: "search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
        weatherManager.delegate = self
        
        // Do any additional setup after loading the view.
    }


}

