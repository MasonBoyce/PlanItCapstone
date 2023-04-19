//
//  SelectionModel.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/13/23.
//

import Foundation
import MapKit


class SelectionModel: SelectionModelProtocol {
    var viewController: SelectionUIViewControllerProtocol?
    var coordinator: SelectionCoordinatorProtocol?
    var venues: [Venue] = []
    
    func goToSelectVenues(categoryType: String){
        coordinator?.goToSelectVenues(categoryType: categoryType)
    }
    
    func update(venues: [Venue]) {
        self.venues += venues
    }
    
    
    
    func goToMap(tripSession: TripSession) {
        self.coordinator?.goToMap(venues: self.venues, tripSession: tripSession)
            // The trip session algorithm has finished, so you can now open the map
    }
    
    func calculateIdealRoute() {
        let tripSession = TripSession(newVenues: self.venues, model: self)
        tripSession.start()
    }
}
