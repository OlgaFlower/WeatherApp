//
//  Helper.swift
//  WeatherApp
//
//  Created by Admin on 14.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

class Helper {
    let mainPresenter = MainPresenter()
    
    static let apiKey = "1iyjSw7peRCAQDQnRv9zqhWjCbRGydNv"
    static let apiKey2 = "DD88l3LYERLRIDfPjaSGXsMlcG0yWtoK"
    static let urlString = "https://dataservice.accuweather.com" //rename to baseURL
    
    
    static let degree = "°"
    
    static let dateFormatTime = "hh:mm:ss"
    static let dateFormatDate = "yyyy-MM-dd"
 
    
}








//private var degrees = "0"
//private var sign = "º"
//
//public var degreeString: String {
//    get {
//        return degrees + sign
//    }
//    set {
//        degrees = newValue
//    }
//}
//
//degreeString = "12.3"
//print(degreeString) //12.3º
