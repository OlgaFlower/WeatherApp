//
//  TwelveHoursForecast.swift
//  WeatherApp
//
//  Created by Admin on 14.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

struct TwelveHoursForecast: Codable {
    var time: String
    var weatherIcon: Int
    var temperat: Temperature
    
                            private enum CodingKeys: String, CodingKey {
                                case time         = "DateTime"
                                case weatherIcon  = "WeatherIcon"
                                case temperat     = "Temperature"
                            }
}

struct Temperature: Codable {
    var temperatValue: Double //value in C
    
                            private enum CodingKeys: String, CodingKey {
                                case temperatValue = "Value"
                            }
}
