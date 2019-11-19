//
//  AutocompleteSearch.swift
//  WeatherApp
//
//  Created by Admin on 18.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var key: String
    var cityName: String
    var country: CountryName
    
                            private enum CodingKeys: String, CodingKey {
                            case key      = "Key"
                            case cityName = "LocalizedName"
                            case country  = "Country"
                            }
}

struct CountryName: Codable {
    var name: String
                            private enum CodingKeys: String, CodingKey {
                            case name = "LocalizedName"
                            }
}
