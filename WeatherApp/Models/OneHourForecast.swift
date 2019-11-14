//
//  CurrentForecast.swift
//  WeatherApp
//
//  Created by Admin on 14.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

struct OneHourForecast: Codable {
    var weatherIcon: Int
    var iconPhrase: String
    var isDaylight: Bool
    var temperat: CurrentTemperature
    var mobLink: String
                            private enum CodingKeys: String, CodingKey {
                                case weatherIcon = "WeatherIcon"
                                case iconPhrase  = "IconPhrase"
                                case isDaylight  = "IsDaylight"
                                case temperat    = "Temperature"
                                case mobLink     = "MobileLink"
                            }
}


struct CurrentTemperature: Codable {
    var temperatValue: Double //value in C
    
                            private enum CodingKeys: String, CodingKey {
                                case temperatValue = "Value"
                            }
}



