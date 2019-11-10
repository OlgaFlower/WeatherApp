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
    var dataCell: GeneralCityAndTemperatureCell?
    var presenter = GeneralPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "GeneralTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CityCell")
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! GeneralCityAndTemperatureCell
        dataCell?.backgroundImg.image =  UIImage(named: "rain4.png")
        dataCell?.cityNameLabel.text = presenter.name
        dataCell?.weatherForecastLabel.text = presenter.forecast.headLine.text
        dataCell?.temperatLabel.text = presenter.forecast.headLine.text
        return cell
    }
 

}
