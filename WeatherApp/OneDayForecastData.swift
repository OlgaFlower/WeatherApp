//
//  OneDayForecast.swift
//  WeatherApp
//
//  Created by Admin on 06.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

class OneDayForecastData {

        var forecast = OneDay()
        
        func getLaunchesData(completion: @escaping (OneDay)->()) {
            let urlString = "https://dataservice.accuweather.com/forecasts/v1/daily/1day/326175?apikey=im5mEf1fvS5AJnGsG2gnAaBACBa93XAl"
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!.localizedDescription)
                    print("Launches URLSession error oquared!!!")
                }
                guard let data = data else {
                    print("Launches URL is downloaded!!!")
                    return
                }
                
                do {
                    let newForecast = try JSONDecoder().decode(OneDay.self, from: data)
                    print(newForecast)
                    completion(newForecast)
                    } catch {
                        print("Missions decoding error!!!")
                    }
              }.resume()
        }
    
}
