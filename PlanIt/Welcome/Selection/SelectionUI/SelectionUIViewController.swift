//
//  SelectionUIViewController.swift
//  PlanIt
//
//  Created by Michael on 2/8/23.
//

import Foundation
import UIKit

class SelectionUIViewController: UIViewController, SelectionViewControllerProtocol {
    
    //class WelcomeViewController: UIViewController, WelcomeViewControllerProtocol {
    var model: SelectionModel?
    
    
    @IBOutlet weak var SearchTextField: UITextField?
    @IBOutlet weak var SearchTextView: UITextView?
//    
    @IBAction func SearchButton(_ sender: UIButton) {
        //get text from text field
        let mText = SearchTextField?.text
        SearchTextView?.text = mText
    }
    
    @IBAction func didTapMapButton(_ sender: UIButton) {
        goToSelctVenues()
    }

    func goToSelctVenues() {
        // Code to navigate to the map screen goes here
        model?.goToSelctVenues()
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
            SearchTextField?.returnKeyType = .done
            SearchTextField?.autocorrectionType = .no
//                view.backgroundColor = .link
    }
}
