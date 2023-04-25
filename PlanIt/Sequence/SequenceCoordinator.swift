//
//  SequenceCoordinator.swift
//  PlanIt
//
//  Created by Michael on 4/24/23.
//

import Foundation
import UIKit

//Coordinator for the Welcome Page
class SequenceCoordinator: Coordinator{
    
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    
    func start() {
        loadSequence()
    }
    
    func loadSequence(){
        let SequenceViewController  = storyboard.instantiateViewController(withIdentifier: "Sequence") as! SequenceViewController
        let model = SequenceModel()
        SequenceViewController.model = model
        model.viewController  = SequenceViewController
        model.coordinator = self
        
        let navcontroller = UINavigationController(rootViewController: SequenceViewController)
        self.navigationController.present(navcontroller, animated: true, completion: nil)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    let storyboard = UIStoryboard.init(name: "Sequence", bundle: .main)
    
}

