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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: - Main view delegates
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainTableView.delegate = self
        mainTableView.dataSource = self

        //Set current temperature view
        presenter.loadOneHourForecast { (oneHour) in
            DispatchQueue.main.async {
                self.temperatureLabel.text = "\(Int(oneHour.first!.temperat.temperatValue))" + "\(Helper.degree)"
                self.forecastLabel.text = oneHour.first?.iconPhrase
            }
        }
        backgroundImage.image = UIImage(named: "autumn.jpg")
        cityNameLabel.text = "Some City"
        
        //Set collection view
        presenter.loadTwelveHoursForecast { (twelveHours) in
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
            }
        }
        
        //set table view
        presenter.loadFiveDaysForecast { (fiveDays) in
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
        }
    }
    
    @IBAction func openLinkButton(_ sender: UIButton) {
        self.openSafari(for: presenter.safariLink)
    }

    @IBAction func openListButton(_ sender: UIButton) { }

    
    
}




//MARK: - Main Collection ext.
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.twelveHourForecasts?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MainHourForecastCollectionViewCell
        if indexPath.row == 0 {
            cell.timeLabel.text = "Now"
        } else {
            // FIXME: descriptioklv
            // cell.timeLabel.text = presenter.twelveHourForecasts?[indexPath.row].time.description
            
            cell.timeLabel.text = Helper.dateConverter((presenter.twelveHourForecasts?[indexPath.row].time)!, Helper.hourFormat)
        }
        cell.iconImage.image = UIImage(named: "muchSnow.png")
        cell.temperatLabel.text = "\(String(describing: presenter.twelveHourForecasts?[indexPath.row].temperat.temperatValue))" + Helper.degree
        return cell
    }
}


//MARK: - Main tableView ext.
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return presenter.rowsNumberInTable(section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: let cell = tableView.dequeueReusableCell(withIdentifier: "WeekCell", for: indexPath) as! MainWeekCell
                //unwrap values in table view cells
                guard let fiveDayForecast = presenter.fiveDaysForecast else { return cell }
        
                cell.dayLabel.text = Helper.dateConverter(fiveDayForecast.dailyForecast[indexPath.row].date, Helper.weekDayFormat)
                cell.maxLabel.text = "\(Int(fiveDayForecast.dailyForecast[indexPath.row].temperat.max.value))" + Helper.degree
                cell.minLabel.text = "\(Int(fiveDayForecast.dailyForecast[indexPath.row].temperat.min.value))" + Helper.degree
                cell.iconImage.image = UIImage(named: "sunAndCloud.png")
                return cell
        
        case 1: let cell = tableView.dequeueReusableCell(withIdentifier: "SunMoonCell", for: indexPath) as! MainSunCell
                //unwrap values in table view cells
                guard let fiveDayForecast = presenter.fiveDaysForecast else { return cell}
        
                cell.sunIconImage.image = UIImage(named: "sun2.png")
                cell.sunriseLabel.text = "Sunrise"
                cell.sunriseTimeLabel.text = Helper.dateConverter((fiveDayForecast.dailyForecast.first?.sun.sunriseTime)!, Helper.hourFormat)
                cell.sunsetLabel.text = "Sunset"
                cell.sunsetTimeLabel.text = Helper.dateConverter((fiveDayForecast.dailyForecast.first?.sun.sunsetTime)!
            , Helper.hourFormat)
        cell.moonIconImage.image = UIImage(named: "moon.png")
                return cell
        default: break
        }
        return UITableViewCell()
    }
    
}


//MARK: - Open web
extension MainViewController {
    func openSafari(for url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
}
