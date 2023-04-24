//
//  ResultCoordinator.swift
//  PlanIt
//
//  Created by Michael on 4/19/23.
//

import Foundation
import UIKit

//Coordinator for the Welcome Page
class ResultCoordinator: Coordinator{
    
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var tripSession: TripSession
    
    func start() {
        loadResult()
    }
    
    func loadResult(){
        let ResultViewController  = storyboard.instantiateViewController(withIdentifier: "Result") as! ResultViewController
        let model = ResultModel(tripSession: tripSession)
        ResultViewController.model = model
        model.viewController  = ResultViewController
        model.coordinator = self
        
        navigationController.pushViewController(ResultViewController , animated: true)
    }
    
    init(navigationController: UINavigationController, tripSession: TripSession) {
        self.navigationController = navigationController
        self.tripSession = tripSession
    }
    
    let storyboard = UIStoryboard.init(name: "Result", bundle: .main)
    
}
