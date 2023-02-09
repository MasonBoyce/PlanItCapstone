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
//    var model: WelcomeModelProtocol?
//    var coordinator: WelcomeCoordinatorProtocol?
    
    @IBOutlet weak var SearchTextField: UITextField!
    @IBOutlet weak var SearchTextView: UITextView!
//    
    @IBAction func SearchButton(_ sender: UIButton) {
        //get text from text field
        let mText = SearchTextField.text
        SearchTextView.text = mText
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
            SearchTextField.returnKeyType = .done
            SearchTextField.autocorrectionType = .no
//                view.backgroundColor = .link
    }
}
