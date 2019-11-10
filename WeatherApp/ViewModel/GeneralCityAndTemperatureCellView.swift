//
//  GeneralCityAndTemperatureCellView.swift
//  WeatherApp
//
//  Created by Admin on 07.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit

class CityTempData {
    
    struct CityAndTemperData {
        var image: UIImage
        var cityName: String
        var temperature: String
        var weatherForecast: String
        
        init(image: UIImage, cityName: String, temperature: String, weatherForecast: String) {
            self.image = image
            self.cityName = cityName
            self.temperature = temperature
            self.weatherForecast = weatherForecast
        }
    }

}
