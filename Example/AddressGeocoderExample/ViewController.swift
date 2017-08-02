//
//  ViewController.swift
//  AddressGeocoderExample
//
//  Created by Thibault Klein on 11/21/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import AddressGeocoder
import UIKit

class ViewController: UIViewController, Geocodable {

    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var addressLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func geocodeButtonTapped(_ sender: Any) {
        textField.resignFirstResponder()

        guard let zipCode = textField.text else {
            return
        }

        geocodeAddress(using: zipCode, forCountry: "US") { [weak self] (address, error) in
            if let address = address {
                self?.addressLabel.text = address.locality + ", " + address.state
            }
        }
    }
    
}
