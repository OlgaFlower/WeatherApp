//
//  SetMainCityAndTemperatureViewProtocol.swift
//  WeatherApp
//
//  Created by Admin on 09.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit

protocol SetMainCityViewProtocol {
    func setImage(_ background :UIImageView)
    func setCityName(_ cityLabel: UILabel)
    func setCurrentTemperature(_ temperatLabel: UILabel)
    func setCurrentForecast(_ forecastLabel: UILabel)
}


