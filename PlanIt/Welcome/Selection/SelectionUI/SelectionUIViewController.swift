//
//  SelectionUIViewController.swift
//  PlanIt
//
//  Created by Michael on 2/8/23.
//

import Foundation
import UIKit

class SelectionUIViewController: UIViewController {
    
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
        goToMap()
    }

    func goToMap() {
        // Code to navigate to the map screen goes here
        model?.goToMap()
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
            SearchTextField?.returnKeyType = .done
            SearchTextField?.autocorrectionType = .no
//                view.backgroundColor = .link
    }
}
