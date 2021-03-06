//
//  APIOneHourForecast.swift
//  WeatherApp
//
//  Created by Admin on 14.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

class APIOneHourService {
    
    func fetchOneHour(_ key: String, completion: @escaping ([OneHourForecast]) -> ()) {
        guard let url = URL(string: Helper.oneHourResource(key)) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("OneHour API: \(error!.localizedDescription)")
            }
            guard let data = data else {
                print("OneHour API: " + Errors.downloadError.rawValue)
                return
            }
            do {
                let oneHourforecast = try JSONDecoder().decode([OneHourForecast].self, from: data)
                completion(oneHourforecast)
                } catch {
                    print("OneHour API: " + Errors.decodeError.rawValue)
                }
        }.resume()
    }
}
    
