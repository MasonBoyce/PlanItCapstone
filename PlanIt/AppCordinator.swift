//
//  AppCordinator.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/4/22.
//

import Foundation
import UIKit


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
    
    func goToWelcome() {
        let welcomeCoordinator = WelcomeCoordinator(navigationController: navigationController)
        welcomeCoordinator.parentCoordinator = self
        children.append(welcomeCoordinator)
        welcomeCoordinator.start()
        something()
        }
    
    func something(){
        let testPlayground = Playground(testVar: 4)
        testPlayground.testPrint()
        print("Hello world")
    }
}
