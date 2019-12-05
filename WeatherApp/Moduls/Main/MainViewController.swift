//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Admin on 09.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit
import SafariServices
import CoreData

class MainViewController: UIViewController {
    
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
    var nowTemperatCollectionView = ""
    var nowIconCollectionView = ""
    var dataToDisplay: [DisplayCityForecast]?
    var citiesList: [CityItem]?
    
//    var timeZone: String? = nil
    
    //MARK: - MainVC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = UIColor.clear
        self.mainCollectionView.showsHorizontalScrollIndicator = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        Helper.movingEffect(view: backgroundImage, intensity: 45)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        displayViewController()
    }
    
    
    func fetchDataAndDisplayOnScreen() {
        guard let forecast = dataToDisplay?.last else { return }
        
        presenter.loadOneHourForecast(forecast.key!) { (oneHour) in
            DispatchQueue.main.async {
                self.temperatureLabel.text = "\(Int(oneHour.first!.temperat.temperatValue))" + Helper.degree
                self.forecastLabel.text = oneHour.first?.iconPhrase
                self.nowTemperatCollectionView = "\(Int(oneHour.first!.temperat.temperatValue))" + Helper.degree
                self.nowIconCollectionView = "\(oneHour.first!.weatherIcon)"
                self.cityNameLabel.text = self.dataToDisplay?.last?.city
                self.mainCollectionView.reloadData()
            }
        }
        
        //Set collection view
        presenter.loadTwelveHoursForecast(forecast.key!) { (twelveHours) in
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
            }
        }
        
        //set table view
        presenter.loadFiveDaysForecast(forecast.key!) { (fiveDays) in
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
        }
    }
    
    
    func displayViewController() {
        let request: NSFetchRequest<CityItem> = CityItem.fetchRequest() //get cities' list from DB
        do {
            citiesList = try Helper.context.fetch(request)
            if citiesList!.isEmpty {
                removeOldDisplayedItem()
                showListViewController()
            } else {
                loadDataToDisplay()
                fetchDataAndDisplayOnScreen()
            }
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func showListViewController() {
        if let listVC = UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "ListViewController") as? ListViewController {
            listVC.delegate = self as? DisplayCityName
            navigationController?.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(listVC, animated: true)
        }
    }
    
    
    //MARK: - Data Base
    //LOAD
    func loadDataToDisplay() {
        let request: NSFetchRequest = DisplayCityForecast.fetchRequest()
        do {
            self.dataToDisplay = try Helper.context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    
    //REMOVE
    func removeOldDisplayedItem() {
        let request: NSFetchRequest = DisplayCityForecast.fetchRequest()
        do {
            let items = try Helper.context.fetch(request)
            for el in 0 ..< items.count {
                Helper.context.delete(items[el])
                Helper.saveCityItems()
            }
        } catch {
            print("Error fetching data from context \(error)")
        }
    }

    
    //MARK: - MainVC Actions
    @IBAction func openLinkButton(_ sender: UIButton) {
        self.openSafari(for: presenter.safariLink)
    }
    
    @IBAction func openListButton(_ sender: UIButton) {
        showListViewController()
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
        
        cell.iconImage.alpha = 0.2
        
        guard let twelveHours = presenter.twelveHourForecasts else { return cell }
        if indexPath.row == 0 {
            cell.timeLabel.text = "Now"
            cell.temperatLabel.text = nowTemperatCollectionView

            cell.iconImage.image = UIImage(named: nowIconCollectionView + Helper.png)
            
        } else {
            cell.timeLabel.text = Helper.dateConverter(((presenter.twelveHourForecasts?[indexPath.row - 1].time)!),
                                                       .hourFormat,
                                                       (dataToDisplay?.last!.timeZone)!)
            cell.temperatLabel.text = "\(String(Int(twelveHours[indexPath.row - 1].temperat.temperatValue)))" + Helper.degree
            let icon = "\(twelveHours[indexPath.row - 1].weatherIcon)"
            cell.iconImage.image = UIImage(named: icon + Helper.png)
        }
        
        UIView.animate(withDuration: 0.5) {
            cell.iconImage.alpha = 1.0
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
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeekCell", for: indexPath) as! MainWeekCell
            
            //make cell image tranparent
            cell.iconImage.alpha = 0.2
            
            //unwrap values in table view cells
            guard let fiveDayForecast = presenter.fiveDaysForecast else { return cell }
            let dailyForecast = fiveDayForecast.dailyForecast[indexPath.row]
            cell.dayLabel.text = Helper.dateConverter(dailyForecast.date, .weekDayFormat, (dataToDisplay?.last!.timeZone)!)
            cell.maxLabel.text = "\(dailyForecast.temperat.max.value.rounded())" + Helper.degree
            cell.minLabel.text = "\(Int(dailyForecast.temperat.min.value))" + Helper.degree
            let icon = "\(dailyForecast.dayIcon.icon)"
            cell.iconImage.image = UIImage(named: icon + Helper.png)
            
            //animate cell appearence
            UIView.animate(withDuration: 0.5) {
                cell.iconImage.alpha = 1.0
            }

            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SunMoonCell", for: indexPath) as! MainSunCell
            
            //make cell image tranparent
            cell.sunIconImage.alpha = 0.2
            cell.moonIconImage.alpha = 0.2
            
            //unwrap values in table view cells
            guard let fiveDayForecast = presenter.fiveDaysForecast, let sunriseTime = fiveDayForecast.dailyForecast.first?.sun.sunriseTime, let sunsetTime = fiveDayForecast.dailyForecast.first?.sun.sunsetTime, let timeZone = dataToDisplay?.last?.timeZone else {
                
                return cell
            }
            
            cell.sunIconImage.image = UIImage(named: "1.png") //static sun icon
            cell.sunriseLabel.text = "Sunrise"
            cell.sunriseTimeLabel.text = Helper.dateConverter(sunriseTime, .hourFormat, timeZone)
            cell.sunsetLabel.text = "Sunset"
            cell.sunsetTimeLabel.text = Helper.dateConverter(sunsetTime, .hourFormat, timeZone)
            cell.moonIconImage.image = UIImage(named: "33.png") //static moon icon
            
            //animate cell appearence
            UIView.animate(withDuration: 0.5) {
                cell.sunIconImage.alpha = 1.0
                cell.moonIconImage.alpha = 1.0
            }
            return cell
        default:
            break
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


