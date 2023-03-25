//
//  SelectVenuesCoordinator.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/14/23.
//

import Foundation
import UIKit
import MapKit

class SelectVenuesCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var categoryType: String
    let currentCoordinate =  CLLocationCoordinate2D(latitude: 29.9407, longitude: -90.1203)
    var venues: [Venue] = []
    
    init(navigationController: UINavigationController, categoryType: String) {
        self.navigationController = navigationController
        self.categoryType = categoryType
    }
    
    //Initializes view controller model and connects them.
    //Pushes the view controller to the top of the screen
    let storyboard = UIStoryboard.init(name: "SelectionUI", bundle: .main)
    
    func start() {
        let model: SelectVenuesModel = SelectVenuesModel()
        let viewController  = self.storyboard.instantiateViewController(withIdentifier: "SelectVenues") as! SelectVenuesViewController

        viewController.model = model
        viewController.coordinator = self
        model.viewController = viewController
        model.coordinator = self
        
        self.navigationController.pushViewController(viewController, animated: true)
        
    }
    //calls api and starts coordinator
    func yelpAPICall() {
        let latitude = currentCoordinate.latitude
        let longitude = currentCoordinate.longitude
        let category = categoryType
        let limit = 20
        let sortBy = "distance"
        let locale = "en_US"
        let yelpApi = YelpApi()
        yelpApi.retriveVenues(latitude: latitude, longitude: longitude, category: category, limit: limit, sortBy: sortBy, locale: locale) {
            (response, error) in
            if let response = response {
                DispatchQueue.main.async {
                self.venues = response
                    self.start()
                }
            }
        }
    }
    
    func goToMap() {
        let mapCoordinator = MapCoordinator(navigationController: navigationController)
        mapCoordinator.parentCoordinator = self
        children.append(mapCoordinator)
        mapCoordinator.start()
    }
    
    
}
