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
    
    //Initializes view controller model and connects them.
    //Pushes the view controller to the top of the screen
    //Old View Controller

    
    func start() {
         // The first time this coordinator started, is to launch login page.
    goToLoginPage()
    }
    
    let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
    
    //** OPTIONAL - For Launch Screen Animation **//
//    func launchAnimation(){
//        let LaunchViewController  = storyboard.instantiateViewController(withIdentifier: "LaunchViewController") as! LaunchViewController
//        navigationController.pushViewController(LaunchViewController , animated: true)
//    }
    
    func goToLoginPage(){
         // Instantiate LoginViewController
        let LocationPageViewController  = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LocationPageViewController
        let model = LocationPageModel()
        LocationPageViewController.model = model
        model.coordinator = self
        navigationController.pushViewController(LocationPageViewController , animated: true)
    }
    
    //Intilize mapCoordinator as a child coordinator then starts it
    func goToSelection(locationManager: LocationManager) {
        
        let selectionCoordinator =  SelectionCoordinator(navigationController: navigationController,locationManager:locationManager)
        selectionCoordinator.parentCoordinator = self
        selectionCoordinator.start()
        
    }
    
}


