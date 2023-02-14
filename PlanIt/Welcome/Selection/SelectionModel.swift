//
//  SelectionModel.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/13/23.
//

import Foundation
import MapKit


class SelectionModel {
    var viewController: SelectionUIViewController?
    var coordinator: SelectionCoordinator?
    let currentCoordinate =  CLLocationCoordinate2D(latitude: 29.9407, longitude: -90.1203)
    var venues: [Venue] = []
    
    
    func goToMap(){
        coordinator?.goToMap()
    }
    
    func yelpApiCall(buttonType: String) {
        
            let latitude = currentCoordinate.latitude
            let longitude = currentCoordinate.longitude
            let category = buttonType
            let limit = 5
            let sortBy = "distance"
            let locale = "en_US"
            
            let yelpApi = YelpApi()
            yelpApi.retriveVenues(latitude: latitude, longitude: longitude, category: category, limit: limit, sortBy: sortBy, locale: locale) {
                (response, error) in
                if let response = response {
                    self.venues = response
//                    DispatchQueue.main.async {
//                        
//                        
//                    }
                    //HANDLE ERROR
                }
            }
            
            
        }
    }
    

