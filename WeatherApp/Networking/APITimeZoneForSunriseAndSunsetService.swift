//
//  APITimeZoneForSunriseAndSunset.swift
//  WeatherApp
//
//  Created by Admin on 03.12.2019.
//  Copyright © 2019 Flower. All rights reserved.
//http://dataservice.accuweather.com/locations/v1/1593794?apikey=mEECFoncHJmdzuK925tGFk9tYJA5wgG7&details=true

import Foundation

class APITimeZoneForSunriseAndSunsetService {
    
    func fetchTimeZoneCode(_ key: String, completion: @escaping (TimeZoneForSunriseAndSunset) -> ()) {
        guard let url = URL(string: Helper.timeZoneCodeResource(key)) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("TimeZoneError: \(error!.localizedDescription)")
            }
            guard let data = data else {
                print("TimeZoneError: downloading error, \(error!.localizedDescription)")
                return
            }
            do {
                let zoneCode = try JSONDecoder().decode(TimeZoneForSunriseAndSunset.self, from: data)
                completion(zoneCode)
                } catch {
                    print("TimeZoneError: decoding error, \(error.localizedDescription)")
                }
        }.resume()
    }
}
