//
//  GeneralTableSections.swift
//  WeatherApp
//
//  Created by Admin on 07.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

class MainRowsAndSections {
    
    //dictionary with amount of sections and rows/section
    let sectionsAndRows = [
        "WeeklyForecast": 7,
        "SunAndMoon": 1
        ]
    
    //structure-helper
    struct GeneralPage {
        var sections: String!
        var rows: Int!
    }
    
    //converting dictionary into array
    func arrOfSectionsAndRows() -> [GeneralPage] {
        return [GeneralPage(sections: "WeeklyForecast", rows: sectionsAndRows["WeeklyForecast"]),
                GeneralPage(sections: "SunAndMoon", rows: sectionsAndRows["SunAndMoon"])]
    }

}
