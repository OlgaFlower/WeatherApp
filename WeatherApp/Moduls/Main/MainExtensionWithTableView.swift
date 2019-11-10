//
//  MainExtensionWithTableView.swift
//  WeatherApp
//
//  Created by Admin on 10.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit

//MARK: - Main table view
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeekCell", for: indexPath) as! MainWeekCell
        return cell
    }
    
    
}
