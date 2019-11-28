//
//  APITwelveHoursForecast.swift
//  WeatherApp
//
//  Created by Admin on 14.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//http://dataservice.accuweather.com/forecasts/v1/hourly/12hour/326175?apikey=DD88l3LYERLRIDfPjaSGXsMlcG0yWtoK&metric=true

import Foundation

class APITwelveHoursService {
    
    func fetchTwelveHours(_ key: String, completion: @escaping ([TwelveHoursForecast]) -> ()) {
        guard let url = URL(string: Helper.twelveHoursResource(key)) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("TwelveHoursError: \(error!.localizedDescription)")
            }
            guard let data = data else {
                print("TwelveHoursError: downloading error, \(error!.localizedDescription)")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let twelveHoursForecast = try decoder.decode([TwelveHoursForecast].self, from: data)
                completion(twelveHoursForecast)
                } catch {
                    print("TwelveHoursError:decoding error, \(error.localizedDescription)")
                }
        }.resume()
    }
    
}
