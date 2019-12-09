//
//  APITimeZoneForSunriseAndSunset.swift
//  WeatherApp
//
//  Created by Admin on 03.12.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

class APITimeZoneForSunriseAndSunsetService {
    
    func fetchTimeZoneCode(_ key: String, completion: @escaping (TimeZoneForSunriseAndSunset) -> ()) {
        guard let url = URL(string: Helper.timeZoneCodeResource(key)) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("TimeZone API: \(error!.localizedDescription)")
            }
            guard let data = data else {
                print("TimeZone API: " + Errors.downloadError.rawValue)
                return
            }
            do {
                let zoneCode = try JSONDecoder().decode(TimeZoneForSunriseAndSunset.self, from: data)
                completion(zoneCode)
                } catch {
                    print("TimeZone API: " + Errors.decodeError.rawValue)
                }
        }.resume()
    }
}
