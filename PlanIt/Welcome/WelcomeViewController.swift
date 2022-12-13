//
//  WelcomeViewController.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/2/22.
//

import Foundation
import UIKit
import MapKit

class WelcomeViewController: UIViewController {
//class WelcomeViewController: UIViewController, WelcomeViewControllerProtocol {
    var model: WelcomeModelProtocol?
    var coordinator: WelcomeCoordinatorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .link
    }
    
    
    @IBAction func didTapButton() {
        model?.doSomething()
    }
    

}
