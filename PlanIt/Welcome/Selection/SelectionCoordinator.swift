//
//  SelectionCoordinator.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/13/23.
//

import Foundation
import UIKit

class SelectionCoordinator: Coordinator, SelectionCoordinatorProtocol {
    
    var model: SelectionModelProtocol?
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    //Initializes view controller model and connects them.
    //Pushes the view controller to the top of the screen
    
    let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
    func start() {
        let viewController  = storyboard.instantiateViewController(withIdentifier: "SelectionUI") as! SelectionUIViewController
        let model: SelectionModel = SelectionModel()

        viewController.model = model
        model.viewController = viewController
        model.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToSelectVenues(categoryType: String) {
        let selectVenues = SelectVenuesCoordinator(navigationController: navigationController, categoryType: categoryType, delegate: self)
        selectVenues.parentCoordinator = self
        
        children.append(selectVenues)
        selectVenues.yelpAPICall()
    }
    
    func goToMap(venues: [Venue]) {
        let mapCoordinator = MapCoordinator(navigationController: navigationController, venues: venues)
        mapCoordinator.parentCoordinator = self
        children.append(mapCoordinator)
        mapCoordinator.start()
    }
    
    func finish(venues: [Venue]) {
        model?.update(venues: venues)
    }
}

extension SelectionCoordinator: SelectionDelegateProtocol {
    func didFinish(venues: [Venue]) {
        finish(venues: venues)
    }
}

