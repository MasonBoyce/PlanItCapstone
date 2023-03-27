//
//  WelcomeProtocol.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/2/22.
//

import Foundation
import UIKit

protocol WelcomeViewControllerProtocol: AnyObject {
    var welcomeLabel: UILabel {get}
}

protocol WelcomeModelProtocol: AnyObject {
    func doSomething()
}

protocol WelcomeCoordinatorProtocol: AnyObject {
    func goToSelection(locationManager: LocationManager)
}

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}


