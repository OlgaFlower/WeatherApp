//
//  APIFiveDaysForecast.swift
//  WeatherApp
//
//  Created by Admin on 15.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//http://dataservice.accuweather.com/forecasts/v1/daily/5day/326175?apikey=DD88l3LYERLRIDfPjaSGXsMlcG0yWtoK&details=true&metric=true

import Foundation

class APIFiveDaysForecast {
    
    var cityKey = "326175"
    
    func FiveDaysData(completion: @escaping (FiveDaysForecast) -> ()) {
        let urlString = "\(Helper.urlString)/forecasts/v1/daily/5day/\(cityKey)?apikey=\(Helper.apiKey)&details=true&metric=true"
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
                let fiveDaysForecast = try JSONDecoder().decode(FiveDaysForecast.self, from: data)
                completion(fiveDaysForecast)
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
        }.resume()
    }
    
}
