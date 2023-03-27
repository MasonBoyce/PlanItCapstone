//
//  LocationManager.swift
//  PlanIt
//
//  Created by Mason Boyce on 3/24/23.
//

import Foundation
import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var didChangeAuthorization: ((CLAuthorizationStatus) -> Void)?
    var authorizationStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func requestWhenInUseAuthorization() {
           locationManager.requestAlwaysAuthorization()
       }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
//        print("Current location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        didChangeAuthorization?(authorizationStatus)
        
        switch authorizationStatus {
        case .authorizedWhenInUse:
            startUpdatingLocation()
        case .denied, .restricted:
            print("Location access denied or restricted")
            stopUpdatingLocation()
        case .notDetermined:
            print("Location access not yet determined")
        case .authorizedAlways:
            print("Location access authorized always")
        @unknown default:
            print("Unknown authorization status")
        }
    }
}
