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
//    var selecteddata = [SelectedVenue] ()
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
        restaurants.myButton?.isSelected = restaurant.selected ?? false
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
    func didTapButton(sender: RestaurantTableViewCell) {
        if let selectedIndexPath = tableView.indexPath(for: sender) {
            data[selectedIndexPath.row].selected = !(data [selectedIndexPath.row].selected ?? false)
//            data[selectedIndexPath.row].selected = true
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
//            print ("success")
//            print (data[selectedIndexPath.row].name)
//            savedata()
        }
    }

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
            let restaurant = data [selectedIndexPath.row]
            nText = restaurant.name
//            print ("GOOD")
//            print (nText)
        }
//        self.present(SelectVenuesViewController(), animated: true)
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
