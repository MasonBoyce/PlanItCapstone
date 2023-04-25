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
    var hasFixedEndPoints: Bool = false
    var startID: Int?
    var endId: Int?
    
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
        categoryToSelectedVenues[category] = newVenues
        updateSelectedVenues()
    }
    
    func updateSelectedVenues() {
        
        self.selectedVenues = []
        for (_, venues) in categoryToSelectedVenues{
            for venue in venues {
                self.selectedVenues.append(venue)
            }
        }
    }
}
