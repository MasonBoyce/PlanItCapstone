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
    
  
    
    func goToSelectVenues(categoryType: String, completion: @escaping () -> Void){

        self.coordinator?.goToSelectVenues(categoryType: categoryType)
        completion()
    }
    
    
    func goToMap(tripSession: TripSession) {
        self.coordinator?.goToMap(tripSession: tripSession)
            // The trip session algorithm has finished, so you can now open the map
    }
    
    func calculateIdealRoute() {
        if Cache.shared.selectedVenues.count <= 1 {
            goToMap(tripSession: TripSession(model: self))
        }
        let tripSession = TripSession(model: self)
        tripSession.start()
        
    }
    
    func goToSequence() {
        self.coordinator?.goToSequence()
    }
}

