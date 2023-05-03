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
import Screenshots

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ResultTableViewCellDelegate {
    
    
    @IBOutlet weak var screenshot: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var model: ResultModel?
    var coordinator: ResultCoordinator?
    var timedata = [Double] ()
    //retrive Veneus
    var resultdata = [Venue] ()
    var routedata = [MKRoute] ()
    var transitdata = MKDirectionsTransportType ()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as! ResultTableViewCell
        let celldata = resultdata [indexPath.row]
        let celltimedata = timedata [indexPath.row]
        let finaldata = round (1 * celltimedata / 60) / 1
        //        var traveldata = routedata [indexPath.row]
        cell.delegate = self
        cell.NameLabel.text = celldata.name
        if transitdata == .walking {
            if String(Int(finaldata)) == "0" || String(Int(finaldata)) == "1" {
                cell.TravelLabel.text = "🚶" + " ↓ " + String(Int(finaldata)) + " min"
            } else{
                cell.TravelLabel.text = "🚶" + " ↓ " + String(Int(finaldata)) + " mins"
            }
        } else if transitdata == .transit {
            if String(Int(finaldata)) == "0" || String(Int(finaldata)) == "1" {
                cell.TravelLabel.text = "🚶" + " ↓ " + String(Int(finaldata)) + " min"
            } else {
                cell.TravelLabel.text = "🚲" + " ↓ " + String(Int(finaldata)) + " mins"
            }
        } else {
            if String(Int(finaldata)) == "0" || String(Int(finaldata)) == "1" {
                cell.TravelLabel.text = "🚶" + " ↓ " + String(Int(finaldata)) + " min"
            } else {
                cell.TravelLabel.text = "🚗" + " ↓ " + String(Int(finaldata)) + " mins"
            }
        }
        if tableView.isLast(for: indexPath) {
            cell.TravelLabel.text = ""
        }
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
        //        tableView.contentInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0);
        resultdata = model?.tripSession.optimal_venue_order ?? []
        routedata = model?.tripSession.ordered_routes ?? []
        for route in model!.tripSession.ordered_routes {
            timedata.insert(route.expectedTravelTime, at: 0)
        }
        timedata.append(0)
        transitdata = Cache.shared.transitType!
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let tableViewHeight = self.tableView.frame.height
        let contentHeight = self.tableView.contentSize.height
        
        let centeringInset = (tableViewHeight - contentHeight) / 2.0
        let topInset = max(centeringInset, 0.0)
        
        self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    @IBAction func screenshot(_ sender: Any) {
        //Create the UIImage
        self.screenshot.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        
//        tableView.contentOffset = CGPointMake(0.0, 0.0)
//        tableView.frame = CGRectMake(0, 0.0, tableView.contentSize.width, tableView.contentSize.height)
//        guard let layer = tableView?.layer else { return }

//        guard let layer = UIApplication.shared.keyWindow?.layer else { return }
//        let renderer = UIGraphicsImageRenderer(size: layer.frame.size)
//        let image = renderer.image(actions: { context in
//            layer.render(in: context.cgContext)
//        })
        
        let image = tableView.screenshot
        self.screenshot.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        
        //Save it to the camera roll
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
    
    extension UITableView {
        func isLast(for indexPath: IndexPath) -> Bool {
            
            let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
            let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1
            
            return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
        }
    }
