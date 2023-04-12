//
//  Cache.swift
//  PlanIt
//
//  Created by Mason Boyce on 4/11/23.
//

import Foundation

class  Cache {
    static let shared = Cache()
        
         var cache: [String: [Venue]] = [:]
        
        func get(searchQuery: String) -> [Venue]? {
            return cache[searchQuery]
        }
        
        func set(searchQuery: String, results: [Venue]) {
            if !results.isEmpty {
            cache[searchQuery] = results
            }
            
        }
    
}
