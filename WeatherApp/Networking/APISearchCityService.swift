//
//  APISearchCityService.swift
//  WeatherApp
//
//  Created by Admin on 19.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

class APISearchCityService {

    func fetchSearchResult(_ query: String, completion: @escaping ([SearchResult]) -> ()) {
        guard let url = URL(string: "\(Helper.searchResource)\(query)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("SearchResult API Error: \(error!.localizedDescription)")
            }
            guard let data = data else {
                print("SearchResult API Error: \(Errors.downloadError)")
                return
            }

            do {
                let searchResult = try JSONDecoder().decode([SearchResult].self, from: data)
                completion(searchResult)
                } catch {
                    print("SearchResult API Error: \(Errors.decodeError)")
                }
        }.resume()
    }

}
