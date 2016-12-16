//
//  GeocodeAddress.swift
//  AddressGeocoder
//
//  Created by Thibault Klein on 11/21/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import CoreLocation
import Foundation

/// The geocoded address model. This model is the result of the Geocodable protocol.
public struct GeocodedAddress {
    
    /// Address coordinate.
    public let coordinate: CLLocationCoordinate2D

    /// Address locality.
    public let locality: String

    /// Address state.
    public let state: String
    
}
