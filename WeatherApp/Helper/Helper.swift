//
//  Helper.swift
//  WeatherApp
//
//  Created by Admin on 14.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//http://dataservice.accuweather.com/locations/v1/cities/autocomplete?apikey=DD88l3LYERLRIDfPjaSGXsMlcG0yWtoK&q=vinn

import Foundation

class Helper {
    
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
}


//var someDate = "2019-11-20T11:00:00+02:00"
//
//func getFormattedDate(string: String) -> String{
//    let dateFormatterGet = DateFormatter()
//    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//
//    let dateFormatterPrint = DateFormatter()
//    dateFormatterPrint.dateFormat = "EEEE"
//
//    let date: Date? = dateFormatterGet.date(from: string)
//    return dateFormatterPrint.string(from: date!);
//}
//
//print("Today is \(getFormattedDate(string: someDate))")
//

//FORMATS:
//
//Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
//09/12/2018                        --> MM/dd/yyyy
//09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
//Sep 12, 2:11 PM                   --> MMM d, h:mm a
//September 2018                    --> MMMM yyyy
//Sep 12, 2018                      --> MMM d, yyyy
//Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
//2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
//12.09.18                          --> dd.MM.yy
//10:41:02.112                      --> HH:mm:ss.SSS
