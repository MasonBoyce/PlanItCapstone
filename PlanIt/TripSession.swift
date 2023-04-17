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
    var time_groups : [String: [Int]] // (morning,afternoon,evening) // MAYBE add 'any' later
    var all_time_group_perms : [ String: [[Int]] ]
    var ordered_routes : [MKRoute]
    var cost_min : Double
    var num_routes_calculated : Int
    var start_venue_id: Int
    var end_venue_id: Int
    
    
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
        //time_groups["Any"] = [Int]()
        all_time_group_perms = [String: [[Int]]]()
        
        start_venue_id = -1
        end_venue_id = -1
        
        for (index, venue) in venues.enumerated(){
            id_to_venue_dict[index] = venue
            venue_ids.append(index)
            
            if venue.isStart {
                start_venue_id = index
            }
            
            if venue.isEnd {
                end_venue_id = index
            }
            
            switch venue.time_of_day{
            case "Morning":
                self.time_groups["Morning"]?.append(index)
                self.all_time_group_perms["Morning"] = []
            case "Evening":
                self.time_groups["Evening"]?.append(index)
                self.all_time_group_perms["Evening"] = []
            default:
                self.time_groups["Afternoon"]?.append(index)
                self.all_time_group_perms["Afternoon"] = []
            // default should be 'any' once that's incorporated
            
            }
        }
        
        all_venue_permutations = [[Int]]()
        
        all_venue_pairs = [(Int, Int)]()
        
        optimal_venue_route = [Int]()
        
        ordered_routes = [MKRoute]()
        
        cost_min = Double.infinity
        
        num_routes_calculated = 0
    }
    
    func get_route_cost(source_id: Int, destination_id: Int) -> Double {
        /*
        var temp = -1
        var start_id = source_id
        var end_id = destination_id
        if start_id > end_id { // switch to grab proper cost if start greater than end
            temp = start_id
            start_id = end_id
            end_id = temp
        }
        var route = route_matrix[start_id][end_id]
        */
        
        var route = MKRoute()
        if source_id > destination_id {
            print("REVERSE COST")
            route = route_matrix[destination_id][source_id] // get reversed route cost
        } else {
            route = route_matrix[source_id][destination_id] // get normal route cost
        }
        
        /*
        var travel_check = route.expectedTravelTime
        print(travel_check)
        if travel_check == 0.0 {
            print("HELLOOOOOO")
            route = route_matrix[destination_id][source_id]
            var travel_check = route.expectedTravelTime
            
            if travel_check == 0.0 { // Check if cost exists for reverse path; likely is similar cost
                print("HEREEE")
                calculate_route(source_id: source_id, destination_id: destination_id)
                route = route_matrix[source_id][destination_id]
            }
            
        }*/
        
        var cost = route.expectedTravelTime
        /*
        if cost == 0 {
            route = route_matrix[destination_id][source_id]
        }
        cost = route.expectedTravelTime
         */
        print(source_id, destination_id, cost)
        
        return cost
    }
    
    func get_route(source_id: Int, destination_id: Int) -> MKRoute { // only if info_matrix is used
        
        var route = MKRoute()
        if source_id > destination_id {
            print("REVERSE ROUTE")
            calculate_route(source_id: source_id, destination_id: destination_id) // b/c have been using reversed to get cost
        }
        route = route_matrix[source_id][destination_id] // get normal route cost
        
        //var route = route_matrix[source_id][destination_id]
        /*
        var travel_check = route.expectedTravelTime
        
        if travel_check == 0.0 {
            calculate_route(source_id: source_id, destination_id: destination_id)
            route = route_matrix[source_id][destination_id]
        }
        */
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
            // self.route_matrix[destination_id][source_id] = route
            print(source_id, destination_id,"ROUTE COST IN:", route.expectedTravelTime)
            self.num_routes_calculated += 1
            if self.num_routes_calculated >= self.all_venue_pairs.count {
                self.find_optimal_venue_route_perm() // change to a diff. algo later
            }
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
    
    func calculate_routes() {
        for pair in all_venue_pairs {
            print("CALC ROUTE", pair.0, pair.1)
            calculate_route(source_id: pair.0, destination_id: pair.1)
            // calculate_route(source_id: pair.1, destination_id: pair.0) // Calculate both ways
            print(pair.0, pair.1,"ROUTE COST OUT:", route_matrix[pair.0][pair.1].expectedTravelTime)
        }
    }
    
    func set_all_venue_pairs(){
        for i in 0..<(venue_ids.count) {
            for j in (i+1..<venue_ids.count) {
                all_venue_pairs.append((venue_ids[i], venue_ids[j]))
            }
        }
    }
    
    func start(completion: @escaping () -> Void) {
        set_all_venue_pairs()
        print("PAIRS",all_venue_pairs)
        set_venue_permutations(k: venues.count, venues: venue_ids)
        calculate_routes()
        completion()
    }
    
    func start_fixed_ends(completion: @escaping () -> Void) {
        // sets all_venue_pairs as all pairs of routes that aren't (start,end) or (end,start)
        set_all_venue_pairs()
        
        if start_venue_id < 0 || end_venue_id < 0 {
            return // idk, this should prob trigger the regular start(...) though???
        }
        
        all_venue_pairs = all_venue_pairs.filter{$0 != (start_venue_id, end_venue_id) || $0 != (end_venue_id, start_venue_id)}
        
        // sets all_venue_permutations as all permutations of routes that AREN'T the start or end route
        var trimmed_venues = venue_ids.filter{$0 != start_venue_id || $0 != end_venue_id}
        set_venue_permutations(k: venues.count - 2, venues: trimmed_venues)
        
        calculate_routes()
    }
    
    func find_optimal_route_order_fixed_ends() {
        
        if venues.count == 2 {
            ordered_routes.append(route_matrix[start_venue_id][end_venue_id])
            return // b/c that's the entire trip – maybe we should require users to select at least 3 venues?
        }
        
        // NEXT STEPS: just copy process from the below one but each perm should start/end w/ start/end venue
        // NOTE: important to loop thru smaller perms but w/ adding the start/end costs each time
        
        var source_id = -1
        var destination_id = -1
        var curr_cost_sum = 0.0
        // var cost_min = Double.infinity
        var optimal_venue_id_perm: [Int] = []
        
        let all_perms = all_venue_permutations
        
        var num_venues = venue_ids.count - 2 // venues to loop through, which excludes start and end
        
        print("CYCLING THROUGH PERMS")
        for venue_id_perm in all_perms {
            
            // Calculate start to first of perm cost, currend perm cost, then last of perm to end cost
            curr_cost_sum = curr_cost_sum + get_route_cost(source_id: start_venue_id, destination_id: venue_id_perm[0])
            for venue_id_spot in (0 ... num_venues - 2) {
                source_id = venue_id_perm[venue_id_spot]
                destination_id = venue_id_perm[venue_id_spot + 1]
                curr_cost_sum = curr_cost_sum + get_route_cost(source_id: source_id, destination_id: destination_id)
            }
            curr_cost_sum = curr_cost_sum + get_route_cost(source_id: venue_id_perm[num_venues-1], destination_id: end_venue_id)
            
            if curr_cost_sum < cost_min {
                optimal_venue_id_perm = venue_id_perm
                cost_min = curr_cost_sum
            }
            
            curr_cost_sum = 0.0
        }
        
        var temp_source_venue_id = -1
        var temp_destination_venue_id = -1
        
        print("OPTIMAL VENUE ID PERM")
        print(optimal_venue_id_perm)
        for venue_id in optimal_venue_id_perm {
            print(id_to_venue_dict[venue_id]?.name as Any, id_to_venue_dict[venue_id]?.address as Any)
        }
        
        var temp_route = MKRoute()
        var count = 0
        for venue_index in (0 ... optimal_venue_id_perm.count - 2) {
            temp_source_venue_id = optimal_venue_id_perm[venue_index]
            temp_destination_venue_id = optimal_venue_id_perm[venue_index + 1]
            print(temp_source_venue_id, terminator: "")
            print(temp_destination_venue_id, terminator: ", cost: ")
            print(route_matrix[temp_source_venue_id][temp_destination_venue_id].expectedTravelTime)
            
            //ordered_routes.append(route_matrix[temp_source_venue_id][temp_destination_venue_id])
            temp_route = get_route(source_id: temp_source_venue_id, destination_id: temp_destination_venue_id)
            while temp_route.expectedTravelTime == 0 {
                print("wait",count)
                count += 1
                temp_route = get_route(source_id: temp_source_venue_id, destination_id: temp_destination_venue_id)
            }
            ordered_routes.append(temp_route)
            //ordered_routes.append(get_route(source_id: temp_source_venue_id, destination_id: temp_destination_venue_id))
        }
        
        // calculate all routes (except for start->end –– SHOULD REQUIRE >2 VENUES)
        // run exhaustive search algo but add start/end venues to each perm
    }
    
    func find_optimal_venue_route_perm() { // NO RETURN B/C IMPORTANT DATA GAINED ARE STORED IN GLOBAL VARS
        
        /*
        set_all_venue_pairs()
        var all_perms = get_venue_permutations()
        print("START CALCULATING ROUTES")
        calculate_routes()
        print("FINISHED CALCULATING ROUTES")
         */
        
        let num_venues = venue_ids.count
        
        if num_venues == 2 {
            ordered_routes.append(route_matrix[venue_ids[0]][venue_ids[1]])
            return
        }
        
        var source_id = -1
        var destination_id = -1
        var curr_cost_sum = 0.0
        // var cost_min = Double.infinity
        var optimal_venue_id_perm: [Int] = []
        var temp = -1
        
        let all_perms = all_venue_permutations
        
        print("CYCLING THROUGH PERMS")
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
        
        // var ordered_routes = [MKRoute]()
        
        var temp_source_venue_id = -1
        var temp_destination_venue_id = -1
        
        print("OPTIMAL VENUE ID PERM")
        print(optimal_venue_id_perm)
        var counter = 0
        for venue_id in optimal_venue_id_perm {
            print(id_to_venue_dict[venue_id]?.name, id_to_venue_dict[venue_id]?.address)
        }
        var temp_route = MKRoute()
        for venue_index in (0 ... optimal_venue_id_perm.count - 2) {
            temp_source_venue_id = optimal_venue_id_perm[venue_index]
            temp_destination_venue_id = optimal_venue_id_perm[venue_index + 1]
            print(temp_source_venue_id, terminator: "")
            print(temp_destination_venue_id, terminator: ", cost: ")
            print(route_matrix[temp_source_venue_id][temp_destination_venue_id].expectedTravelTime)
            //ordered_routes.append(route_matrix[temp_source_venue_id][temp_destination_venue_id])
            temp_route = get_route(source_id: temp_source_venue_id, destination_id: temp_destination_venue_id)
            while temp_route.expectedTravelTime == 0 {
                print("wait",counter)
                counter += 1
                temp_route = get_route(source_id: temp_source_venue_id, destination_id: temp_destination_venue_id)
            }
            ordered_routes.append(temp_route)
            // ordered_routes.append(get_route(source_id: temp_source_venue_id, destination_id: temp_destination_venue_id))
        }
        
        // return (ordered_routes, cost_min) THESE ARE NOW GLOBAL VARIABLES
    }
    
    // THIS IS NOT READY BY ANY MEANS
    func find_time_of_day_route_perm() { // NO RETURN B/C IMPORTANT DATA GAINED ARE STORED IN GLOBAL VARS
        
        //var time_group_perms_dict = get_time_group_perms()
        let num_venues = venue_ids.count
        
        var source_id = -1
        var destination_id = -1
        var time_group_perms: [[Int]] = []
        
        // Calculate all time-relevant routes
        for time in all_time_group_perms.keys {
            time_group_perms = all_time_group_perms[time] ?? []
            for venue_id_perm in time_group_perms {
                for venue_id_spot in (0 ... num_venues - 2) {
                    source_id = venue_id_perm[venue_id_spot]
                    destination_id = venue_id_perm[venue_id_spot + 1]
                    calculate_route(source_id: source_id, destination_id: destination_id)
                }
            }
        }
        
        // Grab time-bucket perms
        var morning_perms = all_time_group_perms["Morning"]
        var afternoon_perms = all_time_group_perms["Afternoon"]
        var evening_perms = all_time_group_perms["Evening"]
        var curr_id_order: [Int] = []
        
        // Set up min-cost-calculating vars
        var curr_cost_sum = 0.0
        // var cost_min = Double.infinity // GLOBAL VAR NOW
        var optimal_venue_id_perm: [Int] = []
        
        // Loop through all possible combinations of morning, afternoon, and evening venue permutations
        for morn in morning_perms ?? [] {
            for after in afternoon_perms ?? [] {
                for even in evening_perms ?? [] {
                    curr_id_order += morn + after + even
                    
                    // Calculate cost of current route
                    for venue_id_spot in (0 ... curr_id_order.count - 2) {
                        source_id = curr_id_order[venue_id_spot]
                        destination_id = curr_id_order[venue_id_spot + 1]
                        curr_cost_sum += get_route_cost(source_id: source_id, destination_id: destination_id)
                    }
                    
                    // Replace optimal_venue_id_perm is a lower cost id order is found
                    if curr_cost_sum < cost_min {
                        optimal_venue_id_perm = curr_id_order
                        cost_min = curr_cost_sum
                    }
                    
                    // Reset variables to calcualte next iteration's route cost
                    curr_cost_sum = 0.0
                    curr_id_order = []
                    
                }
            }
        }
        
        // Stuff to turn order of venue_id into actual MKRoute objects
        // var ordered_routes = [MKRoute]() // // GLOBAL VAR NOW
        
        var temp_source_venue_id = -1
        var temp_destination_venue_id = -1
        
        print(optimal_venue_id_perm)
        var temp_route = MKRoute()
        for venue_index in (0 ... optimal_venue_id_perm.count - 2) {
            temp_source_venue_id = optimal_venue_id_perm[venue_index]
            temp_destination_venue_id = optimal_venue_id_perm[venue_index + 1]
            print(temp_source_venue_id, terminator: "")
            print(temp_destination_venue_id)
            //ordered_routes.append(route_matrix[temp_source_venue_id][temp_destination_venue_id])
            temp_route = get_route(source_id: temp_source_venue_id, destination_id: temp_destination_venue_id)
            while temp_route.expectedTravelTime == 0 {
                print("wait")
            }
            ordered_routes.append(temp_route)
            //ordered_routes.append(get_route(source_id: temp_source_venue_id, destination_id: temp_destination_venue_id))
        }
        
        // return (ordered_routes, cost_min) // GLOBAL VARS NOW
    }
    
}
