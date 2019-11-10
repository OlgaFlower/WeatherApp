//
//  SetMainCityAndTemperatureViewProtocol.swift
//  WeatherApp
//
//  Created by Admin on 09.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit

protocol SetMainCurrentTemperatureProtocol {
    func setCurrentTemperatureView(_ background :UIImageView, _ city: UILabel, _ temperature: UILabel, _ forecast: UILabel)
}


protocol SetMainCollectionCellProtocol {
    func setCollectionCell(_ time: UILabel, _ icon :UIImageView, _ temperat: UILabel)
}
