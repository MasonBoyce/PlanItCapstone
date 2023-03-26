//
//  AppCordinator.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/4/22.
//

import Foundation
import UIKit

//The initial AppCordinator
class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navCon : UINavigationController) {
        self.navigationController = navCon
    }
    
    func start() {
        goToWelcome()
        
    }
    //Itilizes welcome as a child coordinator and go to it
    func goToWelcome() {
        let welcomeCoordinator = WelcomeCoordinator(navigationController: navigationController)
        welcomeCoordinator.parentCoordinator = self
        children.append(welcomeCoordinator)
        welcomeCoordinator.start()
        
        var venues = testTripSessionHardCoded(numVenues: 10)
        var session = TripSession(newVenues: venues)
        print("ALL")
        print(session.all_venue_permutations)
        print("TIME GROUPS")
        print(session.time_groups)
        print("ALL TIMED PERMS")
        session.set_timed_permutations()
        print(session.all_time_group_perms)
        
    }
    
    func testTripSessionHardCoded(numVenues: Int) -> [Venue]{
        var venues = [Venue]()
        var time = ["Morning","Afternoon","Evening","Any"]
        for index in (0...numVenues){
            var venue: Venue = Venue()
            venue.name = "Venue " + String(index)
            venue.yelpID = String(index) + String(index) + String(index) + "venue" + String(index) + String(index) + String(index)
            venue.internalID = index
            venue.rating = Float(index) + (Float(index) * 0.1)
            venue.price = "$"
            venue.is_closed = false
            venue.distance = Double(index) + (Double(index) * 0.1)
            venue.address = String(index) + String(index) + String(index) + String(index) + " Tulane St."
            venue.longitude = Double(index) + (Double(index) * 0.1)
            venue.latitude = Double(index) + (Double(index) * 0.1)
            venue.time_of_day = time[index % 4]
            venues.append(venue)
        }
        
        print(venues)
        return venues
    }
    
   
}
