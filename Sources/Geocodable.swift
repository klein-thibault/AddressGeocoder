//
//  Geocodable.swift
//  AddressGeocoder
//
//  Created by Thibault Klein on 11/21/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import CoreLocation
import Foundation

/// Geocodable protocol. Provides a geocoding feature.
public protocol Geocodable {

    /// Geocodes the given string into a geocoded address.
    ///
    /// - Parameters:
    ///   - addressString: The string to geocode.
    ///   - country: The country to use as a filter. Default value is "US".
    ///   - completion: The completion block.
    func geocodeAddress(using addressString: String,
                        forCountry country: String,
                        completion: @escaping (GeocodedAddress?, GeocodingError?) -> ())

}

public extension Geocodable {

    func geocodeAddress(using addressString: String,
                        forCountry country: String,
                        completion: @escaping (GeocodedAddress?, GeocodingError?) -> ()) {
        geocode(addressString, forCountry: country) { (placemark, error) in
            if let placemark = placemark {
                self.geocodedAddressFromPlacemark(placemark, completion: completion)
            } else {
                completion(nil, error)
            }
        }
    }
    
    // MARK: - Private functions

    private func geocode(_ addressString: String,
                         forCountry country: String,
                         completion: @escaping (CLPlacemark?, GeocodingError?) -> ()) {
        let geocoder = CLGeocoder()

        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error != nil {
                completion(nil, GeocodingError.error("Couldn't find a matching locality."))
            } else if let placemarks = placemarks {
                let usaPlacemarks = placemarks.filter { $0.isoCountryCode == country }

                if let placemark = usaPlacemarks.first {
                    completion(placemark, nil)
                } else {
                    completion(nil, GeocodingError.error("Couldn't find a matching address in specified country."))
                }
            }
        }
    }
    
    private func geocodedAddressFromPlacemark(_ placemark: CLPlacemark,
                                              completion: @escaping (GeocodedAddress?, GeocodingError?) -> ()) {
        guard let locality = placemark.formattedLocality(),
            let state = placemark.administrativeArea,
            let zipCode = placemark.postalCode,
            let coordinate = placemark.location?.coordinate else {
                completion(nil, GeocodingError.error("Couldn't find a matching locality."))
                return
        }

        let address = GeocodedAddress(coordinate: coordinate, locality: locality, state: state, zipCode: zipCode)

        return completion(address, nil)
    }
    
}
