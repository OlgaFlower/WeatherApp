//
//  WeekForecast.swift
//  WeatherApp
//
//  Created by Admin on 07.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

class WeekForecast: GeneralViewModelItemProt {
    
    var type: GeneralViewModelItemType {
        return .weekForecast
    }
    
    var tomorrow: String
    var dayOfWeek: [String]
    var icon: [String]
    var temperature: [String]
    
    init(tomorrow: String, dayOfWeek: [String], icon: [String], temperature: [String]) {
        self.tomorrow = tomorrow
        self.dayOfWeek = dayOfWeek
        self.icon = icon
        self.temperature = temperature
    }
    
}
