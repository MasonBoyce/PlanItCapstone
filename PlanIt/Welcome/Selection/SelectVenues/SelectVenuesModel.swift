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
    var selectedVenues: [Venue] = []
   
   //sumbit button
    func finishedSelectionTapped(venues: [Venue]) {
        for venue in venues {
            if venue.selected {
                selectedVenues.insert(venue, at: 0)
            }
        }
        Cache.shared.set(searchQuery: coordinator?.categoryType ?? "", results: venues)
       coordinator?.didFinish(venues: selectedVenues)
//
   }
    
}
