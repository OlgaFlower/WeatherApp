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
    let datalocationKey = APILocationKey()
    let dataHour = APIOneHourForecast()
    let dataTwelveHours = APITwelveHoursForecast()
    let dataFiveDays = APIFiveDaysForecast()

    //structs
    var locationKeys: [LocationKey]?
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
        dataHour.OneHourData { [weak self] (data) in
            self?.oneHourForecasts = data
            completion(data)
        }
    }
    
    func loadTwelveHoursForecast(completion: @escaping ([TwelveHoursForecast]) -> Void) {
        dataTwelveHours.TwelveHoursData { [weak self] (data) in
            self?.twelveHourForecasts = data
            completion(data)
        }
    }
    
    //Recieve five days forecast
    func loadFiveDaysForecast(completion: @escaping (FiveDaysForecast) -> Void) {
        dataFiveDays.FiveDaysData { [weak self] (data) in
            self?.fiveDaysForecast = data
            completion(data)
        }
    }
    
    //Recieve local key
    func loadLocationKey(completion: @escaping ([LocationKey]) -> Void) {
        datalocationKey.LocationKeyData { [weak self] (data) in
            self?.locationKeys = data
            completion(data)
        }
    }
    

    //Safari Link
    var safariLink: String {
        get {
            return oneHourForecasts?.first?.mobLink ?? "https://developer.accuweather.com"
        }
    }
    
    
}



