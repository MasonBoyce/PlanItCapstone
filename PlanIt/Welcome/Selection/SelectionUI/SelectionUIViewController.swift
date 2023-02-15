//
//  SelectionUIViewController.swift
//  PlanIt
//
//  Created by Michael on 2/8/23.
//

import Foundation
import UIKit


//var result: String?

class SelectionUIViewController: UIViewController {
    
    //class WelcomeViewController: UIViewController, WelcomeViewControllerProtocol {
    var model: SelectionModel?
    
    
    @IBOutlet weak var SearchTextField: UITextField?
    @IBOutlet weak var SearchTextView: UITextView?
    //
    @IBAction func SearchButton(_ sender: UIButton) {
        //get text from text field
        let nText = SearchTextField?.text
        SearchTextView?.text = nText
        model?.yelpApiCall(categorytype: nText ?? "")
//        result = nText
        
    }
    
    @IBAction func restaurants(_ sender: UIButton) {
    }
    
    @IBAction func cafés(_ sender: UIButton) {
    }
    
    @IBAction func gyms(_ sender: UIButton) {
    }
    
    
    @IBAction func didTapMapButton(_ sender: UIButton) {
        goToMap()
    }
    
    
    func goToMap() {
        // Code to navigate to the map screen goes here
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
        //                view.backgroundColor = .link
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    

}
