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
    
    let degree = "°"
    var images = Images(spring: "spring.jpg", summer: "summer.jpg", autumn: "autumn.jpg", winter: "winter")
    var icons = Icons(rain: "rain.png", snow: "snow.png", cloud: "sunAndCloud.png")
    
    //MARK: - Set current temperature view (first view)
    func setCurrentTemperatureView(_ background: UIImageView, _ city: UILabel, _ temperature: UILabel, _ forecast: UILabel) {
        background.image = UIImage(named: images.autumn)
        city.text = "Uzhorod"
        temperature.text = "17" + degree
        forecast.text = "qwertyui"
    }
    
    

    
    //MARK: - Set main table view (third view)
    
    
    
}
