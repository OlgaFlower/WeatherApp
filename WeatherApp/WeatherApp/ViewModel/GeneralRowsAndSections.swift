//
//  GeneralTableSections.swift
//  WeatherApp
//
//  Created by Admin on 07.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

class GeneralRowsAndSections {
    
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
        var pageStruct = [GeneralPage]()
        for (key, value) in sectionsAndRows {
            pageStruct.append(GeneralPage(sections: key, rows: value))
        }
        return pageStruct
    }

}
