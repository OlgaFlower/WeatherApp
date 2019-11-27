//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Admin on 09.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit
import SafariServices

class MainViewController: UIViewController, DisplayCityName {
    
    //MARK: - MainVC Outlets
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var forecastLabel: UILabel!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var mainTableView: UITableView!
    
    //MARK: - MainVC properties
    let presenter = MainPresenter()
    var helper = Helper()
    var nowTemperat = ""
    var nowIcon = ""
    
    //MARK: - MainVC life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = UIColor.clear
        
        self.mainCollectionView.showsHorizontalScrollIndicator = false
        
        //Set city and current temperature view
        presenter.loadOneHourForecast { (oneHour) in
            DispatchQueue.main.async {
                self.temperatureLabel.text = "\(Int(oneHour.first!.temperat.temperatValue))" + Helper.degree
                self.forecastLabel.text = oneHour.first?.iconPhrase
                self.nowTemperat = "\(Int(oneHour.first!.temperat.temperatValue))" + Helper.degree
                self.nowIcon = "\(oneHour.first!.weatherIcon)"
            }
        }
        
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
        
        Helper.movingEffect(view: backgroundImage, intensity: 45)
    }

    //MARK: - Set MainVC city name
    func displayCity(_ cityName: String) {
        cityNameLabel.text = cityName
         }

    //MARK: - MainVC Actions
    @IBAction func openLinkButton(_ sender: UIButton) {
        self.openSafari(for: presenter.safariLink)
    }

    @IBAction func openListButton(_ sender: UIButton) {
        if let listVC = UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "ListViewController") as? ListViewController {
        listVC.delegate = self
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(listVC, animated: true)

        }
    }
    
}


//MARK: - Set MainVC Collection
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let forecast = presenter.twelveHourForecasts else { return 0 }
        return forecast.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MainHourForecastCollectionViewCell
        guard let twelveHours = presenter.twelveHourForecasts else { return cell }
        if indexPath.row == 0 {
            cell.timeLabel.text = "Now"
            cell.temperatLabel.text = nowTemperat
            cell.iconImage.image = UIImage(named: nowIcon + Helper.png)
        } else {
            cell.timeLabel.text = Helper.dateConverter(((presenter.twelveHourForecasts?[indexPath.row - 1].time)!), Helper.hourFormat)
            cell.temperatLabel.text = "\(String(Int(twelveHours[indexPath.row - 1].temperat.temperatValue)))" + Helper.degree
            let icon = "\(twelveHours[indexPath.row - 1].weatherIcon)"
            cell.iconImage.image = UIImage(named: icon + Helper.png)
        }
        return cell
    }
}


//MARK: - Set MainVC tableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
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
                let icon = "\(fiveDayForecast.dailyForecast[indexPath.row].dayIcon.icon)"
                cell.iconImage.image = UIImage(named: icon + Helper.png)
                return cell
        
        case 1: let cell = tableView.dequeueReusableCell(withIdentifier: "SunMoonCell", for: indexPath) as! MainSunCell
                //unwrap values in table view cells
                guard let fiveDayForecast = presenter.fiveDaysForecast else { return cell}
        
                cell.sunIconImage.image = UIImage(named: "1.png")
                cell.sunriseLabel.text = "Sunrise"
                cell.sunriseTimeLabel.text = Helper.dateConverter((fiveDayForecast.dailyForecast.first?.sun.sunriseTime)!, Helper.hourFormat)
                cell.sunsetLabel.text = "Sunset"
                cell.sunsetTimeLabel.text = Helper.dateConverter((fiveDayForecast.dailyForecast.first?.sun.sunsetTime)!
            , Helper.hourFormat)
        cell.moonIconImage.image = UIImage(named: "33.png")
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


