//
//  ResultViewController.swift
//  PlanIt
//
//  Created by Michael on 4/21/23.
//

import Foundation
import Foundation
import UIKit
import MapKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ResultTableViewCellDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var model: ResultModel?
    var coordinator: ResultCoordinator?
    //retrive Veneus
    var resultdata = [Venue]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as! ResultTableViewCell
        cell.delegate = self
        return cell
    }
    
    
    @IBOutlet weak var Venue1: UILabel?
    @IBOutlet weak var Venue2: UILabel?
    @IBOutlet weak var Venue3: UILabel?
    
    @IBOutlet weak var t1: UILabel?
    @IBOutlet weak var t2: UILabel?
    
    override func viewDidLoad() {
//        view.backgroundColor = .link
        super.viewDidLoad()
        let nib = UINib(nibName: "ResultTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ResultTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}
