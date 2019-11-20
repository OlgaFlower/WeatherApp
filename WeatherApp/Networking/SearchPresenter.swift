//
//  SearchPresenter.swift
//  WeatherApp
//
//  Created by Admin on 19.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

class SearchPresenter {

    weak var searchView: SearchViewController?

    let searchService = APISearchCityService() //Data
    var searchResult = [SearchResult]() //struct
    
}
