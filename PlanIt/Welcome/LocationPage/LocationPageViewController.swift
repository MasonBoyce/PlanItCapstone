//
//  LocationPageViewController.swift
//  PlanIt
//
//  Created by Mason Boyce on 4/11/23.
//

import Foundation
import UIKit
import MapKit


class LocationPageViewController: UIViewController {
    var model: LocationPageModel?
    
    
    var selectedTravelType: MKDirectionsTransportType?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choose Vacation Location"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter location"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let walkingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Walking", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }()
    
    let transitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Transit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }()
    
    let drivingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Driving", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(goToSelection), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        walkingButton.isSelected = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        view.backgroundColor = .white
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
        
    }
    
    @objc func selectTravelType(sender: UIButton) {
        
        
        if sender == walkingButton {
            selectedTravelType = .walking
            
            walkingButton.isSelected = true
            transitButton.isSelected = false
            drivingButton.isSelected = false
            
            walkingButton.backgroundColor = .black
            transitButton.backgroundColor = .white
            drivingButton.backgroundColor = .white
            
        } else if sender == transitButton {
            selectedTravelType = .transit
            
            walkingButton.isSelected = false
            transitButton.isSelected = true
            drivingButton.isSelected = false
            
            walkingButton.backgroundColor = .white
            transitButton.backgroundColor = .black
            drivingButton.backgroundColor = .white
            
        } else if sender == drivingButton {
            selectedTravelType = .automobile
            walkingButton.isSelected = false
            transitButton.isSelected = false
            drivingButton.isSelected = true
            
            walkingButton.backgroundColor = .white
            transitButton.backgroundColor = .white
            drivingButton.backgroundColor = .black
        }
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Incomplete", message: "Enter in a location please.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
