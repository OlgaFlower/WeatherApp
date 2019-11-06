//
//  GeneralViewController.swift
//  WeatherApp
//
//  Created by Admin on 06.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit

class GeneralViewController: UIViewController {

    
    var x = OneDayForecastData() //Data
    var one = OneDay() //Model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load { (data) in
        }
    }
    
    func load(completion: @escaping (OneDay) -> ()) {
        x.getLaunchesData { [weak self] (data) in
            self?.one = data
            completion(data)
        }
        
    }

}

