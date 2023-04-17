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
    var viewController: LocationPageViewController?
    var coordinates: CLLocationCoordinate2D?
    var error: Error?
    
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
    
    func goToSelection(transitType: MKDirectionsTransportType){
        
        if viewController?.textField.text == ""{
            viewController?.showAlert()
        }else{
            geocodeAddress(viewController?.textField.text ?? "paris") { (coordinates, error) in
                if let error = error {
                    print("Error geocoding address: \(error.localizedDescription)")
                } else if let coordinates = coordinates {
                    LocationManager.shared.currentLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
                }
            }
            Cache.shared.transitType = transitType
            coordinator?.goToSelection()
        }
    }
}

