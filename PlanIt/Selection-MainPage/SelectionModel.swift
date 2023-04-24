//
//  SelectionModel.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/13/23.
//

import Foundation
import MapKit


class SelectionModel  {
    var viewController: SelectionUIViewControllerProtocol?
    var coordinator: SelectionCoordinator?
    var venues: [Venue] = []
    
    func goToSelectVenues(categoryType: String){
//        YelpApi.shared.retriveVenues(latitude: LocationManager.shared.destinationLoaction!.latitude, longitude: LocationManager.shared.destinationLoaction!.longitude, category: categoryType, limit: 20, sortBy: "distance", locale: "en_US"){_,_ in
                                     
            self.coordinator?.goToSelectVenues(categoryType: categoryType)
//    }
    }
    
    func update(newVenues: [Venue]) {
        for venue in newVenues {
            if !self.venues.contains(venue){
                self.venues.append(venue)
            }
        }
        
    }
    
    func goToMap(tripSession: TripSession) {
        self.coordinator?.goToMap(venues: self.venues, tripSession: tripSession)
            // The trip session algorithm has finished, so you can now open the map
    }
    
    func calculateIdealRoute() {
        if venues.count <= 2 {
            goToMap(tripSession: TripSession(newVenues: self.venues, model: self))
        }
        let tripSession = TripSession(newVenues: self.venues, model: self)
        tripSession.start()
    }
}

