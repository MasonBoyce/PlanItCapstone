//
//  SelectVenuesProtocol.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/14/23.
//

import Foundation


protocol SelectionViewControllerProtocol: AnyObject {
    
}

protocol SelectionModelProtocol: AnyObject {
    func yelpApiCall(categorytype: String)
    func goToSelctVenues(categoryType: String)
    func goToMap()
}

protocol SelectionCoordinatorProtocol: AnyObject {
    func goToSelctVenues(categoryType: String)
    func goToMap()
}
