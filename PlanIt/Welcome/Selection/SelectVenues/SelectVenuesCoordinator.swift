//
//  SelectVenuesCoordinator.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/14/23.
//

import Foundation
import UIKit

class SelectVenuesCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var categoryType: String

    init(navigationController: UINavigationController, categoryType: String) {
        self.navigationController = navigationController
        self.categoryType = categoryType
    }

    //Initializes view controller model and connects them.
    //Pushes the view controller to the top of the screen
    //MAIN???
    let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
    func start() {
        let viewController  = SelectVenuesViewController()
        let model: SelectVenuesModel = SelectVenuesModel(categoryType: categoryType)
        
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
