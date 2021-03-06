//
//  OneDayForecast.swift
//  WeatherApp
//
//  Created by Admin on 06.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//


//apiKey Алексея - DD88l3LYERLRIDfPjaSGXsMlcG0yWtoK
//my apikey - im5mEf1fvS5AJnGsG2gnAaBACBa93XAl
//location key of Vinnitsa - 326175



import Foundation

class OneDayForecastData {

    func getForecastData(completion: @escaping (OneDay)->()) {
        let urlString = "https://dataservice.accuweather.com/forecasts/v1/daily/1day/326175?apikey=im5mEf1fvS5AJnGsG2gnAaBACBa93XAl"
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
                let newForecast = try JSONDecoder().decode(OneDay.self, from: data)
                completion(newForecast)
                } catch {
                    print("Ona Day Forecast decoding error!")
                }
            }.resume()
    }

}
