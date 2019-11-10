//
//  MainPresenter.swift
//  WeatherApp
//
//  Created by Admin on 09.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit


class MainPresenter: SetMainCityViewProtocol {
 

    weak var mainView: MainViewController?
    weak var interactor: MainInteractor?
    
    let degree = "°"
    var images = Images(spring: "spring.jpg", summer: "summer.jpg", autumn: "autumn.jpg", winter: "winter")
    
    //MARK: - Set main city name and temperature view (first view)
    func setImage(_ background: UIImageView) {
        background.image = UIImage(named: images.autumn)
    }

    func setCityName(_ cityLabel: UILabel) {
        cityLabel.text = "Volyn"
     }
     
    func setCurrentTemperature(_ temperatLabel: UILabel) {
        temperatLabel.text = "19" + degree
     }
     
    func setCurrentForecast(_ forecastLabel: UILabel) {
        forecastLabel.text = "qwertyuiop"
     }
    
    
    //MARK: - Set main collection view (second view)
    
    
    //MARK: - Set main table view (third view)
    
    
    
}
