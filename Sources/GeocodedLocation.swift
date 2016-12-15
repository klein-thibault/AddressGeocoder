//
//  GeocodedLocation.swift
//  AddressGeocoder
//
//  Created by Htin Linn on 12/15/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import Foundation

/// Type representing a location coordinate in degrees.
public typealias LocationDegrees = Double

/// The geocoded location model.
public struct GeocodedLocation {
    
    /// Latitude coordinate of the location.
    public let latitude: LocationDegrees
    
    /// Longitude coordinate of the location.
    public let longitude: LocationDegrees
    
    /// Address of the location.
    public let address: GeocodedAddress
    
}
