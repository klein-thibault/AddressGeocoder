# AddressGeocoder

[![Travis build status](https://img.shields.io/travis/prolificinteractive/AddressGeocoder.svg?style=flat-square)](https://travis-ci.org/prolificinteractive/AddressGeocoder)
[![Cocoapods Compatible](https://img.shields.io/cocoapods/v/AddressGeocoder.svg?style=flat-square)](https://img.shields.io/cocoapods/v/AddressGeocoder.svg)
[![Platform](https://img.shields.io/cocoapods/p/AddressGeocoder.svg?style=flat-square)](http://cocoadocs.org/docsets/AddressGeocoder)
[![Docs](https://img.shields.io/cocoapods/metrics/doc-percent/AddressGeocoder.svg?style=flat-square)](http://cocoadocs.org/docsets/AddressGeocoder)

## Description

AddressGeocoder is a helper tool to get the state and locality for a given zip code.

For example, providing `95014` will return `Cupertino` as the city and `CA` as the state.

AddressGeocoder relies on the CoreLocation APIs to get the address information, and parses the generated formatted address for better and more accurate results.

## Requirements

* iOS 9+
* Xcode 8
* Swift 3+

## Installation

To use in your projects, simply add the following line to your Podfile:

```bash
pod 'AddressGeocoder'
```

You can then use AddressGeocoder by importing it into your files:

```swift
import AddressGeocoder
```

## Usage

```swift
struct Geocoder: Geocodable { }
let geocoder = Geocoder()

geocoder.geocodeAddress(
  using: "11201",
  forCountry: "US",
  completion: { (result: Result<GeocodedAddress, GeocodingError>) -> () in
    if let address = result.value {
      self.addressLabel.text = address.locality + ", " + address.state
    }
  }
)
```

## Contributing to AddressGeocoder

To report a bug or enhancement request, feel free to file an issue under the respective heading.

If you wish to contribute to the project, fork this repo and submit a pull request.
