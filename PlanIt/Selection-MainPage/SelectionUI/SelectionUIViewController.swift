//
//  SelectionUIViewController.swift
//  PlanIt
//
//  Created by Michael on 2/8/23.
//

import Foundation
import UIKit

var nText: String?

class SelectionUIViewController: UIViewController, SelectionUIViewControllerProtocol, UITextFieldDelegate, UIGestureRecognizerDelegate {
    var model: SelectionModel?
    var coordinator: SelectVenuesCoordinator?
    var viewcontroller: SelectVenuesViewController?
    
    //* Catch Data passed from TableView*//
    var CheckedItem: String!
    
    @IBOutlet weak var SearchTextField: UITextField?
    @IBOutlet weak var SearchTextView: UITextView?
    @IBOutlet weak var Planit: UIButton!
    @IBOutlet weak var Categories: UILabel!
    @IBOutlet weak var Restaurant: UIButton!
    @IBOutlet weak var Café: UIButton!
    @IBOutlet weak var Gym: UIButton!
    @IBOutlet weak var Dessert: UIButton!
    @IBOutlet weak var Pharmacy: UIButton!
    @IBOutlet weak var Bar: UIButton!
    @IBOutlet weak var Park: UIButton!
    @IBOutlet weak var Museum: UIButton!
    @IBOutlet weak var More: UIButton!
    
    @IBAction func SearchButton(_ sender: UIButton) {
        //** get text from text field **?//
        let nText = SearchTextField?.text
        SearchTextView?.text = nText
        //** DEBUGGING **//
        //        print (nText)
        //        print ("HI")
        //        model?.yelpApiCall(categorytype: nText ?? "")
    }
    
    @IBAction func restaurants(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "restaurants")
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
        //        coordinator?.callAPI()
        //        self.present(SelectVenuesViewController(), animated: true)
        //        performSegue(withIdentifier: "ShowTableview", sender: self)
    }
    
    @IBAction func cafés(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "cafes")
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
    }
    
    @IBAction func gyms(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "gyms")
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
    }
    
    @IBAction func Desserts(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "desserts")
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
    }
        
    @IBAction func Bars(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "bars")
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
    }
    
    @IBAction func Pharmacy(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "pharmacy")
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
    }
    
    @IBAction func Parks(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "parks")
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
    }
    
    @IBAction func Museums(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "museums")
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
    }
    
    
    @IBAction func didTapMapButton(_ sender: UIButton) {
        if selectedVenues.isEmpty == true {
            viewcontroller?.showAlert()
        } else {
            model?.goToMap()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchTextField?.returnKeyType = .search
        SearchTextField?.autocorrectionType = .no
        SearchTextField?.borderStyle = .roundedRect
        SearchTextField?.textAlignment = .center
        self.SearchTextField?.delegate = self
        
        //** PLANIT BUTTON SHADOW **//
        Planit.layer.shadowColor = UIColor.systemBlue.cgColor
        Planit.layer.shadowRadius = 8
        Planit.layer.shadowOpacity = 1
        Planit.layer.shadowOffset = CGSize(width: 0, height: 1)
//        Categories.layer.shadowColor = UIColor.systemGray.cgColor
//        Categories.layer.shadowRadius = 2
//        Categories.layer.shadowOpacity = 0.8
//        Categories.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        Restaurant.layer.shadowColor = UIColor.systemGray.cgColor
        Restaurant.layer.shadowRadius = 3
        Restaurant.layer.shadowOpacity = 1
        Restaurant.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        Café.layer.shadowColor = UIColor.systemGray.cgColor
        Café.layer.shadowRadius = 3
        Café.layer.shadowOpacity = 1
        Café.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        Gym.layer.shadowColor = UIColor.systemGray.cgColor
        Gym.layer.shadowRadius = 3
        Gym.layer.shadowOpacity = 1
        Gym.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        Dessert.layer.shadowColor = UIColor.systemGray.cgColor
        Dessert.layer.shadowRadius = 3
        Dessert.layer.shadowOpacity = 1
        Dessert.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        Pharmacy.layer.shadowColor = UIColor.systemGray.cgColor
        Pharmacy.layer.shadowRadius = 3
        Pharmacy.layer.shadowOpacity = 1
        Pharmacy.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        Bar.layer.shadowColor = UIColor.systemGray.cgColor
        Bar.layer.shadowRadius = 3
        Bar.layer.shadowOpacity = 1
        Bar.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        Park.layer.shadowColor = UIColor.systemGray.cgColor
        Park.layer.shadowRadius = 3
        Park.layer.shadowOpacity = 1
        Park.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        Museum.layer.shadowColor = UIColor.systemGray.cgColor
        Museum.layer.shadowRadius = 3
        Museum.layer.shadowOpacity = 1
        Museum.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        More.layer.shadowColor = UIColor.systemGray.cgColor
        More.layer.shadowRadius = 3
        More.layer.shadowOpacity = 1
        More.layer.shadowOffset = CGSize(width: 2, height: 2)
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
//        navigationItem.hidesBackButton = true
        //        SearchTextView?.text = CheckedItem
        //                view.backgroundColor = .link
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        SearchTextField!.resignFirstResponder()
        performAction()
        return true
    }
    
    func performAction() {
        //action events
        let nText = SearchTextField?.text
        SearchTextView?.text = nText
    }
    
//    @objc func dismissKeyboard() {
//        //Causes the view (or one of its embedded text fields) to resign the first responder status.
//        view.endEditing(true)
//    }
    
    
}
