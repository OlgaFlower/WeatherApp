//
//  MainExtensionWithCollection.swift
//  WeatherApp
//
//  Created by Admin on 10.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit

//MARK: - Main collection view
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.fetchTwelveHourForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MainHourForecastCollectionViewCell
        if indexPath.row == 0 {
            cell.timeLabel.text = "Now"
        } else {
            cell.timeLabel.text = presenter.fetchTwelveHourForecast[indexPath.row].time
        }
        cell.iconImage.image = UIImage(named: "muchSnow.png")
        cell.temperatLabel.text = "\(presenter.fetchTwelveHourForecast[indexPath.row].temperat.temperatValue)" + Helper.degree
        return cell
    }
}
