//
//  APILocationKey.swift
//  WeatherApp
//
//  Created by Admin on 11.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

//https://dataservice.accuweather.com/locations/v1/cities/search?q=Lviv&apikey=DD88l3LYERLRIDfPjaSGXsMlcG0yWtoK

import Foundation

class APILocationKeyService {
    var request = "Vinnytsia"
    func fetchLocationKey(completion: @escaping ([LocationKey]) -> ()) {
        let urlString = "\(Helper.urlString)/locations/v1/cities/search?q=\(request)&apikey=\(Helper.apiKey)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!.localizedDescription)
                }
                guard let data = try? data else {
                    print(ParsingError.download)
                    return
                }
                do {
                    let locationKey = try JSONDecoder().decode([LocationKey].self, from: data)
                    completion(locationKey)
                    } catch {
                        print(ParsingError.decode)
                    }
            }.resume()
        }
}
