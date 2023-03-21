//
//  SelectionProtocol.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/13/23.
//

import Foundation
import UIKit

protocol SelectionUIViewControllerProtocol: AnyObject {
    
}

protocol SelectionModelProtocol: AnyObject {
    func goToSelectVenues(categoryType: String)
    func goToMap()
}

protocol SelectionCoordinatorProtocol: AnyObject {
    func goToSelectVenues(categoryType: String)
    func goToMap()
}

