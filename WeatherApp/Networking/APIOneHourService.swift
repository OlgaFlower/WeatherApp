//
//  APIOneHourForecast.swift
//  WeatherApp
//
//  Created by Admin on 14.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//http://dataservice.accuweather.com/forecasts/v1/hourly/1hour/326175?apikey=1iyjSw7peRCAQDQnRv9zqhWjCbRGydNv&details=true&metric=true

import Foundation

class APIOneHourService {
    
    func fetchOneHour(completion: @escaping ([OneHourForecast]) -> ()) {
        guard let url = URL(string: Helper.oneHourResource) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("Error: \(error!.localizedDescription)")
            }
            guard let data = data else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            do {
                let oneHourforecast = try JSONDecoder().decode([OneHourForecast].self, from: data)
                completion(oneHourforecast)
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
        }.resume()
    }
}
    
