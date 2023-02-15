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
    
    func setStatusBarBackgroundColor(color: UIColor) {

        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }

        statusBar.backgroundColor = .white
    }
    
    
    
    @IBAction func didTapButton() {
        model?.doSomething()
    }
    

}
