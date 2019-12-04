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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext //DB
    var timeZoneCode: String? = nil
    
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
//                print("ONE HOUR DISPATCH key \(String(describing: forecast.key))")
                self.temperatureLabel.text = "\(Int(oneHour.first!.temperat.temperatValue))" + Helper.degree
                self.forecastLabel.text = oneHour.first?.iconPhrase
                self.nowTemperatCollectionView = "\(Int(oneHour.first!.temperat.temperatValue))" + Helper.degree
                self.nowIconCollectionView = "\(oneHour.first!.weatherIcon)"
                self.cityNameLabel.text = self.dataToDisplay?.last?.cityToDisplay
                self.mainCollectionView.reloadData()
            }
        }
        
        //Set collection view
        presenter.loadTwelveHoursForecast(forecast.key!) { (twelveHours) in
            DispatchQueue.main.async {
//                print("12 HOURS DISPATCH key \(String(describing: forecast.key))")
                self.mainCollectionView.reloadData()
            }
        }
        
        //set table view
        presenter.loadFiveDaysForecast(forecast.key!) { (fiveDays) in
            DispatchQueue.main.async {
//                print("5 DAYS DISPATCH key \(String(describing: forecast.key))")
                self.mainTableView.reloadData()
            }
        }
        
        presenter.loadTimeZoneCode(forecast.key!) { (code) in
            print("TOMEZONECODE *** \(code.timeZone.code)")
            self.timeZoneCode = code.timeZone.code
        }
    }
    
    
    
    
    func displayViewController() {
        let request: NSFetchRequest<CityItem> = CityItem.fetchRequest() //get cities' list from DB
        do {
            citiesList = try context.fetch(request)
            print("displayViewController(): citiesList \(String(describing: citiesList))")
            if citiesList!.isEmpty {
                removeOldDisplayedItem()
                showListViewController()
            } else {
                loadDataToDisplay()
                fetchDataAndDisplayOnScreen()
                print("after deleting \(String(describing: citiesList))")
            }
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    
    
    //MARK: - Data Base
    //LOAD
    func loadDataToDisplay() { //load from DB
        let request: NSFetchRequest = DisplayCityForecast.fetchRequest()
        do {
            self.dataToDisplay = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    
    //REMOVE
    func removeOldDisplayedItem() { //load from DB
        let request: NSFetchRequest = DisplayCityForecast.fetchRequest()
        do {
            let items = try context.fetch(request)
            for el in 0 ..< items.count {
                self.context.delete(items[el])
                saveCityItems()
            }
            
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    //SAVE
    func saveCityItems() { //DB
        do {
            try context.save()
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    
    //MARK: - MainVC Actions
    @IBAction func openLinkButton(_ sender: UIButton) {
        self.openSafari(for: presenter.safariLink)
    }
    
    @IBAction func openListButton(_ sender: UIButton) {
        showListViewController()
    }
    
    
    func showListViewController() {
        if let listVC = UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "ListViewController") as? ListViewController {
            listVC.delegate = self as? DisplayCityName
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
            cell.temperatLabel.text = nowTemperatCollectionView
            cell.iconImage.image = UIImage(named: nowIconCollectionView + Helper.png)
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
        
        cell.sunIconImage.image = UIImage(named: "1.png") //static sun icon
        cell.sunriseLabel.text = "Sunrise"
        cell.sunriseTimeLabel.text = Helper.timeZoneConverter((fiveDayForecast.dailyForecast.first?.sun.sunriseTime)!, timeZoneCode!) //------------------
        cell.sunsetLabel.text = "Sunset"
        cell.sunsetTimeLabel.text = Helper.timeZoneConverter((fiveDayForecast.dailyForecast.first?.sun.sunsetTime)!, timeZoneCode!) //--------------------------
        cell.moonIconImage.image = UIImage(named: "33.png") //static moon icon
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


