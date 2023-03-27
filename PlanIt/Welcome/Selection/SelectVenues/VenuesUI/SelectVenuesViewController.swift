//
//  SelectVenuesViewController.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/14/23.
//

import Foundation
import UIKit

//** Dummy without tableview for Debugging **//

//class SelectVenuesViewController: UIViewController {
//    var model: SelectVenuesModel?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        tableView.delegate = self
////        tableView.dataSource = self
//        view.backgroundColor = .red
//    }
//}

//** OPTIONAL ANIMATION TUTORIAL ADOPTED FROM https://medium.com/@shubham_iosdev/animate-the-boring-tableviews-in-your-ios-app-a98bc6dee3e9 **//
//** ANIMATION CODE ENDS HERE **//


class SelectVenuesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SelectVenuesViewControllerProtocol, RestaurantTableViewCellDelegate {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
//** If connected to UInvaigationController, Dismiss (nestedview); If not, POP (swipeback)**//
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem){
        let isPresentingInPushMode = presentingViewController is UINavigationController
        if isPresentingInPushMode {
            dismiss(animated: true, completion: nil)
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    var model: SelectVenuesModel?
    var coordinator: SelectVenuesCoordinator?
//retrive Veneus
    var data = [Venue]()
    var selecteddata : [Venue] = []
//    var data: Array <String>?
    
//    init model?.venues{
//        self.fetchVenues = fetchVenues
//    }
    
//    func runyelpapi(){
//        model?.yelpApiCall(categoryType:"restaurants")
//    }
    
    @IBOutlet var tableView: UITableView!
//    func fetchVenues(parent:SelectVenuesModel){
//        let data = parent.venues
//        print (data)
//    }
//    let data = venues.name
//    let data = ["","S","T"]
//    struct ListItems {
//        let title: String
//    }
//
//    func getvenues (result: String?) {
//        for i in model?.venues ?? [] {
//            let result? = model?.venues [i]
//        }
//    }
    
//    func converttostring(parent:SelectVenuesModel){
//        var array = parent.venues
//        let result = parent.venues[Venue].joined(separator: "-")
//        }

    
    
    //Required TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let Venues = data[indexPath.row]
        let restaurants = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        let restaurant = data [indexPath.row]
        restaurants.delegate = self
        restaurants.myLabel?.text = restaurant.name
        restaurants.priceLabel?.text = restaurant.price
//        restaurants.myButton?.isSelected = restaurant.selected ?? false
        restaurants.selectionStyle = .none
//        let restaurants = table.dequeueReusableCell(withIdentifier: "restaurants", for: indexPath) as! CustomTableViewCell
//        restaurants.textLabel?.text = data[indexPath.row]
        
/*switch*/
//        let mySwitch = UISwitch()
//** Defaults turning on **//
//mySwitch.isOn = true
//        mySwitch.addTarget(self, action: #selector(didChangeSwitch(_:)), for: .valueChanged)
//        restaurants.accessoryView = mySwitch
        
        return restaurants
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
         return "Ignore"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
//    func test(){
//        print ([Venue].self())
//        print("Hi")
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.isSelected {
                data[indexPath.row].selected = !(data [indexPath.row].selected ?? false)
            }
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }

/*switch auxiliary*/
//    @objc func didChangeSwitch(_ sender: UISwitch){
//        if sender.isOn {
//            print ("Turned On")
//        }
//        else {
//            print ("Turned Off")
//        }
//    }

    
//    @objc func didGetNotification(_ notification: Notification) {
//        let text = notification.object as! String`?
//        myLabel.text = text
//    }
    
//    func didTapButton(sender: RestaurantTableViewCell) {
//        if let selectedIndexPath = tableView.indexPath(for: sender) {
//            data[selectedIndexPath.row].selected = !(data [selectedIndexPath.row].selected ?? false)
//            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
//            //** DEBUGGING **//
////            print ("success")
////            print (data[selectedIndexPath.row].name)
////            print (data [selectedIndexPath.row].selected)
////            savedata()
//        }
//    }
    
//    func passoverdata (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print ("SBB")
//        let restaurant = data [indexPath.row]
//            if restaurant.selected == true{
//                selecteddata.insert(restaurant.name!, at: 0)
//                print ("PERFECT")
//                print (selecteddata)
//            }
//        else {
//            print ("SAD")
//        }
//        nText = restaurant.name
//        print ("GOOD")
//        print (nText)
//    }

//** Prepare Segue **//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowRestaurantsDetail" || segue.identifier == "ShowCafesDetail" || segue.identifier == "ShowGymsDetail"{
//            let destination = segue.destination as! SelectionUIViewController
//            let selectedIndexPath = tableView.indexPathForSelectedRow!
//    //            // ** CHECK HERE **//
//            SelectionUIViewController?.CheckedItem = data.name [selectedIndexPath.row]
//        }
//    }

    @IBAction func saveButtonPressed(_ Sender:UIBarButtonItem){
//        didTapButton(sender: RestaurantTableViewCell)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            for x in data  {
                //                print("we here",x)
                
                if x.selected == true {
                    //                nText = restaurant.name
                    
                    selecteddata.insert(x, at: 0)
                }
            }
            
//                print (data [selectedIndexPath.row].selected)
//            } else {
//                nText = ""
//            }
            
            //** NOT WORKING **//
            //            if #available(iOS 15.0, *) {
            //                if RestaurantTableViewCell?.myButton.isSelected == true {
            //                    nText = restaurant.name
            //                    print (data [selectedIndexPath.row].selected)
            //                } else {
            //                    nText = ""
            //                }
            //            } else {
            //                nText = ""
            //            }
            
            //** DEBUGGING **//
            print ("GOOD")
//            print (nText)
            print (selecteddata)
        }
//        self.present(SelectVenuesViewController(), animated: true)
        model?.finishedSelectionTapped(selectedvenues: selecteddata)
        coordinator?.didSave()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "RestaurantTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RestaurantTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        data = coordinator?.venues ?? []
//        print (data)
//        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("text"), object: nil)
        
        
//        test()
//        view.backgroundColor = .black
    }
    


}
