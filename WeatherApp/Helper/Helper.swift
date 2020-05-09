//
//  Helper.swift
//  WeatherApp
//
//  Created by Admin on 14.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit

class Helper {
    //MARK: - Helper properties
    static let degree = "°"
    static let png = ".png"
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - Helper: key and data sources
    //Insert your udated APIkey here:
    static let apiKey = "mXxnJzHhsrCGkHA58alpHTMYoz3RQWqI"
    
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
    
    //MARK: - Save to DB
    static func saveCityItems() {
        do {
            try self.context.save()
        } catch {
            print("\(Errors.savingError) \(error)")
        }
    }
    
    
    //MARK: - Date formatter
    enum DateFormat: String {
        case weekDayFormat = "EEEE"
        case hourFormat = "HH:mm"
    }
    
    static func dateConverter(_ inputDate: String, _ format: DateFormat, _ timeZone: String) -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //input format
        
        let dateFormatterConvert = DateFormatter()
        dateFormatterConvert.dateFormat = format.rawValue
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
