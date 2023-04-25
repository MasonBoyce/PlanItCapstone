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
    
    @IBAction func didTapSave(_ sender: UIButton) {
        let isPresentingInPushMode = presentingViewController is UINavigationController
        if isPresentingInPushMode {
            dismiss(animated: true, completion: nil)
        }
    }
    
    var model: SequenceModel?
    var coordinator: SequenceCoordinator?
    //retrive Veneus
    var data = [Venue] ()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data.count == 0 {
            return 1
        } else {
            return data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.startTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "startCell", for: indexPath)
            cell.textLabel?.textAlignment = .center
            if data.isEmpty == true {
                cell.textLabel?.text = "No Selected Venues"
                tableView.allowsSelection = false;
            } else {
                let celldata = data [indexPath.row]
                cell.textLabel?.text = celldata.name
                cell.accessoryType = .none
                cell.selectionStyle = .none
                if celldata.isStart {
                    cell.accessoryType = .checkmark
                }
            }
            return cell
        }

        if tableView == self.endTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "endCell", for: indexPath)
            cell.textLabel?.textAlignment = .center
            if data.isEmpty == true {
                cell.textLabel?.text = "No Selected Venues"
                tableView.allowsSelection = false;
            } else {
                let celldata = data [indexPath.row]
                cell.textLabel?.text = celldata.name
                cell.accessoryType = .none
                cell.selectionStyle = .none
                if celldata.isEnd {
                    cell.accessoryType = .checkmark
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.startTableView {
            //tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor(red: 0, green: 252, blue: 0, alpha: 0.1)
            tableView.cellForRow(at: indexPath)?.backgroundColor = .systemGray3
            UIView.animate(withDuration: 0.2, animations: {
                tableView.cellForRow(at: indexPath)?.backgroundColor = .secondarySystemGroupedBackground
            })
            //** TODO: Make it an resusable extension **//
            data[indexPath.row].isStart = !(data [indexPath.row].isStart)
            //        print ("That Sucks", data[indexPath.row].selected)
            if data[indexPath.row].isStart == true {
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            }
        }
        
        if tableView == self.endTableView {
            tableView.cellForRow(at: indexPath)?.backgroundColor = .systemGray3
            UIView.animate(withDuration: 0.2, animations: {
                tableView.cellForRow(at: indexPath)?.backgroundColor = .secondarySystemGroupedBackground
            })
            //** TODO: Make it an resusable extension **//
            data[indexPath.row].isEnd = !(data [indexPath.row].isEnd)
            //        print ("That Sucks", data[indexPath.row].selected)
            if data[indexPath.row].isEnd == true {
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            }
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
        if tableView == self.startTableView {
            tableView.cellForRow(at: indexPath)?.backgroundColor = .systemGray3
            UIView.animate(withDuration: 0.2, animations: {
                tableView.cellForRow(at: indexPath)?.backgroundColor = .secondarySystemGroupedBackground
            })
            data[indexPath.row].isStart = !(data [indexPath.row].isStart)
            //        print ("That Rocks", data[indexPath.row].selected)
            if data[indexPath.row].isStart == true {
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            }
        }

        if tableView == self.endTableView {
            tableView.cellForRow(at: indexPath)?.backgroundColor = .systemGray3
            UIView.animate(withDuration: 0.2, animations: {
                tableView.cellForRow(at: indexPath)?.backgroundColor = .secondarySystemGroupedBackground
            })
            data[indexPath.row].isEnd = !(data [indexPath.row].isEnd)
            //        print ("That Rocks", data[indexPath.row].selected)
            if data[indexPath.row].isEnd == true {
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            }
        }
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .checkmark{
                cell.accessoryType = .none
            }
            else{
                cell.accessoryType = .checkmark
            }
        }
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


