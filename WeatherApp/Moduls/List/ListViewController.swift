//
//  ListViewController.swift
//  WeatherApp
//
//  Created by Admin on 21.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//




import UIKit
import CoreData

//MARK: - DisplayCityName protocol
protocol DisplayCityName: class {
    func displayCity(_ cityName: String)
}


class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DisplayFaviuriteList {
    
    //MARK: - ListVC Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backImage: UIImageView!
    
    //MARK: - ListVC Properties
    weak var delegate: DisplayCityName?
    var savedCities = [CityItem]() //restore data from DB
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - ListVC life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Clear the navigation bar background
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        
        Helper.blurredView(backImage, self.view)
        loadCityItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadCityItems()
    }
    //MARK: - DB
    func addCity(_ city: Favourite) {
//        let newItem = CityItem(context: context) //DB
//        newItem.cityName = city.city
//        newItem.cityKey = city.key
//        newItem.countryName = city.country
//        
//        let chosenCity = DisplayCityForecast(context: context)
//        chosenCity.city = city.city
//        chosenCity.key = city.key
//        
//        self.saveCityItems() //DB
    }
    
    func saveCityItems() { //DB
        do {
            try context.save()
            
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadCityItems() { //DB
        let request: NSFetchRequest<CityItem> = CityItem.fetchRequest() //request for an array of CityItem
        do {
            savedCities = try context.fetch(request)
            if savedCities.isEmpty {
                self.navigationItem.leftBarButtonItem?.isEnabled = false
                self.navigationItem.leftBarButtonItem?.tintColor = UIColor.clear
            } else {
                self.navigationItem.leftBarButtonItem?.isEnabled = true
                self.navigationItem.leftBarButtonItem?.tintColor = UIColor.lightGray
            }
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    
    //MARK: - ListVC actions
    @IBAction func backButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addCity() {
        if let searchVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController {
            searchVC.delegate = self
            navigationController?.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    
    //MARK: - Set ListVC Table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListCell
        cell.selectionStyle = .none
        cell.favouriteCityLabel.text = savedCities[indexPath.row].cityName
        cell.countryIdLabel.text = savedCities[indexPath.row].countryName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "\(String(savedCities[indexPath.row].cityName!))\n\(String(savedCities[indexPath.row].countryName!))", message: "", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Display", style: UIAlertAction.Style.default, handler: { display in
            self.removeOldDisplayedItem()
            let chosenCity = DisplayCityForecast(context: self.context)
            
            chosenCity.city = self.savedCities[indexPath.row].cityName
            chosenCity.country = self.savedCities[indexPath.row].countryName
            chosenCity.key = self.savedCities[indexPath.row].cityKey
            chosenCity.timeZone = self.savedCities[indexPath.row].timeZone
            self.saveCityItems() //save to DB
            
            _ = self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { delete in
            self.context.delete(self.savedCities[indexPath.row]) //delete chosen city from DB
            self.savedCities.remove(at: indexPath.row) //delete chosen city from VC list
            self.saveCityItems()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            if self.savedCities.isEmpty {
                self.removeOldDisplayedItem()
                self.navigationItem.leftBarButtonItem?.isEnabled = false
                self.navigationItem.leftBarButtonItem?.tintColor = UIColor.clear
            }
         
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
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

}
