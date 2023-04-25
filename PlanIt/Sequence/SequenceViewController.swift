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
    
    @IBOutlet weak var startTableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var endTableView: UITableView!
    
    @IBAction func didTapSave(_ sender: Any) {
    }
    
    var model: SequenceModel?
    var coordinator: SequenceCoordinator?
    //retrive Veneus
    var data = [Venue] ()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.startTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "startCell", for: indexPath)
            let celldata = data [indexPath.row]
            cell.textLabel?.text = celldata.name
            return cell
        }

        if tableView == self.endTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "endCell", for: indexPath)
            let celldata = data [indexPath.row]
            cell.textLabel?.text = celldata.name
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor(red: 0, green: 252, blue: 0, alpha: 0.1)
        tableView.cellForRow(at: indexPath)?.backgroundColor = .systemGray3
        UIView.animate(withDuration: 0.2, animations: {
            tableView.cellForRow(at: indexPath)?.backgroundColor = .secondarySystemGroupedBackground
        })
        //** TODO: Make it an resusable extension **//
        data[indexPath.row].selected = !(data [indexPath.row].selected)
//        print ("That Sucks", data[indexPath.row].selected)
        if data[indexPath.row].selected == true {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        if data[indexPath.row].selected == false {
            print ("SELECTED", data[indexPath.row])
        }
        
        //** Change accesorytype to opposite instead of checking selection boolean **//
//        if let cell = tableView.cellForRow(at: indexPath) {
//            if cell.accessoryType == .checkmark{
//                cell.accessoryType = .none
//            }
//            else{
//                cell.accessoryType = .checkmark
//            }
//        }
    }
        
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor(red: 252, green: 0, blue: 0, alpha: 0.1)
        tableView.cellForRow(at: indexPath)?.backgroundColor = .systemGray3
        UIView.animate(withDuration: 0.2, animations: {
            tableView.cellForRow(at: indexPath)?.backgroundColor = .secondarySystemGroupedBackground
        })
        data[indexPath.row].selected = !(data [indexPath.row].selected)
//        print ("That Rocks", data[indexPath.row].selected)
        if data[indexPath.row].selected == true {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        if data[indexPath.row].selected == false {
            print ("DESELECTED", data[indexPath.row])
        }
//        if let cell = tableView.cellForRow(at: indexPath) {
//            if cell.accessoryType == .checkmark{
//                cell.accessoryType = .none
//            }
//            else{
//                cell.accessoryType = .checkmark
//            }
//        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemGray6
        super.viewDidLoad()
        data = Cache.shared.selectedVenues
        startTableView.delegate = self
        startTableView.dataSource = self
        endTableView.delegate = self
        endTableView.dataSource = self
    }
    
}


