//
//  MainPresenter.swift
//  WeatherApp
//
//  Created by Admin on 09.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit
import CoreData


class MainPresenter {
   
    weak var mainView: MainViewController?
    weak var collection: MainHourForecastCollectionViewCell?
    
    let hourService = APIOneHourService()
    let twelveHoursService = APITwelveHoursService()
    let fiveDaysService = APIFiveDaysService()

    var oneHourForecasts: [OneHourForecast]?
    var twelveHourForecasts: [TwelveHoursForecast]?
    var fiveDaysForecast: FiveDaysForecast?
    var chosenCity: [DisplayCityForecast]?
    
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
    
    
 //   //MARK: - Networking
    
    
//    func loadCityItems() -> [DisplayCityForecast] { //DB
//        var data = [DisplayCityForecast]()
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let request: NSFetchRequest = DisplayCityForecast.fetchRequest() //request for an array of CityItem
//        do {
//            data = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//        return data
//    }
    
    
    

    
    //Recieve one hour forecast
    func loadOneHourForecast(_ key: String, completion: @escaping ([OneHourForecast]) -> Void) {
        hourService.fetchOneHour(key) { [weak self] (oneHour) in
            self?.oneHourForecasts = oneHour
            completion(oneHour)
        }
    }
    
    
    //Recieve twelve hours forecast
    func loadTwelveHoursForecast(_ key: String, completion: @escaping ([TwelveHoursForecast]) -> Void) {
        twelveHoursService.fetchTwelveHours(key) { [weak self] (twelveHours) in
            self?.twelveHourForecasts = twelveHours
            completion(twelveHours)
        }
    }
    
    //Recieve five days forecast
    func loadFiveDaysForecast(_ key: String, completion: @escaping (FiveDaysForecast) -> Void) {
        fiveDaysService.fetchFiveDays(key) { [weak self] (fiveDays) in
            self?.fiveDaysForecast = fiveDays
            completion(fiveDays)
        }
    }

    func loadAllData(_ key: String) {
        loadOneHourForecast(key) { oneHour in
            DispatchQueue.main.async {
                self.mainView?.temperatureLabel.text = "\(Int(oneHour.first!.temperat.temperatValue))" + Helper.degree
                self.mainView?.forecastLabel.text = oneHour.first?.iconPhrase
                self.mainView?.nowTemperat = "\(Int(oneHour.first!.temperat.temperatValue))" + Helper.degree
                self.mainView?.nowIcon = "\(oneHour.first!.weatherIcon)"
                self.mainView?.cityNameLabel.text = self.mainView?.dataToDisplay?.last?.cityToDisplay
            }
        }
    }
    
    //Open URL
    var safariLink: String {
        get {
            return oneHourForecasts?.first?.mobLink ?? "https://developer.accuweather.com"
        }
    }
    
    
    
}


