//
//  GeneralTableViewController.swift
//  WeatherApp
//
//  Created by Admin on 07.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit

class GeneralTableViewController: UITableViewController {
    
    @IBOutlet weak var generalTableView: UITableView!
    
    var presenter = GeneralPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadForecastData { (forecast) in
            print(forecast)
            DispatchQueue.main.async {
                self.generalTableView.reloadData()
                self.generalTableView.reloadInputViews()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        generalTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return presenter.numberOfRows(section)
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = presenter.forecast.headLine.text
        return cell
    }
 

}
