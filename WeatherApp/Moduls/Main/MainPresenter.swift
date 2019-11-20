//
//  MainPresenter.swift
//  WeatherApp
//
//  Created by Admin on 09.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit


class MainPresenter {
    
//    init() {
//        oneHourForecasts
//        twelveHourForecasts
//    }
   
    weak var mainView: MainViewController?
    weak var collection: MainHourForecastCollectionViewCell?
    
    //MARK: - Data
    let hourService = APIOneHourService()
    let twelveHoursService = APITwelveHoursService()
    let fiveDaysService = APIFiveDaysService()

    //structs
    var oneHourForecasts: [OneHourForecast]?
    var twelveHourForecasts: [TwelveHoursForecast]?
    var fiveDaysForecast: FiveDaysForecast?
    
    
    //Set table view rows
    func rowsNumberInTable(_ section: Int) -> Int {
        var row = 0
        if section == 0 {
            row = fiveDaysForecast?.dailyForecast.count ?? 1
        } else if section == 1 {
            row = 1
        }
        return row
    }
    
    
    //MARK: - Networking
    
    //Recieve one hour forecast
    func loadOneHourForecast(completion: @escaping ([OneHourForecast]) -> Void) {
        hourService.fetchOneHour { [weak self] (oneHour) in
            self?.oneHourForecasts = oneHour
            completion(oneHour)
        }
    }
    
    func loadTwelveHoursForecast(completion: @escaping ([TwelveHoursForecast]) -> Void) {
        twelveHoursService.fetchTwelveHours { [weak self] (twelveHours) in
            self?.twelveHourForecasts = twelveHours
            completion(twelveHours)
        }
    }
    
    //Recieve five days forecast
    func loadFiveDaysForecast(completion: @escaping (FiveDaysForecast) -> Void) {
        fiveDaysService.fetchFiveDays { [weak self] (fiveDays) in
            self?.fiveDaysForecast = fiveDays
            completion(fiveDays)
        }
    }

    //Open URL
    var safariLink: String {
        get {
            return oneHourForecasts?.first?.mobLink ?? "https://developer.accuweather.com"
        }
    }
    
}






//let isoDate = "2019-11-23T07:00:00+02:00"
//
//let dateFormatter = DateFormatter()
//dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//let formattedDate = dateFormatter.date(from: isoDate)!
//
//let calendar = Calendar.current
//let minutes = calendar.component(.minute, from: formattedDate)
//let hours = calendar.component(.hour, from: formattedDate)
//let day = calendar.component(.weekday, from: formattedDate)
