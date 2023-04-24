//
//  SelectVenuesModel.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/14/23.
//

import Foundation
import UIKit
import MapKit

var newselectedVenues: [Venue] = []

class SelectVenuesModel {
    var viewController: SelectVenuesViewController?
    var coordinator: SelectVenuesCoordinator?
    var venues: [Venue]
   
    init(venues: [Venue]){
        self.venues = venues
//        print("FUCK",venues)
    }
    
    func finishedSelectionTapped(newVenues: [Venue]) {
//        print("FUCK",venues)
        newselectedVenues = []
        for venue in newVenues {
            if venue.selected {
                newselectedVenues.insert(venue, at: 0)
            }
        }
        Cache.shared.setYelp(searchQuery: coordinator?.categoryType ?? "", results: newVenues)
        coordinator?.didFinish(venues: newselectedVenues)
    }
    
}
