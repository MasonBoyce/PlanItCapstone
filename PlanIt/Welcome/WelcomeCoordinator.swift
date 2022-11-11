//
//  WelcomeCoordinator.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/2/22.
//

import Foundation
import UIKit



class WelcomeCoordinator: WelcomeCoordinatorProtocol, Coordinator {
    var navigationController: UINavigationController
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
       
    }
    
    func start() {
        let viewController: WelcomeViewController = WelcomeViewController()
        let model: WelcomeModel = WelcomeModel()
        
        viewController.model = model
        model.viewController = viewController
        model.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    func goToMap() {
        let mapCoordinator = MapCoordinator(navigationController: navigationController)
        mapCoordinator.parentCoordinator = self
        children.append(mapCoordinator)
        mapCoordinator.start()
    }
}
