//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Admin on 09.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    //MARK: - City name and temperature view
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var forecastLabel: UILabel!
    
    //MARK: - 24-hour forecast view
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    //MARK: - Week and sun&moon forecast view
    @IBOutlet weak var mainTableView: UITableView!
    
    
    private let presenter = MainPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCollectionView.register(MainHourForecastCollectionViewCell.self, forCellWithReuseIdentifier: "HourCollectionCell")
        
        presenter.setCurrentTemperatureView(backgroundImage, cityNameLabel, temperatureLabel, forecastLabel)
    }
    

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            "HourCollectionCell", for: indexPath) as? MainHourForecastCollectionViewCell
        let image = UIImage(named: "rain.png")
        cell?.displayContent(image!, "16", "23°")
        return cell!
    }


}


