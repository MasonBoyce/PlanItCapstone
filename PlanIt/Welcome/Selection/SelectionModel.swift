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
        self.venues = venues
    }
    
    func goToMap() {
        coordinator?.goToMap(venues: venues)
    }
    

    }
    

