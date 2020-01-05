//
//  WeatherData.swift
//  Clima
//
//  Created by Lucas Eduardo on 05/01/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [WeatherJSON]
}

struct Main: Decodable {
    let temp: Double
}

struct WeatherJSON: Decodable {
    let id: Int
    let description: String
}
