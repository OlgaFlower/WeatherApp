//
//  MainPresenter.swift
//  WeatherApp
//
//  Created by Admin on 09.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit


class MainPresenter: SetMainCurrentTemperatureProtocol {
   
    //MARK: - Main View Controller properties
    weak var mainView: MainViewController?
    weak var collection: MainHourForecastCollectionViewCell?
    let tableRows = MainRowsAndSections()
    //MARK: - Data
    let dataDayForecast = APIDay()
    var datalocationKey = APILocationKey()
    
    
    let degree = "°"
    var images = Images(spring: "spring.jpg", summer: "summer.jpg", autumn: "autumn.jpg", winter: "winter")
    var icons = Icons(rain: "rain.png", snow: "snow.png", cloud: "sunAndCloud.png")
    var getdayForecast = DayForecast()
    var getLocationKey = [LocationKey]()
    
    
    //MARK: - Open Safari Link
    var safariLink: String {
        get {
            return getdayForecast.headLine.mobileLink ?? "https://developer.accuweather.com"
        }
    }
    
    //MARK: - Set current temperature view (first view)
    func setCurrentTemperatureView(_ background: UIImageView, _ city: UILabel, _ temperature: UILabel, _ forecast: UILabel) {
        background.image = UIImage(named: images.autumn)
        city.text = "Uzhorod"
        temperature.text = "17" + degree
        forecast.text = "qwertyui"
    }
    
    //MARK: - Set table view rows (third view)
    func numberOfRowsInTable(_ section: Int) -> Int {
        return tableRows.arrOfSectionsAndRows()[section].rows
    }
    
    //MARK: - Networking: Recieve DayForecast
    func loadDayData(completion: @escaping (DayForecast) -> ()) {
        dataDayForecast.getForecastData { [weak self] (data) in
            self?.getdayForecast = data
            completion(data)
        }
    }
    
    //MARK: - Networking: Recieve local key
    func loadLocationKey(completion: @escaping ([LocationKey]) -> ()) {
        datalocationKey.getLocationKey { [weak self] (data) in
            self?.getLocationKey = data
            completion(data)
        }
    }
    

    
}



