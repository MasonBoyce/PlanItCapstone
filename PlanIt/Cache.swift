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
        
        func get(searchQuery: String) -> [Venue]? {
            
            return cache[searchQuery]
        }
        
        func set(searchQuery: String, results: [Venue]) {
            if !results.isEmpty {
            cache[searchQuery] = results
            }
            
        }
    
}
