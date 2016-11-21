//
//  ViewController.swift
//  Atlas
//
//  Created by Thibault Klein on 11/21/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import Atlas
import Result
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

        geocodeLocality(string: zipCode,
                        forCountry: "US",
                        completion: {(result: Result<GeocodedAddress, GeocodingError>) -> () in
                            if let address = result.value {
                                self.addressLabel.text = address.locality + ", " + address.state
                            }
        })
    }

}
