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
    
    
    var presenter = MainPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCurrentForecastView()
        
    }
    
    //MARK: - First View
    func setCurrentForecastView() {
        presenter.setImage(backgroundImage)
        presenter.setCityName(cityNameLabel)
        presenter.setCurrentTemperature(temperatureLabel)
        presenter.setCurrentForecast(forecastLabel)
    }


}
