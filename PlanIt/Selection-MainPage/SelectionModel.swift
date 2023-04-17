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
    
    func goToMap() {
        calculateIdealRoute(forVenues: venues) { tripSession in
            // The trip session algorithm has finished, so you can now open the map
            self.coordinator?.goToMap(venues: self.venues, tripSession: tripSession)
        }
        
    }
    
    func calculateIdealRoute(forVenues venues: [Venue], completion: @escaping (TripSession) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let tripSession = TripSession(newVenues: venues)
            
            
            // Call the completion handler once the algorithm is finished
            DispatchQueue.main.async {
                tripSession.start(){
                    completion(tripSession)
                }
                
                
            }
            
        }
    }
}


