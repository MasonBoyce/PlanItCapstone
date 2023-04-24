//
//  LocationPageViewController.swift
//  PlanIt
//
//  Created by Mason Boyce on 4/11/23.
//

import Foundation
import UIKit
import MapKit


class LocationPageViewController: UIViewController, UITextFieldDelegate {
    var model: LocationPageModel?
    var coordinator: LocationPageCoordinator?
    
    
    var selectedTravelType: MKDirectionsTransportType?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Where are you going?"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
//        label.textColor = .black
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter desired location..."
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        return textField
    }()
    
    let walkingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Walking", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.setImage (UIImage(systemName: "figure.walk.motion")?.withTintColor(.black,renderingMode: (.alwaysOriginal)), for: .normal)
        return button
    }()
    
    let transitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cycling", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.setImage (UIImage(systemName: "bicycle")?.withTintColor(.black,renderingMode: (.alwaysOriginal)), for: .normal)
        return button
    }()
    
    let drivingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Driving", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.setImage (UIImage(systemName: "car.fill")?.withTintColor(.black,renderingMode: (.alwaysOriginal)), for: .normal)
        return button
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
//        button.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
        button.backgroundColor = .systemBlue
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(goToSelection), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.delegate = self
        
        walkingButton.isSelected = true
        
        walkingButton.layer.shadowColor = UIColor.systemGray.cgColor
        walkingButton.layer.shadowRadius = 8
        walkingButton.layer.shadowOpacity = 1
        walkingButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        transitButton.layer.shadowColor = UIColor.systemGray.cgColor
        transitButton.layer.shadowRadius = 8
        transitButton.layer.shadowOpacity = 1
        transitButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        drivingButton.layer.shadowColor = UIColor.systemGray.cgColor
        drivingButton.layer.shadowRadius = 8
        drivingButton.layer.shadowOpacity = 1
        drivingButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        submitButton.layer.shadowColor = UIColor.systemGray.cgColor
        submitButton.layer.shadowRadius = 8
        submitButton.layer.shadowOpacity = 1
        submitButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        navigationItem.hidesBackButton = true
        
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(textField)
        view.addSubview(walkingButton)
        view.addSubview(transitButton)
        view.addSubview(drivingButton)
        view.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            walkingButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 100),
            walkingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            walkingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -20),
            walkingButton.heightAnchor.constraint(equalToConstant: 60),
            
            transitButton.topAnchor.constraint(equalTo: walkingButton.bottomAnchor, constant: 20),
            transitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            transitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            transitButton.heightAnchor.constraint(equalToConstant: 60),
            
            drivingButton.topAnchor.constraint(equalTo: transitButton.bottomAnchor, constant: 20),
            drivingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            drivingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            drivingButton.heightAnchor.constraint(equalToConstant: 60),
            
            
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        walkingButton.addTarget(self, action: #selector(selectTravelType(sender:)), for: .touchUpInside)
        transitButton.addTarget(self, action: #selector(selectTravelType(sender:)), for: .touchUpInside)
        drivingButton.addTarget(self, action: #selector(selectTravelType(sender:)), for: .touchUpInside)
    }
    
    @objc private func goToSelection() {
        
        
        if walkingButton.isSelected {
            model?.goToSelection(transitType: .walking)
        } else if transitButton.isSelected {
            model?.goToSelection(transitType: .transit)
        }else {
            model?.goToSelection(transitType: .automobile)
        }
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
    }
    
    @objc func selectTravelType(sender: UIButton) {
        
        
        if sender == walkingButton {
            selectedTravelType = .walking
            
            walkingButton.isSelected = true
            transitButton.isSelected = false
            drivingButton.isSelected = false
            
            walkingButton.backgroundColor = .systemGray
            transitButton.backgroundColor = .white
            drivingButton.backgroundColor = .white
            
        } else if sender == transitButton {
            selectedTravelType = .transit
            
            walkingButton.isSelected = false
            transitButton.isSelected = true
            drivingButton.isSelected = false
            
            walkingButton.backgroundColor = .white
            transitButton.backgroundColor = .systemGray
            drivingButton.backgroundColor = .white
            
        } else if sender == drivingButton {
            selectedTravelType = .automobile
            walkingButton.isSelected = false
            transitButton.isSelected = false
            drivingButton.isSelected = true
            
            walkingButton.backgroundColor = .white
            transitButton.backgroundColor = .white
            drivingButton.backgroundColor = .systemGray
        }
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Incomplete Address 🥺", message: "Please enter a valid Location", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "My Bad", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.error)
    }
    
    func proceed() {
        LocationManager.shared.destinationLoaction = LocationManager.shared.currentLocation?.coordinate
//        print ("WHERE THE FUCK", LocationManager.shared.destinationLoaction!)
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        coordinator?.goToSelection()
        print ("I AM HERE")
    }
    
    func LocationAlert() {
        let alertController = UIAlertController(title: "Location not recognized", message: "Do you want to proceed with your current location?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let proceedAction = UIAlertAction(title: "Use current Location", style: .default, handler:  {(alert: UIAlertAction!) in self.proceed()})
        alertController.addAction(proceedAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.error)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
