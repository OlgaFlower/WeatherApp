//
//  MainPresenter.swift
//  WeatherApp
//
//  Created by Admin on 09.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit


class MainPresenter {
   
    //MARK: - Main View Controller properties
    weak var mainView: MainViewController?
    weak var collection: MainHourForecastCollectionViewCell?
//    let tableRows = MainRowsAndSections()
    
    //MARK: - Data
    let locationKeyService = APILocationKeyService()
    let hourService = APIOneHourService()
    let twelveHoursService = APITwelveHoursService()
    let fiveDaysService = APIFiveDaysService()

    //structs
    var locationKeys = [LocationKey]()
    var oneHourForecasts: [OneHourForecast]?
    var twelveHourForecasts: [TwelveHoursForecast]?
    var fiveDaysForecast: FiveDaysForecast?
    
    
    //MARK: - Set table view rows (third view)
//    func numberOfRowsInTable(_ section: Int) -> Int {
//        return tableRows.arrOfSectionsAndRows()[section].rows
//    }
    
    func rowsNumberInTable(_ section: Int) -> Int {
        var row = 0
        if section == 0 {
            row = 5
//            row = (fetchFiveDaysForecast?.dailyForecast.count)!
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
    
    //Recieve local key
    func loadLocationKey(completion: @escaping ([LocationKey]) -> Void) {
        locationKeyService.fetchLocationKey { [weak self] (locationKey) in
            self?.locationKeys = locationKey
            completion(locationKey)
        }
    }
    

    //Safari Link
    var safariLink: String {
        get {
            return oneHourForecasts?.first?.mobLink ?? "https://developer.accuweather.com"
        }
    }
    
    
}



