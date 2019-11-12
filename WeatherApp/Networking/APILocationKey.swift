//
//  APILocationKey.swift
//  WeatherApp
//
//  Created by Admin on 11.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

//https://dataservice.accuweather.com/locations/v1/cities/search?q=Lviv&apikey=DD88l3LYERLRIDfPjaSGXsMlcG0yWtoK

import Foundation

class APILocationKey {
    var apiKey = DevAPIKey()

    func getLocationKey(completion: @escaping (LocationKey) -> ()) {
            let urlString = "https://dataservice.accuweather.com/locations/v1/cities/search?q=Lviv&apikey=im5mEf1fvS5AJnGsG2gnAaBACBa93XAl"
            guard let url = URL(string: urlString) else { return }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!.localizedDescription)
                    print("Location Key URLSession error oquared!!!")
                }
                guard let data = data else {
                    print("Location Key URL isn't downloaded!")
                    return
                }

                do {
                    let locationKey = try JSONDecoder().decode(LocationKey.self, from: data)
                    let locationKey = try JSONSerialization.jsonObject(with: data) as! [[String : String]]
                    completion(locationKey)
                    } catch {
                        print("Location Key decoding error!")
                    }
                }.resume()
        }
}
