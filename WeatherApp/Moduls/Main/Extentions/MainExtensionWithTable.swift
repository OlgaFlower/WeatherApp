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
//        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return presenter.rowsNumberInTable(section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: let cell = tableView.dequeueReusableCell(withIdentifier: "WeekCell", for: indexPath) as! MainWeekCell
                cell.dayLabel.text = presenter.fiveDaysForecast?.dailyForecast[indexPath.row].date
                cell.maxLabel.text = "\(presenter.fiveDaysForecast?.dailyForecast[indexPath.row].temperat.max))"
                cell.minLabel.text = "\(presenter.fiveDaysForecast?.dailyForecast[indexPath.row].temperat.min))"
                return cell
        case 1: let cell = tableView.dequeueReusableCell(withIdentifier: "SunMoonCell", for: indexPath) as! MainSunCell
                cell.sunIconImage.image = UIImage(named: "sun2.png")
                cell.sunriseLabel.text = "Sunrise"
                cell.sunriseTimeLabel.text = "6:00"
                cell.sunsetLabel.text = "Sunset"
                cell.sunsetTimeLabel.text = "16:00"
                cell.moonIconImage.image = UIImage(named: "moon.png")
                return cell
        default: break
        }
        return UITableViewCell()
    
    }
    
    
}

