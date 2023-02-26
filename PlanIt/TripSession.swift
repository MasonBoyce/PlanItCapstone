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
    var route_matrix: [[MKRoute]] // to store entire route objs in matrix
    var id_to_venue_dict: [Int: Venue]
    var all_venue_permutations: [[Int]]
    var all_venue_pairs: [(Int, Int)]
    
    init(newVenues: [Venue]) {
        venues = newVenues
        
        let num_venues = venues.count
        
        cost_matrix = Array(repeating: Array(repeating: -1.0, count: num_venues), count: num_venues) // info_matrix???
        let nil_route = MKRoute()
        route_matrix = Array(repeating: Array(repeating: nil_route, count: num_venues), count: num_venues) // info_matrix???
        
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
    
    func get_route_cost(source_id: Int, destination_id: Int) -> Double {
        var route = route_matrix[source_id][destination_id]
        var name_check = route.name
        
        if name_check == "" {
            route = route_matrix[destination_id][source_id]
            name_check = route.name
            
            if name_check == "" { // Check if cost exists for reverse path; likely is similar cost
                calculate_route(source_id: source_id, destination_id: destination_id)
                route = route_matrix[source_id][destination_id]
            }
            
        }
        
        let cost = route.expectedTravelTime
        
        return cost
    }
    
    func get_route(source_id: Int, destination_id: Int) -> MKRoute { // only if info_matrix is used
        var route = route_matrix[source_id][destination_id]
        var name_check = route.name
        
        if name_check == "" {
            calculate_route(source_id: source_id, destination_id: destination_id)
            route = route_matrix[source_id][destination_id]
        }
        
        return route
    }
    
    func calculate_route(source_id: Int, destination_id: Int) {
        let sourceVenue = id_to_venue_dict[source_id]
        let destinationVenue = id_to_venue_dict[destination_id]
        
        let sourceLocation = CLLocationCoordinate2D(latitude: sourceVenue?.latitude ?? -1.0, longitude: sourceVenue?.longitude ?? -1.0)
        let destinationLocation = CLLocationCoordinate2D(latitude: destinationVenue?.latitude ?? -1.0, longitude: destinationVenue?.longitude ?? -1.0)
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
        let destinationItem = MKMapItem(placemark: destinationPlaceMark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationItem
        directionRequest.transportType = .walking
        
        let direction = MKDirections(request: directionRequest)
        
        direction.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("ERROR FOUND : \(error.localizedDescription)")
                }
                return
            }
            
            let route = response.routes[0]
            
            // Assign source->destination to route_matrix[source][destination]
            self.route_matrix[source_id][destination_id] = route
            //        let rect = route.polyline.boundingMapRect
            //
            //        self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
        
    }
     
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
    
    func find_optimal_venue_id_perm() -> ([Int], Double) {
        
        var all_perms = get_venue_permutations()
        let num_venues = venue_ids.count
        
        var source_id = -1
        var destination_id = -1
        var curr_cost_sum = 0.0
        var cost_min = Double.infinity
        var optimal_venue_id_perm: [Int] = []
        
        for venue_id_perm in all_perms {
            for venue_id_spot in (0 ... num_venues - 2) {
                source_id = venue_id_perm[venue_id_spot]
                destination_id = venue_id_perm[venue_id_spot + 1]
                curr_cost_sum = curr_cost_sum + get_route_cost(source_id: source_id, destination_id: destination_id)
            }
            
            if curr_cost_sum < cost_min {
                optimal_venue_id_perm = venue_id_perm
                cost_min = curr_cost_sum
            }
            
            curr_cost_sum = 0.0
        }
        return (optimal_venue_id_perm, cost_min)
    }
    
}
