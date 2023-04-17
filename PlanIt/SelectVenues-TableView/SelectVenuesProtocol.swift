//
//  SelectVenuesProtocol.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/14/23.
//

import Foundation


protocol SelectVenuesViewControllerProtocol: AnyObject {
    
}

protocol SelectVenuesModelProtocol: AnyObject {
    var veunes: [Venue] {get set}
}

protocol SelectVenuesCoordinatorProtocol: AnyObject {
    func didFinish(venues: [Venue])
    
}
