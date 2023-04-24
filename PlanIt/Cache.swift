//
//  Cache.swift
//  PlanIt
//
//  Created by Mason Boyce on 4/11/23.
//

import Foundation
import MapKit

class  Cache {
    static let shared = Cache()
    
    var cache: [String: [Venue]] = [:]
    var transitType: MKDirectionsTransportType?
    var selectedVenues: [Venue] = []
    private var categoryToSelectedVenues: [String: [Venue]] = [:]
    
  
    
    func getYelp(searchQuery: String) -> [Venue]? {
        
        return cache[searchQuery]
    }
    
    func setYelp(searchQuery: String, results: [Venue]) {
        if !results.isEmpty {
            cache[searchQuery] = results
        }
        
    }
    
    func updateSelectedVenues(category: String, newVenues: [Venue]){
        categoryToSelectedVenues[category] = []
//        print("FUCK",categoryToSelectedVenues[category])
        categoryToSelectedVenues[category] = newVenues
//        print("FUCK", categoryToSelectedVenues[category])
        updateSelectedVenues()
    }
    
    func updateSelectedVenues() {
        self.selectedVenues = []
//        print("FUCK OFF",categoryToSelectedVenues)
        for (cat, venues) in categoryToSelectedVenues{
            print("FUCK",cat,venues)
            for venue in venues {
                self.selectedVenues.append(venue)
            }
        }
    }
}
