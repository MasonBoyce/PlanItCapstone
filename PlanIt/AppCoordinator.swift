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
        
        var venue_ex = Venue(name: "ex", id: "0", rating: 4, price: "$", is_closed: false, distance: 1.1, address: "2531 Palmer Ave.", latitude: 2.2, longitude: 3.3)
        
        var trip_ex = TripSession(newVenues: [venue_ex])
        
        
    }
    //Itilizes welcome as a child coordinator and go to it
    func goToWelcome() {
        let welcomeCoordinator = WelcomeCoordinator(navigationController: navigationController)
        welcomeCoordinator.parentCoordinator = self
        children.append(welcomeCoordinator)
        welcomeCoordinator.start()
        
    }
    
   
}
