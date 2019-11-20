//
//  APIFiveDaysForecast.swift
//  WeatherApp
//
//  Created by Admin on 15.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//http://dataservice.accuweather.com/forecasts/v1/daily/5day/326175?apikey=DD88l3LYERLRIDfPjaSGXsMlcG0yWtoK&details=true&metric=true

import Foundation

class APIFiveDaysService {
    
    func fetchFiveDays(completion: @escaping (FiveDaysForecast) -> ()) {
        guard let url = URL(string: Helper.fiveDaysResource) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("FiveDaysError: \(error!.localizedDescription)")
            }
            guard let data = data else {
                print("FiveDaysError: downloading error, \(error!.localizedDescription)")
                return
            }
            do {
                let fiveDaysForecast = try JSONDecoder().decode(FiveDaysForecast.self, from: data)
                completion(fiveDaysForecast)
                } catch {
                    print("FiveDaysError:decoding error, \(error.localizedDescription)")
                }
        }.resume()
    }
    
}
