//
//  SelectionCoordinator.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/13/23.
//

import Foundation
import UIKit

class SelectionCoordinator: Coordinator, SelectionCoordinatorProtocol {
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    //Initializes view controller model and connects them.
    //Pushes the view controller to the top of the screen
    //MAIN???
    let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
    func start() {
        let viewController  = storyboard.instantiateViewController(withIdentifier: "SelectionUI") as! SelectionUIViewController
        let model: SelectionModel = SelectionModel()

        viewController.model = model
        model.viewController = viewController
        model.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToSelctVenues(categoryType: String) {
        let selectVenues = SelectVenuesCoordinator(navigationController: navigationController, categoryType: categoryType)
        selectVenues.parentCoordinator = self
        children.append(selectVenues)
        selectVenues.start()
    }
    
    func goToMap() {
        let mapCoordinator = MapCoordinator(navigationController: navigationController)
        mapCoordinator.parentCoordinator = self
        children.append(mapCoordinator)
        mapCoordinator.start()
    }
}
