//
//  APITwelveHoursForecast.swift
//  WeatherApp
//
//  Created by Admin on 14.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

class APITwelveHoursService {
    
    func fetchTwelveHours(_ key: String, completion: @escaping ([TwelveHoursForecast]) -> ()) {
        guard let url = URL(string: Helper.twelveHoursResource(key)) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("TwelveHours API: \(error!.localizedDescription)")
            }
            guard let data = data else {
                print("TwelveHours API: " + Errors.downloadError.rawValue)
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let twelveHoursForecast = try decoder.decode([TwelveHoursForecast].self, from: data)
                completion(twelveHoursForecast)
                } catch {
                    print("TwelveHours API: " + Errors.decodeError.rawValue)
                }
        }.resume()
    }
    
}
