//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by Lucas Eduardo on 05/01/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ manager: WeatherManager, weather: Weather)
    func didFailedWithErrors(error: Error)
}
