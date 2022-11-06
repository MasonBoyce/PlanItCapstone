//
//  WelcomeViewController.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/2/22.
//

import Foundation
import UIKit

class WelcomeViewController: UIViewController, WelcomeViewControllerProtocol {
    var model: WelcomeModelProtocol?
    
    lazy var viewContainter: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "WELCOME TO PLANIT"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var button: UIButton =  {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Click Button", for: .normal)
        button.addTarget(self, action: #selector(doSomething), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .red
        setUpView()
        super.viewDidLoad()
    }
    
    @objc func doSomething() {
        model?.doSomething(button: button)
    }
   
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
   
    func setUpView() {
        view.addSubview(viewContainter)
        viewContainter.addSubview(welcomeLabel)
        viewContainter.addSubview(button)
        
        viewContainter.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        viewContainter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        viewContainter.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10).isActive = true
        viewContainter.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -100).isActive = true

        welcomeLabel.topAnchor.constraint(equalTo: viewContainter.topAnchor, constant: 10).isActive  =  true
        welcomeLabel.centerXAnchor.constraint(equalTo: viewContainter.centerXAnchor).isActive = true
        welcomeLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true

        button.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor,constant: -20).isActive = true
        button.centerXAnchor.constraint(equalTo: welcomeLabel.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    

}
