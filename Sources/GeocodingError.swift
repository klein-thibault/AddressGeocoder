//
//  GeocodingError.swift
//  AddressGeocoder
//
//  Created by Thibault Klein on 11/21/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import Foundation

/// Geocoding error.
///
/// - error: The geocoding error, containing the error message.
public enum GeocodingError: Error {

    case error(String)

    /// Geocoding error description.
    var description: String {
        switch self {
        case .error(let string):
            return string
        }
    }

}
