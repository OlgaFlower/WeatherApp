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
        let image: UIImage
        let cityName: String
        let temperature: String
        let weatherForecast: String
        
        init(image: UIImage, cityName: String, temperature: String, weatherForecast: String) {
            self.image = image
            self.cityName = cityName
            self.temperature = temperature
            self.weatherForecast = weatherForecast
        }
    }

}
