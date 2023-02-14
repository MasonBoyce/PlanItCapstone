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
    //Old View Controller

    
    func start() {
         // The first time this coordinator started, is to launch login page.
    goToLoginPage()
    }
    
    let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
    func goToLoginPage(){
         // Instantiate LoginViewController
        let WelcomeViewController  = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! WelcomeViewController
        let model = WelcomeModel()
        WelcomeViewController.model = model
        model.coordinator = self
        navigationController.pushViewController(WelcomeViewController , animated: true)
    }
    
    //Intilize mapCoordinator as a child coordinator then starts it
    func goToSelection() {
        let SelectionUI  = storyboard.instantiateViewController(withIdentifier: "SelectionUI") as! SelectionUIViewController
        let selectionCoordinator =  SelectionCoordinator(navigationController: navigationController)
        selectionCoordinator.parentCoordinator = self
        navigationController.pushViewController(SelectionUI, animated: true)
        
        selectionCoordinator.start()
    }
}
