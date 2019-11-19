//
//  SearchViewcontroller.swift
//  WeatherApp
//
//  Created by Admin on 17.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
  
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self as? UITableViewDataSource
        tableView.delegate = self as? UITableViewDelegate
      
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor.green
        
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
      }
}

