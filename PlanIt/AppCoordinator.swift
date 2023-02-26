//
//  AppCordinator.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/4/22.
//

import Foundation
import UIKit

//The initial AppCordinator
class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navCon : UINavigationController) {
        self.navigationController = navCon
    }
    
    func start() {
        goToWelcome()
        
    }
    //Itilizes welcome as a child coordinator and go to it
    func goToWelcome() {
        let welcomeCoordinator = WelcomeCoordinator(navigationController: navigationController)
        welcomeCoordinator.parentCoordinator = self
        children.append(welcomeCoordinator)
        welcomeCoordinator.start()
        
    }
    
   
}
