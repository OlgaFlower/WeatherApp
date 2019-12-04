//
//  Helper.swift
//  WeatherApp
//
//  Created by Admin on 14.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//http://dataservice.accuweather.com/locations/v1/1593794?apikey=mEECFoncHJmdzuK925tGFk9tYJA5wgG7&details=true

import UIKit

class Helper {
    //MARK: - Helper properties
    static let degree = "°"
    static let png = ".png"
    
    //MARK: - Helper: key and data sources
    static let apiKey = "tB0eXrGEz238UXRN77eGLP68HabUbwku"
    
    static let hourlyBaseURL = "https://dataservice.accuweather.com/forecasts/v1/hourly"
    static let dailyBaseURL = "https://dataservice.accuweather.com/forecasts/v1/daily"
    static let searchBaseURL = "https://dataservice.accuweather.com/locations/v1/cities/autocomplete?apikey="
    static let timeZoneCodeURL = "https://dataservice.accuweather.com/locations/v1/"
    
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
    
    static func timeZoneCodeResource(_ key: String) -> String {
        return "\(timeZoneCodeURL)\(key)?apikey=\(apiKey)&details=true"
    }
    
    //MARK: - Date formatter
    static let weekDayFormat = "EEEE"
    static let hourFormat = "HH:mm"
    
    //FORMAT
    static func dateConverter(_ inputDate: String, _ convertTo: String) -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //input format
        
        let dateFormatterConvert = DateFormatter()
        dateFormatterConvert.dateFormat = convertTo

        let date: Date? = dateFormatterGet.date(from: inputDate)
        
        return dateFormatterConvert.string(from: date!)
        
    }
    
    
    //TIMEZONE
    static func timeZoneConverter(_ inputDate: String, _ timeZone: String) -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //input format
        
        let dateFormatterConvert = DateFormatter()
        dateFormatterConvert.dateFormat = self.hourFormat
        dateFormatterConvert.timeZone = TimeZone(identifier: timeZone)
        
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
