//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Admin on 09.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    //MARK: - City name and temperature view
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var forecastLabel: UILabel!
    
    //MARK: - 24-hour forecast view
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    //MARK: - Week and sun&moon forecast view
    @IBOutlet weak var mainTableView: UITableView!
    

    let presenter = MainPresenter()
    
    var arr = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: - Main view delegates
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainTableView.delegate = self
        mainTableView.dataSource = self

        presenter.setCurrentTemperatureView(backgroundImage, cityNameLabel, temperatureLabel, forecastLabel)
        
//        presenter.loadDayData { (data) in
//            print(data)
//            DispatchQueue.main.async {
//                self.mainTableView.reloadData()
//            }
//        }
        
        
//        presenter.loadLocationKey { (data) in
//            print(data)
//        }
        
    }
    
}



