//
//  SelectVenuesModel.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/14/23.
//

import Foundation
import UIKit
import MapKit

class SelectVenuesModel {
    var viewController: SelectVenuesViewController?
    var coordinator: SelectVenuesCoordinator?
    var venues: [Venue] = []
   
   //sumbit button
   func finishedSelectionTapped() {
       coordinator?.didFinish(venues: venues)
   }
    
}
