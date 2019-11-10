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
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self

        presenter.setCurrentTemperatureView(backgroundImage, cityNameLabel, temperatureLabel, forecastLabel)
    }
    

    
    var arr = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MainHourForecastCollectionViewCell
        cell.timeLabel.text = String(arr[indexPath.row])
        cell.iconImage.image = UIImage(named: "muchSnow.png")
        
        return cell
    }


}


