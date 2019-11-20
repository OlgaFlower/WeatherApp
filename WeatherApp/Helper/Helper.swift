//
//  Helper.swift
//  WeatherApp
//
//  Created by Admin on 14.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//http://dataservice.accuweather.com/locations/v1/cities/autocomplete?apikey=DD88l3LYERLRIDfPjaSGXsMlcG0yWtoK&q=vinn

import Foundation

class Helper {
    let mainPresenter = MainPresenter()
    
    static let apiKey = "o4n8KwKYFRUt7tg9XGCt9pBlE83Esm9J"
    static let apiKey2 = "DD88l3LYERLRIDfPjaSGXsMlcG0yWtoK"
    
    static let hourlyBaseURL = "https://dataservice.accuweather.com/forecasts/v1/hourly"
    static let dailyBaseURL = "https://dataservice.accuweather.com/forecasts/v1/daily"
    static let searchBaseURL = "https://dataservice.accuweather.com/locations/v1/cities/autocomplete?apikey="
    
    static var oneHourResource = "\(hourlyBaseURL)/1hour/\(cityKey)?apikey=\(apiKey)&details=true&metric=true"
    static var twelveHoursResource = "\(hourlyBaseURL)/12hour/\(cityKey)?apikey=\(apiKey)&metric=true"
    static var fiveDaysResource = "\(dailyBaseURL)/5day/\(cityKey)?apikey=\(apiKey)&details=true&metric=true"
    static var searchResource = "\(searchBaseURL)\(apiKey)&q="
    
    static var cityKey = 326175
    static let degree = "°"
    
}








//private var degrees = "0"
//private var sign = "º"
//
//public var degreeString: String {
//    get {
//        return degrees + sign
//    }
//    set {
//        degrees = newValue
//    }
//}
//
//degreeString = "12.3"
//print(degreeString) //12.3º
