//
//  GeocodingError.swift
//  Atlas
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
}
