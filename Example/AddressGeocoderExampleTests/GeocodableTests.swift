//
//  GeocodableTests.swift
//  AddressGeocoderExample
//
//  Created by Thibault Klein on 11/22/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import XCTest
@testable import AddressGeocoder
@testable import Result

class GeocodableTests: XCTestCase {

    struct MockGeocodable: Geocodable { }

    let timeout = TimeInterval(60)

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_geocodable_NYC_ZipCode() {
        // Given
        let zipCode = "11201"
        let geocodingExpectation = expectation(description: "Geocoding finished")
        // When
        let expectedCity = "Brooklyn"
        let expectedState = "NY"
        // Then
        let mockGeocodable = MockGeocodable()
        mockGeocodable.geocodeLocality(string: zipCode, forCountry: "US") { (result: Result<GeocodedAddress, GeocodingError>) in
            geocodingExpectation.fulfill()
            if let address = result.value {
                XCTAssertEqual(address.locality, expectedCity)
                XCTAssertEqual(address.state, expectedState)
            }
        }

        waitForExpectations(timeout: timeout, handler: nil)
    }

    func test_geocodable_CA_ZipCode() {
        // Given
        let zipCode = "95014"
        let geocodingExpectation = expectation(description: "Geocoding finished")
        // When
        let expectedCity = "Cupertino"
        let expectedState = "CA"
        // Then
        let mockGeocodable = MockGeocodable()
        mockGeocodable.geocodeLocality(string: zipCode, forCountry: "US") { (result: Result<GeocodedAddress, GeocodingError>) in
            geocodingExpectation.fulfill()
            if let address = result.value {
                XCTAssertEqual(address.locality, expectedCity)
                XCTAssertEqual(address.state, expectedState)
            }
        }

        waitForExpectations(timeout: timeout, handler: nil)
    }

    func test_geocodable_PA_ZipCode() {
        // Given
        let zipCode = "17325"
        let geocodingExpectation = expectation(description: "Geocoding finished")
        // When
        let expectedCity = "Gettysburg"
        let expectedState = "PA"
        // Then
        let mockGeocodable = MockGeocodable()
        mockGeocodable.geocodeLocality(string: zipCode, forCountry: "US") { (result: Result<GeocodedAddress, GeocodingError>) in
            geocodingExpectation.fulfill()
            if let address = result.value {
                XCTAssertEqual(address.locality, expectedCity)
                XCTAssertEqual(address.state, expectedState)
            }
        }

        waitForExpectations(timeout: timeout, handler: nil)
    }

    func test_geocodable_InvalidCode() {
        // Given
        let invalidCode = "11111"
        let geocodingExpectation = expectation(description: "Geocoding finished")
        // When
        let expectedError = GeocodingError.error("Couldn't find a matching address")
        // Then
        let mockGeocodable = MockGeocodable()
        mockGeocodable.geocodeLocality(string: invalidCode, forCountry: "US") { (result: Result<GeocodedAddress, GeocodingError>) in
            geocodingExpectation.fulfill()
            XCTAssertEqual(result.error?.description, expectedError.description)
        }

        waitForExpectations(timeout: timeout, handler: nil)
    }
    
}
