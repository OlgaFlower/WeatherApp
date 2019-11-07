//
//  SunMoomTime.swift
//  WeatherApp
//
//  Created by Admin on 07.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

class SunMoomTime: GeneralViewModelItemProt {
    
    var type: GeneralViewModelItemType {
        return .sunMoomTime
    }
    
    var sunIcon: String
    var sunTime: String
    var moonIcon: String
    var moonTime: String
    
    init(sunIcon: String, sunTime: String, moonIcon: String, moonTime: String) {
        self.sunIcon = sunIcon
        self.sunTime = sunTime
        self.moonIcon = moonIcon
        self.moonTime = moonTime
    }
}
