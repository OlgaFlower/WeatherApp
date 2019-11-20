//
//  ListTableViewController.swift
//  WeatherApp
//
//  Created by Admin on 12.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButton(_ sender: Any) {
        let searchVC = storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
        self.present(searchVC, animated: true, completion: nil)
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }

}
