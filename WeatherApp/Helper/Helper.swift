//
//  Helper.swift
//  WeatherApp
//
//  Created by Admin on 14.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//http://dataservice.accuweather.com/locations/v1/cities/autocomplete?apikey=DD88l3LYERLRIDfPjaSGXsMlcG0yWtoK&q=vinn

import UIKit

class Helper {
    //MARK: - Helper properties
    static let degree = "°"
    static let png = ".png"
    
    //MARK: - Helper: key and data sources
    static let apiKey = "podLVwdYT6xDtfVHAnHoc9zwbQlwcGfG"
    
    static let hourlyBaseURL = "https://dataservice.accuweather.com/forecasts/v1/hourly"
    static let dailyBaseURL = "https://dataservice.accuweather.com/forecasts/v1/daily"
    static let searchBaseURL = "https://dataservice.accuweather.com/locations/v1/cities/autocomplete?apikey="
    
    static var searchResource = "\(searchBaseURL)\(apiKey)&q="
    
    static func oneHourResource(_ key: String) -> String {
        return "\(hourlyBaseURL)/1hour/\(key)?apikey=\(apiKey)&details=true&metric=true"
    }
    
    static func twelveHoursResource(_ key: String) -> String {
        return "\(hourlyBaseURL)/12hour/\(key)?apikey=\(apiKey)&metric=true"
    }
    
    static func fiveDaysResource(_ key: String) -> String {
        return "\(dailyBaseURL)/5day/\(key)?apikey=\(apiKey)&details=true&metric=true"
    }
    
    
    //MARK: - Date formatter
    static let weekDayFormat = "EEEE"
    static let hourFormat = "HH:mm"
    
    static func dateConverter(_ inputDate: String, _ convertTo: String) -> String {
        var calendar = Calendar.current
        if let timeZone = TimeZone(abbreviation: "UTC") {
            calendar.timeZone = timeZone
        }
        
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
    
    //MARK: - Blurred background view
    static func blurredView(_ backImage: UIImageView, _ view: UIView) {
        let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurredView.frame = view.bounds
        blurredView.alpha = 0.5
        backImage.addSubview(blurredView)
    }
    
}
