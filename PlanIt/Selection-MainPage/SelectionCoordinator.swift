//
//  SelectionCoordinator.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/13/23.
//

import Foundation
import UIKit

class SelectionCoordinator: Coordinator, SelectionCoordinatorProtocol {
    
    var model: SelectionModel?
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
        self.model =  model
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    //** TODO - Result Error Handler with category **//
//    func goToSelectVenues(categoryType: String, completion: @escaping ([String]?, Error?) -> Void) {
    func goToSelectVenues(categoryType: String) {
        let selectVenues = SelectVenuesCoordinator(navigationController: navigationController, categoryType: categoryType, delegate: self)
        selectVenues.parentCoordinator = self
        
        children.append(selectVenues)
    }
    
    func goToMap(venues: [Venue], tripSession: TripSession) {
        let mapCoordinator = MapCoordinator(navigationController: navigationController, venues: venues, tripSession: tripSession)
        mapCoordinator.parentCoordinator = self
        children.append(mapCoordinator)
        mapCoordinator.start()
    }
    
    func finish(venues: [Venue]) {
        self.model?.update(newVenues: venues)
    }
}

extension SelectionCoordinator: SelectionDelegateProtocol {
    func didFinish(venues: [Venue]) {
        self.finish(venues: venues)
    }
}

