//
//  HorizontalHoursForecast.swift
//  WeatherApp
//
//  Created by Admin on 07.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

class HorizontalHoursForecast: GeneralViewModelItemProt {
    
    var type: GeneralViewModelItemType {
        return .horizontalHoursForecast
    }
    
    var time: String
    var temperature: String
    var nowTime: String
    
    init(time: String, temperature: String, nowTime: String) {
        self.time = time
        self.temperature = temperature
        self.nowTime = nowTime
    }
    
}
