//
//  GeocodableTests.swift
//  AddressGeocoderExample
//
//  Created by Thibault Klein on 11/22/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import XCTest
@testable import AddressGeocoder

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
        mockGeocodable.geocodeAddress(using: zipCode, forCountry: "US") { (address, error) in
            geocodingExpectation.fulfill()

            XCTAssertNotNil(address)
            if let address = address {
                XCTAssertEqual(address.locality, expectedCity)
                XCTAssertEqual(address.state, expectedState)
                XCTAssertEqual(address.zipCode, zipCode)
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
        mockGeocodable.geocodeAddress(using: zipCode, forCountry: "US") { (address, error) in
            geocodingExpectation.fulfill()

            XCTAssertNotNil(address)
            if let address = address {
                XCTAssertEqual(address.locality, expectedCity)
                XCTAssertEqual(address.state, expectedState)
                XCTAssertEqual(address.zipCode, zipCode)
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
        mockGeocodable.geocodeAddress(using: zipCode, forCountry: "US") { (address, error) in
            geocodingExpectation.fulfill()

            XCTAssertNotNil(address)
            if let address = address {
                XCTAssertEqual(address.locality, expectedCity)
                XCTAssertEqual(address.state, expectedState)
                XCTAssertEqual(address.zipCode, zipCode)
            }
        }

        waitForExpectations(timeout: timeout, handler: nil)
    }

    func test_geocodable_InvalidCode() {
        // Given
        let invalidCode = ""
        let geocodingExpectation = expectation(description: "Geocoding finished")
        // When
        let expectedError = GeocodingError.error("Couldn't find a matching locality.")
        // Then
        let mockGeocodable = MockGeocodable()
        mockGeocodable.geocodeAddress(using: invalidCode, forCountry: "US") { (address, error) in
            geocodingExpectation.fulfill()
            XCTAssertEqual(error?.description, expectedError.description)
        }

        waitForExpectations(timeout: timeout, handler: nil)
    }
    
}
