//
//  MapModel.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/11/22.
//

import Foundation
import UIKit

class MapModel: MapModelProtocol {
    var viewController: MapViewControllerProtocol?
    var coordinator: MapCoordinatorProtocol?
    
    init() {
        
    }
    func doSomething(button: UIButton) {
        button.setTitle("mason was here", for: .normal)
        coordinator?.goToMap()
    }
    
    
}
