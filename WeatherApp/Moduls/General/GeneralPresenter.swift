//
//  GeneralPresenter.swift
//  WeatherApp
//
//  Created by Admin on 07.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit
class GeneralPresenter {
    
    var number = GeneralRowsAndSections()
    let data = OneDayForecastData()
    var forecast = OneDay()
    
    func loadForecastData(completion: @escaping (OneDay) -> ()) {
        data.getForecastData { [weak self](forecast) in
            self?.forecast = forecast
            completion(forecast)
        }
    }
    
    func numberOfSections() -> Int {
        return number.sectionsAndRows.count
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return number.arrOfSectionsAndRows()[section].rows
        
    }

    
    
    
    
}


