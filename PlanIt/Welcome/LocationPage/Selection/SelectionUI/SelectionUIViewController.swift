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
    //
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
        //        coordinator?.callAPI()
        //        self.present(SelectVenuesViewController(), animated: true)
        //        performSegue(withIdentifier: "ShowTableview", sender: self)
    }
    
    @IBAction func cafés(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "cafes")
        //        coordinator?.callAPI()
        //        self.present(SelectVenuesViewController(), animated: true)
        //        performSegue(withIdentifier: "ShowTableview", sender: self)
    }
    
    @IBAction func gyms(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "gyms")
        //        coordinator?.callAPI()
        //        self.present(SelectVenuesViewController(), animated: true)
        //        performSegue(withIdentifier: "ShowTableview", sender: self)
    }
    
    @IBAction func Desserts(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "desserts")
    }
        
    @IBAction func Bars(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "bars")
    }
    
    @IBAction func Pharmacy(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "pharmacy")
    }
    
    @IBAction func Parks(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "parks")
    }
    
    @IBAction func Museums(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "museums")
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
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
        navigationItem.hidesBackButton = true
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
