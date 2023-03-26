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
    var time_groups : [String: [Int]] // (morning,afternoon,evening,any)
    var all_time_group_perms : [ String: [[Int]] ]
    
    init(newVenues: [Venue]) {
        venues = newVenues
        
        let num_venues = venues.count
        
        cost_matrix = Array(repeating: Array(repeating: -1.0, count: num_venues), count: num_venues) // info_matrix???
        let nil_route = MKRoute()
        route_matrix = Array(repeating: Array(repeating: nil_route, count: num_venues), count: num_venues) // info_matrix???
        
        id_to_venue_dict = [Int: Venue]()
        venue_ids = [Int]()
        
        time_groups = [String: [Int]]()
        time_groups["Morning"] = [Int]()
        time_groups["Afternoon"] = [Int]()
        time_groups["Evening"] = [Int]()
        time_groups["Any"] = [Int]()
        all_time_group_perms = [String: [[Int]]]()
        
        for (index, venue) in venues.enumerated(){
            id_to_venue_dict[index] = venue
            venue_ids.append(index)
            switch venue.time_of_day{
            case "Morning":
                self.time_groups["Morning"]?.append(index)
                self.all_time_group_perms["Morning"] = []
            case "Afternoon":
                self.time_groups["Afternoon"]?.append(index)
                self.all_time_group_perms["Afternoon"] = []
            case "Evening":
                self.time_groups["Evening"]?.append(index)
                self.all_time_group_perms["Evening"] = []
            default:
                self.time_groups["Any"]?.append(index)
                self.all_time_group_perms["Any"] = []
            }
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
    
    func get_time_group_perms() -> [String: [[Int]]] {
        if all_time_group_perms.count == 0 {
            set_timed_permutations()
        }
        return all_time_group_perms
    }
    
    // With help from https://en.wikipedia.org/wiki/Heap%27s_algorithm (Heap's Algorithm)
    // k is length of venues list; venues list is original order of routes
    func set_timed_permutations(){
        var time_group_size = 0
        var time_group_ids = [Int]()
        for time in time_groups.keys{
            time_group_ids = time_groups[time] ?? []
            time_group_size = time_groups[time]?.count ?? 0
            print("SETTING " + String(time))
            set_indiv_time_perm(k: time_group_size, time: time, venues: time_group_ids)
        }
    }
    
    func set_indiv_time_perm(k: Int, time: String, venues: [Int]) {
        var coords = venues
        if k == 1 {
            self.all_time_group_perms[time]?.append(coords)
            print(coords)
        } else {
            // Generate permutations with k-th unaltered
            // Initially k = length(A)
            set_indiv_time_perm(k: k - 1, time: time, venues: coords)
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
                set_indiv_time_perm(k: k - 1, time: time, venues: coords)
            }
        }
    }
    
    func find_optimal_venue_route_perm() -> ([MKRoute], Double) {
        
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
        
        var ordered_routes = [MKRoute]()
        
        var temp_source_venue_id = -1
        var temp_destination_venue_id = -1
        
        print(optimal_venue_id_perm)
        for venue_index in (0 ... optimal_venue_id_perm.count - 2) {
            temp_source_venue_id = optimal_venue_id_perm[venue_index]
            temp_destination_venue_id = optimal_venue_id_perm[venue_index + 1]
            print(temp_source_venue_id, terminator: "")
            print(temp_destination_venue_id)
            ordered_routes.append(route_matrix[temp_source_venue_id][temp_destination_venue_id])
        }
        
        return (ordered_routes, cost_min)
    }
    
    func find_time_of_day_route_perm() -> ([MKRoute], Double) {
        
        
        var time_group_perms = get_time_group_perms()
        let num_venues = venue_ids.count
        
        var source_id = -1
        var destination_id = -1
        var curr_cost_sum = 0.0
        var cost_min = Double.infinity
        var optimal_venue_id_perm: [Int] = []
        var time_group_perms: [[Int]] = []
        
        // Calculate all time-relevant routes
        for time in all_time_group_perms.keys {
            time_group_perms = all_time_group_perms[time]
            for venue_id_perm in time_group_perms {
                for venue_id_spot in (0 ... num_venues - 2) {
                    source_id = venue_id_perm[venue_id_spot]
                    destination_id = venue_id_perm[venue_id_spot + 1]
                    calculate_route(source_id: source_id, destination_id: destination_id)
                }
            }
        }
        
        
        
        
        
        
        
        var ordered_routes = [MKRoute]()
        
        var temp_source_venue_id = -1
        var temp_destination_venue_id = -1
        
        print(optimal_venue_id_perm)
        for venue_index in (0 ... optimal_venue_id_perm.count - 2) {
            temp_source_venue_id = optimal_venue_id_perm[venue_index]
            temp_destination_venue_id = optimal_venue_id_perm[venue_index + 1]
            print(temp_source_venue_id, terminator: "")
            print(temp_destination_venue_id)
            ordered_routes.append(route_matrix[temp_source_venue_id][temp_destination_venue_id])
        }
        
        return (ordered_routes, cost_min)
    }
    
}
