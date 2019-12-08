//
//  Errors.swift
//  WeatherApp
//
//  Created by Admin on 08.12.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

enum Errors: Error {
    //API Errors
    case downloadError
    case decodeError
    
    //CoreData Errors
    case fetchError
    case unresolvedError
    case savingError
}


extension Errors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .downloadError:
            return NSLocalizedString(
                "Error data downloading", comment: ""
            )
        case .decodeError:
            return NSLocalizedString(
                "Error JSON decoding", comment: ""
            )
        case .fetchError:
            return NSLocalizedString(
            "Error fetching data from context", comment: ""
            )
        case .unresolvedError:
            return NSLocalizedString("Unresolved error with Core Data NSPersistentContainer", comment: "")
        case.savingError:
            return NSLocalizedString(
                "Error saving context to Core Data", comment: ""
            )
        }
    }
}
