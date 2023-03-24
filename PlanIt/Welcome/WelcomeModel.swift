//
//  WelcomeModel.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/2/22.
//

import Foundation
import UIKit
import CoreLocation

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
                print("hello")
                // Handle location access granted when in use
                break
            case .denied, .restricted:
                print("denied")
                // Handle location access denied or restricted
                break
            case .notDetermined:
                print("here")
//                self.locationManager.requestWhenInUseAuthorization()
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
    
    
    
    
}
