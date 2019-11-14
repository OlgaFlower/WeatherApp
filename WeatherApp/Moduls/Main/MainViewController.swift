//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Admin on 09.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit
import SafariServices

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    
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
 
//        presenter.loadLocationKey { (data) in
//            print(data)
//        }
        
        //Set current temperature view
        presenter.loadOneHourForecast { (data) in
            DispatchQueue.main.async {
                self.mainView.reloadInputViews()
                self.temperatureLabel.text = "\(data.first!.temperat.temperatValue)" + "\(Helper.degree)"
                self.forecastLabel.text = data.first?.iconPhrase
            }
        }
        backgroundImage.image = UIImage(named: "autumn.jpg")
        cityNameLabel.text = "Some City"
        
        //Set collection view
        presenter.loadTwelveHoursForecast { (data) in
            
        }
        
        
    }
    
    @IBAction func openLinkButton(_ sender: UIButton) {
        self.openSafari(for: presenter.safariLink)
    }

    @IBAction func openListButton(_ sender: UIButton) { }
    
}



