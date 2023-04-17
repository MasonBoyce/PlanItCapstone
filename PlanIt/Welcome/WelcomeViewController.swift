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
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var Planit: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    Planit.layer.shadowColor = UIColor.black.cgColor
    Planit.layer.shadowRadius = 8
    Planit.layer.shadowOpacity = 1
    Planit.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
    
    func setStatusBarBackgroundColor(color: UIColor) {
        
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        
        statusBar.backgroundColor = .white
    }
    
    
    
    @IBAction func didTapButton() {
        model?.doSomething()
        let generator = UIImpactFeedbackGenerator(style: .heavy)
                    generator.impactOccurred()
    }
    
}
