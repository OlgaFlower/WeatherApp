//
//  GeneralViewModelItemProtocol.swift
//  WeatherApp
//
//  Created by Admin on 07.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

protocol GeneralViewModelItemProt {
    var type: GeneralViewModelItemType { get }
    var rowCount: Int { get }
}


//default valuew
extension GeneralViewModelItemProt {
    var rowCount: Int {
        return 1
    }
}
