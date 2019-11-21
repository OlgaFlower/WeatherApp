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


