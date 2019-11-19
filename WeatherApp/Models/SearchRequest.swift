//
//  SearchRequest.swift
//  WeatherApp
//
//  Created by Admin on 19.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//http://dataservice.accuweather.com/locations/v1/cities/autocomplete?apikey=DD88l3LYERLRIDfPjaSGXsMlcG0yWtoK&q=vinn

import Foundation

class CitySearchService {
    
let APIKey = "1iyjSw7peRCAQDQnRv9zqhWjCbRGydNv"
    
    
    
}
//TOFIX: - move to services
struct SearchRequest {
    let resourseURL: URL
    let APIKey = "1iyjSw7peRCAQDQnRv9zqhWjCbRGydNv"
    
    init(cityName: String) {
        var resourseString = "http://dataservice.accuweather.com/locations/v1/cities/autocomplete?apikey=\(APIKey)&q=\(cityName)"
        
        guard let resourseURL = URL(string: resourseString) else { fatalError()}
        self.resourseURL = resourseURL
    }
    
    
    func fetchSearchResult(completion: @escaping ([SearchResult]) -> ()) {
//        let urlString = "\(Helper.urlString)/locations/v1/cities/autocomplete?apikey=\(Helper.apiKey)&q=\(query)"
//        guard let url = URL(string: resourseURL) else { return }
        
        URLSession.shared.dataTask(with: resourseURL) { data, response, error in
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
