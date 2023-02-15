//
//  SelectVenuesModel.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/14/23.
//

import Foundation
import UIKit
import MapKit

class SelectVenuesModel {
    var viewController: SelectVenuesViewController?
    var coordinator: SelectVenuesCoordinator?
    var venues: [Venue] = []
    let currentCoordinate =  CLLocationCoordinate2D(latitude: 29.9407, longitude: -90.1203)
    
    init(categoryType: String){
        yelpApiCall(categoryType: categoryType)
    }
    
    func yelpApiCall(categoryType: String) {
            let latitude = currentCoordinate.latitude
            let longitude = currentCoordinate.longitude
            let category = categoryType
            let limit = 5
            let sortBy = "distance"
            let locale = "en_US"
            
            let yelpApi = YelpApi()
        yelpApi.retriveVenues(latitude: latitude, longitude: longitude, category: category, limit: limit, sortBy: sortBy, locale: locale) {
                (response, error) in
                if let response = response {
                    self.venues = response
        
//                    DispatchQueue.main.async {
//             }
                    //HANDLE ERROR
                }
            }
            
            
        }
    
}
