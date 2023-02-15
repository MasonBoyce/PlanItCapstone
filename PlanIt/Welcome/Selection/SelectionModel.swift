//
//  SelectionModel.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/13/23.
//

import Foundation
import MapKit


class SelectionModel: SelectionModelProtocol {
    var viewController: SelectionViewControllerProtocol?
    var coordinator: SelectionCoordinatorProtocol?
   
    var venues: [Venue] = []
    
    func goToSelctVenues(categoryType: String){
        coordinator?.goToSelctVenues(categoryType: categoryType)
    }
    
    func goToMap() {
        coordinator?.goToMap()
    }
    

    }
    

