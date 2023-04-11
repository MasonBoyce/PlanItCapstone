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
    var venues: [Venue]  = []
    var locationManager: LocationManager
    
    init(navigationController: UINavigationController,venues: [Venue],locationManager:LocationManager) {
        self.navigationController = navigationController
        self.venues = venues
        self.locationManager = locationManager
    }
    
    //Initializes view controller model and connects them.
    //Pushes the view controller to the top of the screen
    func start() {
        
        let model: MapModel = MapModel(venues: self.venues, locationManager:locationManager)
        let viewController: MapViewController = MapViewController()
        viewController.model = model
        model.viewController = viewController
        model.coordinator = self
        model.addAnnotations()
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
