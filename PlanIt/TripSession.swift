//
//  TripSession.swift
//  PlanIt
//
//  Created by Garrett Gilliom on 2/12/23.
//

import Foundation
import UIKit
import MapKit

class TripSession {
    
    var venues: [Venue]
    var venue_ids: [Int]
    var optimal_venue_route: [Int]
    var cost_matrix: [[Double]]
    // var info_matrix: [[?????]] // to store entire route objs in matrix
    var id_to_venue_dict: [Int: Venue]
    var all_venue_permutations: [[Int]]
    var all_venue_pairs: [(Int, Int)]
    
    init(newVenues: [Venue]) {
        venues = newVenues
        
        let num_venues = venues.count
        cost_matrix = Array(repeating: Array(repeating: -1.0, count: num_venues), count: num_venues) // info_matrix???
        
        id_to_venue_dict = [Int: Venue]()
        venue_ids = [Int]()
        for (index, venue) in venues.enumerated(){
            id_to_venue_dict[index] = venue
            venue_ids.append(index)
        }
        
        all_venue_permutations = [[Int]]()
        all_venue_pairs = [(Int, Int)]()
        optimal_venue_route = [Int]()
    }
    
    func get_route_cost(start_id: Int, end_id: Int) -> Double {
        var cost = cost_matrix[start_id][end_id]
        if cost < 0 {
            // set_route_info(start_id: Int, end_id: Int) // calculate route between start_id/end_id, assign to info_matrix
            // cost = info_matrix[start_id, end_id].cost // ??? grab cost from proper info_matrix cell
            set_route_cost(start_id: start_id, end_id: end_id, cost: cost)
            cost = cost_matrix[start_id][end_id]
        }
        
        return cost
    }
    
    func set_route_cost(start_id: Int, end_id: Int, cost: Double) { // change to route_info to store entire route objs?
        cost_matrix[start_id][end_id] = cost
    }
    
    /*
    func get_route_info(start_id: Int, end_id: Int) -> ????? { // only if info_matrix is used
        var route = info_matrix[start_id][end_id]
        if (route has not been set yet) {
            set_route_info(start_id: start_id, end_id: end_id)
            route = info_matrix[start_id][end_id]
        }
        return route
    }
     
    func set_route_info(start_id: Int, end_id: Int) { // only if info_matrix is used
        var route = calculate_route(start_id: Int, end_id: Int)
        info_matrix[start_id][end_id] = route
    }
     */
    
    func get_venue_permutations() -> [[Int]] {
        if all_venue_permutations.count == 0 {
            set_venue_permutations(k: venues.count, venues: venue_ids)
        }
        return all_venue_permutations
    }
    
    // With help from https://en.wikipedia.org/wiki/Heap%27s_algorithm (Heap's Algorithm)
    // k is length of venues list; venues list is original order of routes
    func set_venue_permutations(k: Int, venues: [Int]){
        //print(" ")
        var coords = venues
        if k == 1 {
            all_venue_permutations.append(coords)
        } else {
            // Generate permutations with k-th unaltered
            // Initially k = length(A)
            set_venue_permutations(k: k - 1, venues: coords)
            var temp: Int
            //print("k:", k)
            // Generate permutations for k-th swapped with each k-1 initial
            for i in (0 ... (k - 2)) {
                //print("i:", i)
                if k % 2 == 0 { // swap venues[i], venues[i+1]
                    temp = coords[i]
                    coords[i] = coords[k - 1]
                    coords[k - 1] = temp
                } else {
                    temp = coords[0]
                    coords[0] = coords[k - 1]
                    coords[k - 1] = temp
                }
                set_venue_permutations(k: k - 1, venues: coords)
            }
        }
    }
    
    
    
}
