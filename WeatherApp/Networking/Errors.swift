//
//  Error.swift
//  WeatherApp
//
//  Created by Admin on 17.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import Foundation

enum ParsingError: Error {
    case download
    case decode
}


extension ParsingError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .download:
            return NSLocalizedString(
                "Downloading error", comment: ""
            )
        case .decode:
            return NSLocalizedString(
                "Decoding error", comment: ""
            )
        }
    }
}
