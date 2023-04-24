//
//  LocationPageCoordinator.swift
//  PlanIt
//
//  Created by Mason Boyce on 4/11/23.
//

import Foundation
import UIKit

class LocationPageCoordinator: Coordinator{
    var navigationController: UINavigationController
    var sCoordinator: SelectionCoordinator?
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        // The first time this coordinator started, is to launch login page.
        goToLoginPage()
    }
    
    let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
    
    func goToLoginPage(){
        // Instantiate LoginViewController
        let locationPageViewController  = LocationPageViewController()
        let model = LocationPageModel()
        locationPageViewController.model = model
        model.viewController  = locationPageViewController
        model.coordinator = self
        locationPageViewController.coordinator = self
        navigationController.pushViewController(locationPageViewController , animated: true)
    }
    
    //Intilize mapCoordinator as a child coordinator then starts it
    func goToSelection() {
        let selectionCoordinator =  SelectionCoordinator(navigationController: navigationController)
        selectionCoordinator.parentCoordinator = self
        selectionCoordinator.start()
    }
    
}


