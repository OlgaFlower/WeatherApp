//
//  FiveDaysForecast.swift
//  WeatherApp
//
//  Created by Admin on 15.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

struct FiveDaysForecast: Codable {
    var dailyForecast: [Forecast]
    
//    init(dailyForecast: [Forecast]) {
//        self.dailyForecast = dailyForecast
//    }
    
                            private enum CodingKeys: String, CodingKey {
                                case dailyForecast = "DailyForecasts"
                            }
}



struct Forecast: Codable {
    var date: String?
    var sun: Sun
    var temperat: DayTemperature
    var dayIcon: DayIcon
    
//    init(date: String, sun: Sun, temperat: DayTemperature, dayIcon: DayIcon) {
//        self.date = da
    }
    
                        private enum CodingKeys: String, CodingKey {
                            case date     = "Date"
                            case sun      = "Sun"
                            case temperat = "Temperature"
                            case dayIcon  = "Day"
                        }
}


struct Sun: Codable {
    var sunriseTime: String?
    var sunsetTime: String?
    
                        private enum CodingKeys: String, CodingKey {
                            case sunriseTime = "Rise"
                            case sunsetTime  = "Set"
                        }
}


struct DayTemperature: Codable {
    var min: MinTemperat
    var max: MaxTemperat
    
                        private enum CodingKeys: String, CodingKey {
                            case min = "Minimum"
                            case max = "Maximum"
                        }
}


struct DayIcon: Codable {
    var icon: Int?
    
                        private enum CodingKeys: String, CodingKey {
                            case icon = "Icon"
                        }
}


struct MinTemperat: Codable {
    var value: Double? //in C
    
                        private enum CodingKeys: String, CodingKey {
                            case value = "Value"
                        }
}


struct MaxTemperat: Codable {
    var value: Double? //in C
    
                        private enum CodingKeys: String, CodingKey {
                            case value = "Value"
                        }
}

