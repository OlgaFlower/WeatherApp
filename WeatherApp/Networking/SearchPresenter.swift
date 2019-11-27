//
//  SearchPresenter.swift
//  WeatherApp
//
//  Created by Admin on 19.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit

class SearchPresenter {

    weak var searchView: SearchViewController?

    let searchService = APISearchCityService() //Data
    var searchResult = [SearchResult]() //struct
    
//    func addFavourite(_ indexPath: IndexPath) -> Favourite {
//        Helper.cityKey = (searchView?.resultOfRequest[indexPath.row].key)!
//        let add = Favourite(city: (searchView?.resultOfRequest[indexPath.row].cityName)!, key: (searchView?.resultOfRequest[indexPath.row].key)!, country: (searchView?.resultOfRequest[indexPath.row].country.name)!)
//        return add
//    }
}

