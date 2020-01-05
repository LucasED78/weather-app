//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var weatherCondition: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(textField.text)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == ""{
            textField.placeholder = "type something"
            textField.textColor = UIColor.systemRed
        }
        
        return textField.text == ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        // Do any additional setup after loading the view.
    }


}

