//
//  Errors.swift
//  WeatherApp
//
//  Created by Admin on 08.12.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

enum Errors: String {
    //API Errors
    case downloadError = "Error data downloading"
    case decodeError = "Error JSON decoding or API key is expired"
    
    //CoreData Errors
    case fetchError = "Error fetching data from context"
    case unresolvedError = "Unresolved error with Core Data NSPersistentContainer"
    case savingError = "Error saving context to Core Data"
}

