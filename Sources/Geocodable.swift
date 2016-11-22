//
//  Geocodable.swift
//  AddressGeocoder
//
//  Created by Thibault Klein on 11/21/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import CoreLocation
import Foundation
import Result

/// Geocodable protocol. Provides a geocoding feature.
public protocol Geocodable {

    /// Geocodes the given string into a geocoded address.
    ///
    /// - Parameters:
    ///   - string: The string to geocode.
    ///   - country: The country to use as a filter. Default value is "US".
    ///   - completion: The completion block.
    func geocodeLocality(string: String,
                         forCountry country: String,
                         completion: @escaping (Result<GeocodedAddress, GeocodingError>) -> ())

}

public extension Geocodable {

    /// Geocodes the given string into a geocoded address.
    ///
    /// - Parameters:
    ///   - string: The string to geocode.
    ///   - country: The country to use as a filter. Default value is "US".
    ///   - completion: The completion block.
    func geocodeLocality(string: String,
                         forCountry country: String,
                         completion: @escaping (Result<GeocodedAddress, GeocodingError>) -> ()) {
        geocode(string, forCountry: country) { result in
            guard let placemark = result.value else {
                completion(.failure(.error("Couldn't find a matching address")))
                return
            }

            let locality = placemark.formattedLocality()
            let state = placemark.administrativeArea

            if let locality = locality, let state = state {
                let address = GeocodedAddress(locality: locality, state: state)
                completion(.success(address))
            } else {
                completion(.failure(.error("Couldn't find a matching address")))
            }
        }
    }

    private func geocode(_ string: String, forCountry country: String, completion: @escaping (Result<CLPlacemark, GeocodingError>) -> ()) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(string) { (placemarks, error) in
            if let error = error {
                completion(.failure(.error(error.localizedDescription)))
            } else if let placemarks = placemarks {
                let usaPlacemarks = placemarks.filter { $0.isoCountryCode == country }
                if let placemark = usaPlacemarks.first {
                    completion(.success(placemark))
                } else {
                    completion(.failure(.error("Couldn't find a matching address")))
                }
            }
        }
    }
    
}
