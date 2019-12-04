//
//  SearchViewcontroller.swift
//  WeatherApp
//
//  Created by Admin on 17.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit

//MARK: - DisplayFaviuriteList protocol
protocol DisplayFaviuriteList: class {
    func addCity(_ city: Favourite)
}


class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    //MARK: - SearchVC Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backImage: UIImageView!
    
    //MARK: - SearchVC properties
    weak var delegate: DisplayFaviuriteList?
    let service = APISearchCityService()
    let searchCity = UISearchController(searchResultsController: nil)
    
    var resultOfRequest = [SearchResult]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    //MARK: - SearchVC life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.blurredView(backImage, self.view)
        
        searchCity.obscuresBackgroundDuringPresentation = false //unblock view's user interaction
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
      
        searchCity.searchResultsUpdater = self
        definesPresentationContext = true
        tableView.tableHeaderView = searchCity.searchBar
        
        searchCity.searchBar.tintColor = .gray //"Cancel" color
 
        searchCity.searchBar.barTintColor = #colorLiteral(red: 0.06511645217, green: 0.1596652318, blue: 0.2661897083, alpha: 1)
        searchCity.searchBar.searchTextField.backgroundColor = .clear
        searchCity.hidesNavigationBarDuringPresentation = false
        searchCity.searchBar.backgroundColor = .clear
    }
    
    //MARK: - SearchVC action
    @IBAction func dismissViewButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Set SearchVC Table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return resultOfRequest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = resultOfRequest[indexPath.row].cityName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newCity = Favourite(city: resultOfRequest[indexPath.row].cityName,
                                key: resultOfRequest[indexPath.row].key,
                                country: resultOfRequest[indexPath.row].country.name)
        delegate?.addCity(newCity)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
}

//MARK: - UISearchBar extension
extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        
        if text.count >= 3 {
            service.fetchSearchResult(text) { result in
            self.resultOfRequest = result
            }
        } else {
            self.resultOfRequest.removeAll()
        }
    }
}
