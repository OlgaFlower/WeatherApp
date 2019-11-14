//
//  ExtensionOpenSafari.swift
//  WeatherApp
//
//  Created by Admin on 14.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//
import UIKit
import SafariServices


extension MainViewController {
    func openSafari(for url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
}
