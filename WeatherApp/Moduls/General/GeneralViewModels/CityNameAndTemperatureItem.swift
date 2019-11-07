//
//  CityNameAndTemperatureItem.swift
//  WeatherApp
//
//  Created by Admin on 07.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

class CityNameAndTemperatureItem: GeneralViewModelItemProt {
    
    var type: GeneralViewModelItemType {
        return .cityNameAndTemperature
    }
    
    var temperature: Int
    var cityName: String
    
    init(temperature: Int, cityName: String) {
        self.temperature = temperature
        self.cityName = cityName
    }
    
}
