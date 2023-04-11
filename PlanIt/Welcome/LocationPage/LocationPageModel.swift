//
//  LocationPageModel.swift
//  PlanIt
//
//  Created by Mason Boyce on 4/11/23.
//

import Foundation
import MapKit

class LocationPageModel{
    var coordinator: LocationPageCoordinator?
    
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
    
//    let geocoder = Geocoder()
//
//    // Call the geocodeAddress function with the address "Paris, France"
//    geocoder.geocodeAddress("Paris, France") { (coordinates, error) in
//        if let error = error {
//            print("Error geocoding address: \(error.localizedDescription)")
//        } else if let coordinates = coordinates {
//            self.locationManager.currentLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
//        }
//    }
}
