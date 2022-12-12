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
        coordinator?.goToMap()
        
//        let controller = instantiateViewController(identifier: "MapViewController") as MapViewController
//        self.present(controller, animated: true, completion: nil)
                    
//        guard let vc = storyboard?.instantiateViewController(identifier: "MapView") as? MapViewController
//        else print ("failed to get vc from storyboard")
//        return
//    }
    
//        present(vc, animated: true)
        
    }
    
//    view.layer.shadowColor = UIColor.black.cgColor
//    view.layer.shadowOpacity = 0.2
//    view.layer.shadowOffset = CGSize(width: 4, height: 4)
//    view.layer.shadowRadius = 5.0
//
//    // Set masksToBounds to false, otherwise the shadow
//    // will be clipped and will not appear outside of
//    // the view’s frame
//    view.layer.masksToBounds = false
//
//    @IBDesignable extension UIView {
//        @IBInspectable var shadowRadius: CGFloat {
//            get { return layer.shadowRadius }
//            set { layer.shadowRadius = newValue }
//        }
//
//        @IBInspectable var shadowOpacity: CGFloat {
//            get { return CGFloat(layer.shadowOpacity) }
//            set { layer.shadowOpacity = Float(newValue) }
//        }
//
//        @IBInspectable var shadowOffset: CGSize {
//            get { return layer.shadowOffset }
//            set { layer.shadowOffset = newValue }
//        }
//
//        @IBInspectable var shadowColor: UIColor? {
//            get {
//                guard let cgColor = layer.shadowColor else {
//                    return nil
//                }
//                return UIColor(cgColor: cgColor)
//            }
//            set { layer.shadowColor = newValue?.cgColor }
//        }
//    }
//
//    //MARK: View Elements
//    lazy var viewContainter: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .white
//        return view
//    }()
//
//    lazy var welcomeLabel: UILabel = {
//        let label = UILabel()
//        label.text = "WELCOME TO PLANIT"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    lazy var button: UIButton =  {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Login with Apple", for: .normal)
//        button.addTarget(self, action: #selector(doSomething), for: .touchUpInside)
//        button.layer.cornerRadius = button.bounds.size.height/2
//        button.backgroundColor = .black
//        return button
//    }()
//
////    struct SignInWithAppleButton {
////        init(SignInWithAppleButton.Label, onRequest: (ASAuthorizationAppleIDRequest) -> Void, onCompletion: ((Result<ASAuthorization, Error>) -> Void))}
////
////    struct SignInWithAppleButton.Style{
////
////    }
//
//    //MARK: Functions
//    override func viewDidLoad() {
//        view.backgroundColor = .black
////        view.backgroundImage: UIImage = (UIImage(named: "hello"))!
//        setUpView()
//        super.viewDidLoad()
//    }
//
//    @objc func doSomething() {
//        model?.doSomething(button: button)
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    init() {
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    func setUpView() {
//        view.addSubview(viewContainter)
//        viewContainter.addSubview(welcomeLabel)
//        viewContainter.addSubview(button)
//
//        viewContainter.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
//        viewContainter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
//        viewContainter.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10).isActive = true
//        viewContainter.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 0).isActive = true
//
//        welcomeLabel.topAnchor.constraint(equalTo: viewContainter.topAnchor, constant: 10).isActive  =  true
//        welcomeLabel.centerXAnchor.constraint(equalTo: viewContainter.centerXAnchor).isActive = true
//        welcomeLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
//
//        button.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor,constant: 100).isActive = true
//        button.centerXAnchor.constraint(equalTo: welcomeLabel.centerXAnchor).isActive = true
//        button.bottomAnchor.constraint(equalTo: viewContainter.bottomAnchor,constant: -100).isActive = true
//    }
}
