//
//  LocationKey.swift
//  WeatherApp
//
//  Created by Admin on 11.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

struct LocationKey: Codable {
    var key: String?
    var engCityName: String?
    var country = Country()
    
                    private enum CodingKeys: String, CodingKey {
                        case key         = "Key"
                        case engCityName = "EnglishName"
                        case country     = "Country"
                    }
}


struct Country: Codable {
    var id: String?
    var engCountryName: String?
    
                    private enum CodingKeys: String, CodingKey {
                        case id             = "ID"
                        case engCountryName = "EnglishName"
                    }
}
