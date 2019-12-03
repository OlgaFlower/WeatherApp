//
//  TimeZoneForSunsriseAndSunset.swift
//  WeatherApp
//
//  Created by Admin on 03.12.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

struct TimeZoneForSunriseAndSunset: Codable {
    var timeZone: Code
    
                    private enum CodingKeys: String, CodingKey {
                        case timeZone = "TimeZone"
                    }
}

struct Code: Codable {
    var code: String
    
                    private enum CodingKeys: String, CodingKey {
                        case code = "Code"
                    }
}
