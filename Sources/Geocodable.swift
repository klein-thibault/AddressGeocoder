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
    func geocodeLocality(_ string: String,
                         forCountry country: String,
                         completion: @escaping (Result<GeocodedAddress, GeocodingError>) -> ())
    
    /// Geocodes the given string into a geocoded location.
    ///
    /// - Parameters:
    ///   - string: The string to geocode.
    ///   - country: The country to use as a filter. Default value is "US".
    ///   - completion: The completion block.
    func geocodeLocality(_ string: String,
                         forCountry country: String,
                         completion: @escaping (Result<GeocodedLocation, GeocodingError>) -> ())

}

public extension Geocodable {

    func geocodeLocality(_ string: String,
                         forCountry country: String,
                         completion: @escaping (Result<GeocodedAddress, GeocodingError>) -> ()) {
        geocode(string, forCountry: country) { result in
            completion(result.flatMap(self.geocodedAddressFromPlacemark))
        }
    }
    
    func geocodeLocality(_ string: String,
                         forCountry country: String,
                         completion: @escaping (Result<GeocodedLocation, GeocodingError>) -> ()) {
        geocode(string, forCountry: country) { result in
            completion(result.flatMap(self.geocodedLocationFromPlacemark))
        }
    }
    
    // MARK: - Private functions

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
                    completion(.failure(.error("Couldn't find a matching address in specified country.")))
                }
            }
        }
    }
    
    private func geocodedAddressFromPlacemark(_ placemark: CLPlacemark) -> Result<GeocodedAddress, GeocodingError> {    
        return Result {
            guard let locality = placemark.formattedLocality(), let state = placemark.administrativeArea else {
                throw GeocodingError.error("Couldn't find a matching locality.")
            }
            
            return GeocodedAddress(locality: locality, state: state)
        }
    }
    
    private func geocodedLocationFromPlacemark(_ placemark: CLPlacemark) -> Result<GeocodedLocation, GeocodingError> {
        return Result {
            guard let coordinate = placemark.location?.coordinate else {
                throw GeocodingError.error("Couldn't find matching coordinates.")
            }
            
            let address = try geocodedAddressFromPlacemark(placemark).dematerialize()
            return GeocodedLocation(latitude: coordinate.latitude,
                                    longitude: coordinate.longitude,
                                    address: address)
        }
    }
    
}
