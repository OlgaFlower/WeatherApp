//
//  ListViewController.swift
//  WeatherApp
//
//  Created by Admin on 21.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DisplayFaviuriteList {
    func addCity(_ city: Favourite) {
        favouriteCities.append(city)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    

    //Outlet
    @IBOutlet weak var tableView: UITableView!
    
    //Properties
    var favouriteCities = [Favourite]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ListController \(favouriteCities)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Clear the navigation bar background
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favouriteCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListCell
        cell.favouriteCityLabel.text = favouriteCities[indexPath.row].city
        return cell
    }
    

    @IBAction func addCity() {
        if let searchVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController {
            searchVC.delegate = self
            navigationController?.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    
}
