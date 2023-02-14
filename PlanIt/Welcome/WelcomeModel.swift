//
//  WelcomeModel.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/2/22.
//

import Foundation
import UIKit

class WelcomeModel: WelcomeModelProtocol {
    var viewController: WelcomeViewControllerProtocol?
    var coordinator: WelcomeCoordinatorProtocol?
  
    func doSomething() {
        coordinator?.goToSelection()
    }
    
    
}
