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
        let urlString = "\(Helper.urlString)/locations/v1/cities/autocomplete?apikey=\(Helper.apiKey)&q=\(query)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("Error: \(error!.localizedDescription)")
            }
            guard let data = data else {
                print("Error: \(error!.localizedDescription)")
                return
            }

            do {
                let searchResult = try JSONDecoder().decode([SearchResult].self, from: data)
                completion(searchResult)
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
        }.resume()
    }

}
