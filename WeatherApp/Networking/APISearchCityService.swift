//
//  APISearchCityService.swift
//  WeatherApp
//
//  Created by Admin on 19.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//http://dataservice.accuweather.com/locations/v1/cities/autocomplete?apikey=DD88l3LYERLRIDfPjaSGXsMlcG0yWtoK&q=vinn

import Foundation

class APISearchCityService {

    func fetchSearchResult(_ query: String, completion: @escaping ([SearchResult]) -> ()) {
        guard let url = URL(string: "\(Helper.searchResource)\(query)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("SearchResultError: \(error!.localizedDescription)")
            }
            guard let data = data else {
                print("SearchResultError:downloading error, \(error!.localizedDescription)")
                return
            }

            do {
                let searchResult = try JSONDecoder().decode([SearchResult].self, from: data)
                completion(searchResult)
                } catch {
                    print("SearchResultError:decoding error, \(error.localizedDescription)")
                }
        }.resume()
    }

}
