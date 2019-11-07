//
//  OneDayModel.swift
//  WeatherApp
//
//  Created by Admin on 06.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

struct OneDay: Codable {
    var headLine = HeadInfo()
    var dailyForecast = [Forecast]()
    
    private enum CodingKeys: String, CodingKey {
        case headLine = "Headline"
        case dailyForecast = "DailyForecasts"
    }
}

struct HeadInfo: Codable {
    var text: String?
    var mobileLink: String?

    private enum CodingKeys: String, CodingKey {
        case text = "Text"
        case mobileLink = "MobileLink"
    }
    
}

struct Forecast: Codable {
    var date: String?
    var temperature = Temperature()
    var day = Day()
    var night = Night()
    var mobileLink: String?

    private enum CodingKeys: String, CodingKey {
        case date = "Date"
        case temperature = "Temperature"
        case day = "Day"
        case night = "Night"
        case mobileLink = "MobileLink"
    }
}

struct Temperature: Codable {
    var min = Minimum()
    var max = Maximum()

    private enum CodingKeys: String, CodingKey {
        case min = "Minimum"
        case max = "Maximum"
    }
}

struct Minimum: Codable {
    var value: Double?

    private enum CodingKeys: String, CodingKey {
        case value = "Value"
    }
}

struct Maximum: Codable {
    var value: Double?

    private enum CodingKeys: String, CodingKey {
        case value = "Value"
    }
}

struct Day: Codable {
    var icon: Int?
    var iconPhrase: String?

    private enum CodingKeys: String, CodingKey {
        case icon = "Icon"
        case iconPhrase = "IconPhrase"
    }
}

struct Night: Codable {
   var icon: Int?
   var iconPhrase: String?

   private enum CodingKeys: String, CodingKey {
       case icon = "Icon"
       case iconPhrase = "IconPhrase"
   }
}
