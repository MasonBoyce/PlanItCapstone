//
//  WelcomeCoordinator.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/2/22.
//

import Foundation
import UIKit

//Coordinator for the Welcome Page
class WelcomeCoordinator: WelcomeCoordinatorProtocol, Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //Initializes view controller model and connects them.
    //Pushes the view controller to the top of the screen
    func start() {
        let viewController: WelcomeViewController = WelcomeViewController()
        let model: WelcomeModel = WelcomeModel()
        
        viewController.model = model
        model.viewController = viewController
        model.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    //Intilize mapCoordinator as a child coordinator then starts it
    func goToMap() {
        let mapCoordinator = MapCoordinator(navigationController: navigationController)
        mapCoordinator.parentCoordinator = self
        children.append(mapCoordinator)
        mapCoordinator.start()
    }
}
