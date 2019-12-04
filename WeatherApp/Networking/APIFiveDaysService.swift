//
//  APIFiveDaysForecast.swift
//  WeatherApp
//
//  Created by Admin on 15.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

class APIFiveDaysService {
    
    func fetchFiveDays(_ key: String, completion: @escaping (FiveDaysForecast) -> ()) {
        guard let url = URL(string: Helper.fiveDaysResource(key)) else { return }
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
