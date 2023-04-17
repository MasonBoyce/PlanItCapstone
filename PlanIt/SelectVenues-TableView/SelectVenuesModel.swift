//
//  SelectVenuesModel.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/14/23.
//

import Foundation
import UIKit
import MapKit

var selectedVenues: [Venue] = []

class SelectVenuesModel {
    var viewController: SelectVenuesViewController?
    var coordinator: SelectVenuesCoordinator?
    var venues: [Venue]
    
   
    init(venues: [Venue]){
        self.venues = venues
    }
    
    func finishedSelectionTapped(venues: [Venue]) {
        for venue in venues {
            if venue.selected {
                selectedVenues.insert(venue, at: 0)
            }
        }
        Cache.shared.set(searchQuery: coordinator?.categoryType ?? "", results: venues)
        coordinator?.didFinish(venues: selectedVenues)
    }
    
}
