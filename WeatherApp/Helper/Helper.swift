//
//  Helper.swift
//  WeatherApp
//
//  Created by Admin on 14.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//http://dataservice.accuweather.com/locations/v1/cities/autocomplete?apikey=DD88l3LYERLRIDfPjaSGXsMlcG0yWtoK&q=vinn

import UIKit

class Helper {
    
    static var cityKey = "326175"
    static let degree = "°"
    static let png = ".png"
    
    //MARK: - Key and data source
    static let apiKey = "T63iCF8KW2fsAtp2aRHGl48JB3PA7dzF"
    static let apiKey2 = "DD88l3LYERLRIDfPjaSGXsMlcG0yWtoK"
    
    static let hourlyBaseURL = "https://dataservice.accuweather.com/forecasts/v1/hourly"
    static let dailyBaseURL = "https://dataservice.accuweather.com/forecasts/v1/daily"
    static let searchBaseURL = "https://dataservice.accuweather.com/locations/v1/cities/autocomplete?apikey="
    
    static var oneHourResource = "\(hourlyBaseURL)/1hour/\(cityKey)?apikey=\(apiKey2)&details=true&metric=true"
    static var twelveHoursResource = "\(hourlyBaseURL)/12hour/\(cityKey)?apikey=\(apiKey2)&metric=true"
    static var fiveDaysResource = "\(dailyBaseURL)/5day/\(cityKey)?apikey=\(apiKey2)&details=true&metric=true"
    static var searchResource = "\(searchBaseURL)\(apiKey2)&q="
    
    //MARK: - Date formatter
    static let weekDayFormat = "EEEE"
    static let hourFormat = "HH:mm"
    
    static func dateConverter(_ inputDate: String, _ convertTo: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //input format
        
        let dateFormatterConvert = DateFormatter()
        dateFormatterConvert.dateFormat = convertTo
        
        let date: Date? = dateFormatterGet.date(from: inputDate)
        return dateFormatterConvert.string(from: date!)
    }
    
    //MARK: - Moving Effect
    static func movingEffect(view: UIView, intensity: Double) {
        let horizontalMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontalMotion.minimumRelativeValue = -intensity
        horizontalMotion.maximumRelativeValue = intensity
        
        let verticalMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        verticalMotion.minimumRelativeValue = -intensity
        verticalMotion.maximumRelativeValue = intensity
        
        //group x and y motions
        let movement = UIMotionEffectGroup()
        movement.motionEffects = [horizontalMotion, verticalMotion]
        view.addMotionEffect(movement)
    }
    
}
