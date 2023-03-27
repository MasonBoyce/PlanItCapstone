//
//  WelcomeModel.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/2/22.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class Geocoder {
    func geocodeAddress(_ address: String, completion: @escaping (CLLocationCoordinate2D?, Error?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let placemark = placemarks?.first {
                let coordinates = placemark.location?.coordinate
                completion(coordinates, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}

class WelcomeModel: WelcomeModelProtocol {
    var description: String?
    
    var viewController: WelcomeViewControllerProtocol?
    var coordinator: WelcomeCoordinatorProtocol?
    let locationManager = LocationManager()
    
    init() {
        locationManager.didChangeAuthorization = { status in
            print(status)
            switch status {

            case .authorizedWhenInUse:
                print("🤩 Welcome to Planit!")
                // Handle location access granted when in use
                break
            case .denied, .restricted:
                print("denied")
                let geocoder = Geocoder()

                // Call the geocodeAddress function with the address "Paris, France"
                geocoder.geocodeAddress("Paris, France") { (coordinates, error) in
                    if let error = error {
                        print("Error geocoding address: \(error.localizedDescription)")
                    } else if let coordinates = coordinates {
                        self.locationManager.currentLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
                    }
                }
//                locationManager.currentLocation = geocodeAddress("Paris,France", completion:  )
                break
            case .notDetermined:
                print("here")
//
                // Handle location access not yet determined

            case .authorizedAlways:
                print("always")
                // Handle location access authorized always
                break
            @unknown default:
                print("Unknown authorization status")
            }
        }
    }
    
    
    func doSomething() {
        coordinator?.goToSelection(locationManager:locationManager)
    }
    
//    func geocodeAddress(_ address: String, completion: @escaping (CLLocationCoordinate2D?, Error?) -> Void) {
//           let geocoder = CLGeocoder()
//           geocoder.geocodeAddressString(address) { (placemarks, error) in
//               if let placemark = placemarks?.first {
//                   let coordinates = placemark.location?.coordinate
//                   completion(coordinates, nil)
//               } else {
//                   completion(nil, error)
//               }
//           }
//       }
    
    
    
    
}
