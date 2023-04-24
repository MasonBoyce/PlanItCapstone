//
//  MapCoordinator.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/11/22.
//

import Foundation
import UIKit

class MapCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var venues: [Venue]  = []
    var tripSession: TripSession
    
    init(navigationController: UINavigationController,venues: [Venue],  tripSession: TripSession) {
        self.navigationController = navigationController
        self.venues = venues
        self.tripSession = tripSession
    }

    func start() {
        let model: MapModel = MapModel(venues: self.venues)
        let viewController: MapViewController = MapViewController()
        viewController.model = model
        model.viewController = viewController
        model.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
        model.tripSession = tripSession
       
        
       
    }
    
    func goToResult() {
        let resultCoordinator = ResultCoordinator(navigationController: navigationController, tripSession: tripSession)
        resultCoordinator.parentCoordinator = self
        resultCoordinator.start()
//        children.append(resultCoordinator)
    }
    
    
}
