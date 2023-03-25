//
//  SelectVenuesViewController.swift
//  PlanIt
//
//  Created by Mason Boyce on 2/14/23.
//

import Foundation
import UIKit

//Dummy without tableview for Debugging

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


class SelectVenuesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SelectVenuesViewControllerProtocol{
    var model: SelectVenuesModel?
    var coordinator: SelectVenuesCoordinator?
//retrive Veneus
    var data = [Venue]()
//    var data: Array <String>?
    
//    init model?.venues{
//        self.fetchVenues = fetchVenues
//    }
    
//    func runyelpapi(){
//        model?.yelpApiCall(categoryType:"restaurants")
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "RestaurantTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RestaurantTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        data = coordinator!.venues
//        print (data)
//        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("text"), object: nil)
        
        
//        test()
//        view.backgroundColor = .black
    }
    
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
        restaurants.myLabel?.text = restaurant.name
        restaurants.priceLabel?.text = restaurant.price
//        let restaurants = table.dequeueReusableCell(withIdentifier: "restaurants", for: indexPath) as! CustomTableViewCell
//        restaurants.textLabel?.text = data[indexPath.row]
        
/*switch*/
        let mySwitch = UISwitch()
//Defaults turning on
//mySwitch.isOn = true
        mySwitch.addTarget(self, action: #selector(didChangeSwitch(_:)), for: .valueChanged)
        restaurants.accessoryView = mySwitch
        
        return restaurants
    }
    
//    func test(){
//        print ([Venue].self())
//        print("Hi")
//    }

/*switch auxiliary*/
    @objc func didChangeSwitch(_ sender: UISwitch){
        if sender.isOn {
            print ("Turned On")
        }
        else {
            print ("Turned Off")
        }
    }

/*Passing Data*/
//    @objc func didGetNotification(_ notification: Notification) {
//        let text = notification.object as! Array<Any>?
//        myLabel.text = text
//    }


}
