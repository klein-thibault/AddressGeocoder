//
//  CLPlacemark+FormattedLocality.swift
//  Atlas
//
//  Created by Thibault Klein on 11/21/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import CoreLocation
import Foundation

public extension CLPlacemark {

    /// Returns the formatted locality of the placemark using the formatted address lines property.
    ///
    /// - Returns: The formatted locality.
    public func formattedLocality() -> String? {
        guard let formattedAddressLines = addressDictionary?["FormattedAddressLines"] as? [String] else {
            return nil
        }

        let address = formattedAddressLines.joined(separator: ",")
        let locality = address.components(separatedBy: ",").first
        return locality
    }

}
