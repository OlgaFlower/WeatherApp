//
//  GeneralPresenter.swift
//  WeatherApp
//
//  Created by Admin on 07.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit
class GeneralPresenter {
    
    //MARK: - General Controller
    
    var number = GeneralRowsAndSections()
    let data = OneDayForecastData()
    var forecast = OneDay()
    var generalCell = GeneralCityAndTemperatureCell()
    
    //-----------
    var name = "Vinnytsia"
    var weatherForecast = "Everything will be fine!"
    var tem = "42°"
    var img = UIImage(named: "rain.jpg")
    //-------------
    
    
    
    func loadForecastData(completion: @escaping (OneDay) -> ()) {
        data.getForecastData { [weak self](forecast) in
            self?.forecast = forecast
            completion(forecast)
        }
    }
    
    
    //MARK: - Set tableView
    func numberOfSections() -> Int {
        return number.sectionsAndRows.count
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return number.arrOfSectionsAndRows()[section].rows
        
    }

    
    
}

