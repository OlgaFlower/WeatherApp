//
//  SearchViewcontroller.swift
//  WeatherApp
//
//  Created by Admin on 17.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit

protocol DisplayFaviuriteList: class {
    func addCity(_ city: Favourite)
}


class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: DisplayFaviuriteList?
    
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
        searchCity.obscuresBackgroundDuringPresentation = false //unblock view (search blocks it)
        tableView.dataSource = self
        tableView.delegate = self
      
        searchCity.searchResultsUpdater = self
        definesPresentationContext = true
        tableView.tableHeaderView = searchCity.searchBar
        searchCity.searchBar.tintColor = UIColor.white
        searchCity.searchBar.barTintColor = UIColor.purple
        
    }
    //TODO: - popToRoot
    @IBAction func goHome(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultOfRequest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = resultOfRequest[indexPath.row].cityName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newCity = Favourite(city: resultOfRequest[indexPath.row].cityName, key: resultOfRequest[indexPath.row].key, country: resultOfRequest[indexPath.row].country.name)
        delegate?.addCity(newCity)
        navigationController?.popViewController(animated: true)
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
