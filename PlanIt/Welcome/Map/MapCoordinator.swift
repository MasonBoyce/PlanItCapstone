//
//  MapCoordinator.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/11/22.
//

import Foundation
import UIKit

class MapCoordinator: MapCoordinatorProtocol, Coordinator {
    var navigationController: UINavigationController
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
       
    }
    
    func start() {
        let viewController: MapViewController = MapViewController()
        let model: MapModel = MapModel()
        
        viewController.model = model
        model.viewController = viewController
        model.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
