//
//  SelectionProtocol.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/13/23.
//

import Foundation
import UIKit

protocol SelectionViewControllerProtocol: AnyObject {
    
}

protocol SelectionModelProtocol: AnyObject {
    func yelpApiCall(buttonType: String)
    func goToSelctVenues()
}

protocol SelectionCoordinatorProtocol: AnyObject {
    func goToSelctVenues()
}

