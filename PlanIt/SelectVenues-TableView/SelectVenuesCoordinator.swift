//
//  SelectVenuesCoordinator.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/14/23.
//

import Foundation
import UIKit
import MapKit

var isAPICalled = false

class SelectVenuesCoordinator: SelectVenuesCoordinatorProtocol, Coordinator {    
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var categoryType: String
    var sViewController: SelectionUIViewController
    var currentCoordinate: CLLocationCoordinate2D {
        return LocationManager.shared.destinationLoaction ?? LocationManager.shared.currentLocation?.coordinate ??  CLLocationCoordinate2D(latitude: 29.9407, longitude: -90.1203)
    }
    var venues: [Venue] = []
    
    
    init(navigationController: UINavigationController, categoryType: String,sViewController: SelectionUIViewController) {
        self.navigationController = navigationController
        self.categoryType = categoryType
        self.sViewController = sViewController
        yelpAPICall()
    }
    
    //Initializes view controller model and connects them.
    //Pushes the view controller to the top of the screen
    func start() {
        
        let storyboard = UIStoryboard.init(name: "SelectionUI", bundle: .main)
        let model: SelectVenuesModel = SelectVenuesModel(venues: venues)
        let viewController  = storyboard.instantiateViewController(withIdentifier: "SelectVenues") as! SelectVenuesViewController
        
        viewController.model = model
        viewController.coordinator = self
        
        model.viewController = viewController
        viewController.sViewController = self.sViewController
        model.coordinator = self
        model.venues = self.venues
        
        //        navigationController.modalTransitionStyle = .crossDissolve
        //        self.navigationController.pushViewController(viewController, animated: true)
        
        //** Navigationcontroller needs to be wrapped to be presented modally **//
        let navcontroller = UINavigationController(rootViewController: viewController)
        self.navigationController.present(navcontroller, animated: true, completion: nil)
        navcontroller.isToolbarHidden = false
        navcontroller.isNavigationBarHidden = false
//        navcontroller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    }
    
    //passes back the data to the selectionpage
    func didFinish(venues newVenues: [Venue]) {
        Cache.shared.updateSelectedVenues(category: categoryType, newVenues: newVenues)
    }
    
    func didSave() {
        let storyboard = UIStoryboard.init(name: "SelectionUI", bundle: .main)
        let model: SelectVenuesModel = SelectVenuesModel(venues: venues)
        let viewController  = storyboard.instantiateViewController(withIdentifier: "SelectVenues") as! SelectVenuesViewController
        
        viewController.model = model
        viewController.coordinator = self
        
        model.viewController = viewController
        model.coordinator = self
        
        self.navigationController.dismiss(animated: true, completion: nil)
    }
    
    //calls api and starts coordinator
    func yelpAPICall() {
        let latitude = currentCoordinate.latitude
        let longitude = currentCoordinate.longitude
        let category = categoryType
        let limit = 50
        let sortBy = "distance"
        let locale = "en_US"
        let yelpApi = YelpApi.shared
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



