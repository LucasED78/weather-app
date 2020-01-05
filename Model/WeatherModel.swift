//
//  WeatherModel.swift
//  Clima
//
//  Created by Lucas Eduardo on 05/01/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct Weather {
    let id: Int
    let temperature: Double
    let city: String
    
    var formattedTemp: String {
        return String(format: "%0.1f", temperature)
    }
    
    var condition: String {
        switch id {
        case 200...232:
            return "cloud.heavyrain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "snow"
        case 700...781:
            return "tornado"
        case 800:
            return "sun.min"
        case 801...804:
            return "cloud"
        default:
            return "sun.max"
        }
    }
}
