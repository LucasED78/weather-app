//
//  WeatherManager.swift
//  Clima
//
//  Created by Lucas Eduardo on 05/01/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let apiURL = "https://api.openweathermap.org/data/2.5/weather?appid=28f262e223d35b1a578208ef1b50769b&units=metric&"
    var delegate: WeatherManagerDelegate?
    
    func fetchData(with cityName: String){
        let path = "\(apiURL)q=\(cityName)"
        performRequest(with: path)
    }
    
    func fetchData(lat latitude: Double, long longitude: Double){
        let path = "\(apiURL)lat=\(latitude)&lon=\(longitude)"
        performRequest(with: path)
    }
    
    func performRequest(with urlString: String){
        let url = URL(string: urlString)
        
        if let url = url{
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, _, err) in
                if let error = err{
                    self.delegate?.didFailedWithErrors(error: error)
                }
                
                if let data = data{
                    if let weather = self.parseJson(data) {
                        DispatchQueue.main.async {
                            self.delegate?.didUpdateWeather(self, weather: weather)
                        }
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJson(_ weatherData: Data) -> Weather? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let weather = Weather(id: decodedData.weather[0].id, temperature: decodedData.main.temp, city: decodedData.name)
            
            return weather
        } catch {
            delegate?.didFailedWithErrors(error: error)
            
            return nil
        }
    }
}
