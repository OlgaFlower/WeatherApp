//
//  Spinner.swift
//  WeatherApp
//
//  Created by Admin on 09.12.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit

class Spinner {
    static let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    
    static func showActivityIndicatory(uiView: UIView) {
        actInd.center = uiView.center
        actInd.hidesWhenStopped = true
        actInd.style =
            UIActivityIndicatorView.Style.large
        uiView.addSubview(actInd)
        actInd.startAnimating()
    }
    
}
