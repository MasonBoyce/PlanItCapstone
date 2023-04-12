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
        coordinator?.goToSelection()
    }
}
