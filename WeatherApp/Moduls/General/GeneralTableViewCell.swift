//
//  GeneralTableViewCell.swift
//  WeatherApp
//
//  Created by Admin on 08.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit

class GeneralTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatLabel: UILabel!
    @IBOutlet weak var weatherForecastLabel: UILabel!
    
    
    var generalBackgroundImage: [UIImage] = [
        UIImage(named: "rain4.png")!,
        UIImage(named: "rain.jpg")!
    ]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
}
