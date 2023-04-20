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
//    var coordinator: SelectVenuesCoordinator?
//    var viewcontroller: SelectVenuesViewController?
    var buttonTitles = [String] ()
    var searchResults = [String] ()
    
    //* Catch Data passed from TableView*//
    var CheckedItem: String!
    
    @IBOutlet weak var SearchTextField: UITextField?
//    @IBOutlet weak var SearchTextView: UITextView?
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
    @IBOutlet weak var Bookstore: UIButton!
    
    //MARK: - Search Handler.
    @IBAction func searchHandler(_ sender: UITextField!) {
//        if let searchText = sender.text {
//            searchResults = buttonTitles.filter{$0.lowercased().contains(searchText.lowercased())}
//            let nText = buttonTitles.joined(separator:"-")
//            SearchTextView?.text = nText
//        }
//        let nText = sender.text
//        SearchTextView?.text = nText
//        print("WHAT THE FUCK", buttonTitles)
    }
    
    @IBAction func SearchButton(_ sender: UIButton) {
        if (SearchTextField!.text!.isEmpty == false) {
            model?.goToSelectVenues(categoryType: SearchTextField!.text ?? "")
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
        } else {
            self.categoryAlert()
        }
        //** get text from text field **?//
//        let nText = SearchTextField?.text
//        SearchTextView?.text = nText
        //** DEBUGGING **//
        //        print (nText)
        //        print ("HI")
        //        model?.yelpApiCall(categorytype: nText ?? "")
    }
    
    @IBAction func restaurants(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "restaurants")
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
        //add to array upon button click//
        buttonTitles.insert(sender.title(for: .normal)!, at: 0)
        //        coordinator?.callAPI()
        //        self.present(SelectVenuesViewController(), animated: true)
        //        performSegue(withIdentifier: "ShowTableview", sender: self)
    }
    
    @IBAction func cafés(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "cafes")
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
        buttonTitles.insert(sender.title(for: .normal)!, at: 0)
    }
    
    @IBAction func gyms(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "gyms")
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
        buttonTitles.insert(sender.title(for: .normal)!, at: 0)
    }
    
    @IBAction func Desserts(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "desserts")
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
        buttonTitles.insert(sender.title(for: .normal)!, at: 0)
    }
        
    @IBAction func Bars(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "bars")
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
        buttonTitles.insert(sender.title(for: .normal)!, at: 0)
    }
    
    @IBAction func Pharmacies(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "pharmacy")
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
        buttonTitles.insert(sender.title(for: .normal)!, at: 0)
    }
    
    @IBAction func Parks(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "parks")
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
        buttonTitles.insert(sender.title(for: .normal)!, at: 0)
    }
    
    @IBAction func Museums(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "museums")
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
        buttonTitles.insert(sender.title(for: .normal)!, at: 0)
    }
    
    @IBAction func Bookstores (_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "bookstores")
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
        buttonTitles.insert(sender.title(for: .normal)!, at: 0)
    }
    
    
    @IBAction func didTapMapButton(_ sender: UIButton) {
        if selectedVenues.isEmpty{
            self.showAlert()
        }
        else if selectedVenues.count > 8 {
            self.venueMaxAlert()
        }
        else if selectedVenues.count <= 2 && selectedVenues.count > 0 {
            self.venueMinAlert()
        }
        else {
            model?.calculateIdealRoute()
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
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
        
        Bookstore.layer.shadowColor = UIColor.systemGray.cgColor
        Bookstore.layer.shadowRadius = 3
        Bookstore.layer.shadowOpacity = 1
        Bookstore.layer.shadowOffset = CGSize(width: 2, height: 2)
        
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
//        let nText = SearchTextField?.text
//        SearchTextView?.text = nText
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "No Venues", message: "Please select at least one venue to calculate", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.error)
    }
    
    func categoryAlert() {
        let alertController = UIAlertController(title: "Empty search", message: "Please enter desired catgory to continue", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.error)
    }
    
    func venueMaxAlert() {
        let alertController = UIAlertController(title: "Error", message: "Please enter less than 7 veneus", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.error)
    }
    
    func proceed() {
        model?.calculateIdealRoute()
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func venueMinAlert() {
        let alertController = UIAlertController(title: "Less Than Three Venues Selected", message: "You have only selected two or less veneue. Still want to Proceed?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let proceedAction = UIAlertAction(title: "Proceed", style: .default, handler:  {(alert: UIAlertAction!) in self.proceed()})
        alertController.addAction(cancelAction)
        alertController.addAction(proceedAction)
        present(alertController, animated: true, completion: nil)
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.error)
    }
    
//    @objc func dismissKeyboard() {
//        //Causes the view (or one of its embedded text fields) to resign the first responder status.
//        view.endEditing(true)
//    }
    
    
}
