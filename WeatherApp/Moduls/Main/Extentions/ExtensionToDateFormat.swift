//
//  ExtensionDateFormat.swift
//  WeatherApp
//
//  Created by Admin on 14.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

extension Date {
    func displayTime(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = date
        return dateFormatter.string(from: self)
    }
}
