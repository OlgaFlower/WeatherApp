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

//    func loadSearchResult(_ query: String, completion: @escaping ([SearchResult]) -> Void) {
//        searchService.fetchSearchResult(query) { [weak self] result in
//            self?.searchResult = result
//            completion(result)
//        }
//    }
    
}
