//
//  SelectionUIViewController.swift
//  PlanIt
//
//  Created by Michael on 2/8/23.
//

import Foundation
import UIKit

var nText: String?

class SelectionUIViewController: UIViewController, SelectionUIViewControllerProtocol {
    var model: SelectionModel?
    
    //* Catch Data passed from TableView*//
    var CheckedItem: String!
    
    @IBOutlet weak var SearchTextField: UITextField?
    @IBOutlet weak var SearchTextView: UITextView?
    //
    @IBAction func SearchButton(_ sender: UIButton) {
//** get text from text field **?//
//        let nText = SearchTextField?.text
        SearchTextView?.text = nText
//** DEBUGGING **//
//        print (nText)
//        print ("HI")
//        model?.yelpApiCall(categorytype: nText ?? "")
    }
    
    @IBAction func restaurants(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "restaurants")
//        self.present(SelectVenuesViewController(), animated: true)
//        performSegue(withIdentifier: "ShowTableview", sender: self)
    }
    
    @IBAction func cafés(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "cafes")
//        self.present(SelectVenuesViewController(), animated: true)
//        performSegue(withIdentifier: "ShowTableview", sender: self)
    }
    
    @IBAction func gyms(_ sender: UIButton) {
        model?.goToSelectVenues(categoryType: "gyms")
//        self.present(SelectVenuesViewController(), animated: true)
//        performSegue(withIdentifier: "ShowTableview", sender: self)
    }
    
    @IBAction func didTapMapButton(_ sender: UIButton) {
        model?.goToMap()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchTextField?.returnKeyType = .search
        SearchTextField?.autocorrectionType = .no
        SearchTextField?.borderStyle = .roundedRect
        SearchTextField?.textAlignment = .center
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        navigationItem.hidesBackButton = true
//        SearchTextView?.text = CheckedItem
        //                view.backgroundColor = .link
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    

}
