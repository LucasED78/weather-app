//
//  WeatherManager.swift
//  Clima
//
//  Created by Lucas Eduardo on 05/01/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let apiURL = "https://api.openweathermap.org/data/2.5/weather?appid=28f262e223d35b1a578208ef1b50769b&metrics=units&q="
    
    func fetchData(cityName: String){
        let path = "\(apiURL)\(cityName)"
        
        let url = URL(string: path)
        
        if let url = url{
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, _, err) in
                if let error = err{
                    print(error)
                }
                
                if let data = data{
                    self.parseJson(weatherData: data)
                }
            }
            
            task.resume()
        }
    }
    
    func parseJson(weatherData: Data){
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].description)
        } catch {
            print(error)
        }
    }
}
