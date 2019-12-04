//
//  TimeZoneForSunsriseAndSunset.swift
//  WeatherApp
//
//  Created by Admin on 03.12.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

struct TimeZoneForSunriseAndSunset: Codable {
    var timeZoneName: ZoneName
    
                    private enum CodingKeys: String, CodingKey {
                        case timeZoneName = "TimeZone"
                    }
}

struct ZoneName: Codable {
    var name: String
    
                    private enum CodingKeys: String, CodingKey {
                        case name = "Name"
                    }
}
