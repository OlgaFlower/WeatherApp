//
//  SearchViewcontroller.swift
//  WeatherApp
//
//  Created by Admin on 17.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    @IBOutlet weak var tableView: UITableView!
    
    let service = APISearchCityService()
    let presenter = SearchPresenter()
    var resultOfRequest = [SearchResult]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    let searchCity = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
      
        searchCity.searchResultsUpdater = self
        definesPresentationContext = true
        tableView.tableHeaderView = searchCity.searchBar
        searchCity.searchBar.tintColor = UIColor.white
        searchCity.searchBar.barTintColor = UIColor.purple
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultOfRequest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cities = resultOfRequest[indexPath.row]
        cell.textLabel?.text = cities.cityName
        return cell
    }
    
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        
        if text.count >= 3 {
            presenter.searchService.fetchSearchResult(text) { result in
            self.resultOfRequest = result
            }
        } else {
            self.resultOfRequest.removeAll()
        }
    }
}
