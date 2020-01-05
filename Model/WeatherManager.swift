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
    var delegate: WeatherManagerDelegate?
    
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
                    if let weather = self.parseJson(weatherData: data) {
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJson(weatherData: Data) -> Weather? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let weather = Weather(id: decodedData.weather[0].id, temperature: decodedData.main.temp, city: decodedData.name)
            
            return weather
        } catch {
            print(error)
            
            return nil
        }
    }
}
