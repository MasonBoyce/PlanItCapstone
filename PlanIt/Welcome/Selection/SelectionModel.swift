//
//  SelectionModel.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/13/23.
//

import Foundation


class SelectionModel {
    var viewController: SelectionUIViewController?
    var coordinator: SelectionCoordinator?
    
    
    func goToMap(){
        coordinator?.goToMap()
    }
    
}
