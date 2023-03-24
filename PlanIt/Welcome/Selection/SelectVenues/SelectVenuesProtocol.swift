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
    
}

protocol SelectVenuesCoordinatorProtocol: AnyObject {
    func didFinish(venues: [Venue])
}
