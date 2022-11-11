//
//  MapProtocol.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/11/22.
//

import Foundation
import UIKit

protocol MapViewControllerProtocol: AnyObject {
    //var welcomeLabel: UILabel {get}
}

protocol MapModelProtocol: AnyObject {
    func doSomething(button: UIButton)
}

protocol MapCoordinatorProtocol: AnyObject {
    func goToMap()
}
