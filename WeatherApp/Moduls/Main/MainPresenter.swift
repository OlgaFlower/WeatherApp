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
    let tableRows = MainRowsAndSections()
    
    //MARK: - Data
    let datalocationKey = APILocationKey()
    let dataHourForecast = APIOneHourForecast()
    
    
    var images = Images(spring: "spring.jpg", summer: "summer.jpg", autumn: "autumn.jpg", winter: "winter")
    var icons = Icons(rain: "rain.png", snow: "snow.png", cloud: "sunAndCloud.png")
    
    var fetchLocationKey = [LocationKey]()
    var fetchOneHourForecast = [OneHourForecast]()
    
    
    
    
    //MARK: - Set current forecast view (first view)
//    func setCurrentTemperatureView(_ background: UIImageView, _ city: UILabel, _ temperature: UILabel, _ forecast: UILabel) {
//        background.image = UIImage(named: images.autumn)
//        city.text = "Uzhorod"
//        temperature.text = "17" + Helper.degree
//        forecast.text = "qwertyui"
//    }
    
    //MARK: - Set table view rows (third view)
    func numberOfRowsInTable(_ section: Int) -> Int {
        return tableRows.arrOfSectionsAndRows()[section].rows
    }
    
    //MARK: - Networking
    
    //Recieve one hour forecast
    func loadOneHourForecast(completion: @escaping ([OneHourForecast]) -> Void) {
        dataHourForecast.get1Hour { [weak self] (data) in
            self?.fetchOneHourForecast = data
            completion(data)
        }
    }
    
    
    //Recieve local key
    func loadLocationKey(completion: @escaping ([LocationKey]) -> Void) {
        datalocationKey.fetchLocationKey { [weak self] (data) in
            self?.fetchLocationKey = data
            completion(data)
        }
    }
    

    //Safari Link
    var safariLink: String {
        get {
            return fetchOneHourForecast.first?.mobLink ?? "https://developer.accuweather.com"
        }
    }
    
    
}



