//
//  HourForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Admin on 09.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit

class MainHourForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatLabel: UILabel!
    
    func displayContent(_ icon: UIImage, _ time: String, _ temperature: String) {
        iconImage.image = icon
        timeLabel.text = time
        temperatLabel.text = temperature
    }
    
}
