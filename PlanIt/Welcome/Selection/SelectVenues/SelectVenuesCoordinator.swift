//
//  SelectVenuesCoordinator.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/14/23.
//

import Foundation
import UIKit
import MapKit

class SelectVenuesCoordinator: SelectVenuesCoordinatorProtocol, Coordinator {
    
    
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var categoryType: String
    let currentCoordinate =  CLLocationCoordinate2D(latitude: 29.9407, longitude: -90.1203)
    var venues: [Venue] = []
    weak var delegate: SelectionDelegateProtocol?
    
    init(navigationController: UINavigationController, categoryType: String, delegate: SelectionDelegateProtocol) {
        self.navigationController = navigationController
        self.categoryType = categoryType
        self.delegate = delegate
    }
   
    
    //Initializes view controller model and connects them.
    //Pushes the view controller to the top of the screen
    func start() {
        let storyboard = UIStoryboard.init(name: "SelectionUI", bundle: .main)
        let model: SelectVenuesModel = SelectVenuesModel()
        let viewController  = storyboard.instantiateViewController(withIdentifier: "SelectVenues") as! SelectVenuesViewController
        
        viewController.model = model
        viewController.coordinator = self
        
        model.viewController = viewController
        model.coordinator = self
        model.venues = self.venues
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func didFinish(venues: [Venue]) {
        delegate?.didFinish(venues: venues)
    }
    
    //calls api and starts coordinator
    func yelpAPICall() {
        let latitude = currentCoordinate.latitude
        let longitude = currentCoordinate.longitude
        let category = categoryType
        let limit = 5
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
    
    
    
}
