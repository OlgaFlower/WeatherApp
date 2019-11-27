//
//  ListViewController.swift
//  WeatherApp
//
//  Created by Admin on 21.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//




import UIKit
import CoreData


protocol DisplayCityName: class {
    func displayCity(_ cityName: String)
}


class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DisplayFaviuriteList {
    
    //Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backImage: UIImageView!
    
    //Properties
    weak var delegate: DisplayCityName?
    var helper = Helper()
    var savedCities = [CityItem]() //restore data from DB
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        
        Helper.blurredView(backImage, self.view)
        loadCityItems()
    }
    
    func addCity(_ city: Favourite) {
        let newItem = CityItem(context: context) //DB
        newItem.cityName = city.city
        newItem.cityKey = city.key
        newItem.countryName = city.country
        
        self.saveCityItems() //DB
        
    }
    
    func saveCityItems() { //DB
        do {
            try context.save()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadCityItems() { //DB
        let request: NSFetchRequest<CityItem> = CityItem.fetchRequest() //request for an array of CityItem
        do {
            savedCities = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Clear the navigation bar background
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func backButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
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
            self.delegate?.displayCity(self.savedCities[indexPath.row].cityName!)
            _ = self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { delete in
            self.context.delete(self.savedCities[indexPath.row]) //delete chosen city from DB
            self.savedCities.remove(at: indexPath.row) //delete chosen city from list
            self.saveCityItems()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func addCity() {
        if let searchVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController {
            searchVC.delegate = self
            navigationController?.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    
    func makeChoiceAlert(_ city: String, _ country: String, _ controller: UIViewController) {
        
    }
    
}
