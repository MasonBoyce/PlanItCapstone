//
//  SequenceViewController.swift
//  PlanIt
//
//  Created by Michael on 4/24/23.
//

import Foundation
import Foundation
import UIKit
import MapKit

class SequenceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var model: SequenceModel?
    var coordinator: SequenceCoordinator?
    var timedata = [Double] ()
    //retrive Veneus
    var resultdata = [Venue] ()
    var routedata = [MKRoute] ()
    var transitdata = MKDirectionsTransportType ()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        return cell
    }
    
    override func viewDidLoad() {
        //        view.backgroundColor = .link
        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
    }
    
}


