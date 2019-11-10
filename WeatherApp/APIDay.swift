//
//  APIDay.swift
//  WeatherApp
//
//  Created by Admin on 10.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

class APIDay {
    var APIKey = "im5mEf1fvS5AJnGsG2gnAaBACBa93XAl"
    var locationID = "326175"

    func getForecastData(completion: @escaping (DayForecast)->()) {
        let urlString = "https://dataservice.accuweather.com/forecasts/v1/daily/1day/\(locationID)?apikey=\(APIKey)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!.localizedDescription)
                print("One Day Forecast URLSession error oquared!!!")
            }
            guard let data = data else {
                print("Ona Day Forecast URL isn't downloaded!")
                return
            }

            do {
                let newForecast = try JSONDecoder().decode(DayForecast.self, from: data)
                completion(newForecast)
                } catch {
                    print("One Day Forecast decoding error!")
                }
            }.resume()
    }

}
