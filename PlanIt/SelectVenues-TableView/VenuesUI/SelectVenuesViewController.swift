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

class ResultsVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = .red
    }
}

//** Loading Screen Helper func - Adpted from https://www.hackingwithswift.com/example-code/uikit/how-to-use-uiactivityindicatorview-to-show-a-spinner-when-work-is-happening **//

//class SpinnerViewController: UIViewController {
//    var spinner = UIActivityIndicatorView(style: .large)
//
//    override func loadView() {
//        view = UIView()
//        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
//
//        spinner.translatesAutoresizingMaskIntoConstraints = false
//        spinner.startAnimating()
//        view.addSubview(spinner)
//
//        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//    }
//}

class SelectVenuesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SelectVenuesViewControllerProtocol, RestaurantTableViewCellDelegate , UISearchResultsUpdating, UISearchBarDelegate{
    
    var filtered = [Venue]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    
    
    //** If connected to UInvaigationController, Dismiss (nestedview); If not, POP (swipeback)**//
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem){
        let isPresentingInPushMode = presentingViewController is UINavigationController
        if isPresentingInPushMode {
            dismiss(animated: true, completion: nil)
        }else{
            navigationController?.popViewController(animated: true)
        }
        let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
    }
    
    var model: SelectVenuesModel?
    var coordinator: SelectVenuesCoordinator?
    //retrive Veneus
    var data = [Venue]()
    var celldata : [Venue] = []
//   var resultData : [Venue] = []
    //    var data: Array <String>?
    
    //    init model?.venues{
    //        self.fetchVenues = fetchVenues
    //    }
    
    //    func runyelpapi(){
    //        model?.yelpApiCall(categoryType:"restaurants")
    //    }
    
    
    
    
    @IBOutlet var tableView: UITableView!
    //** Search Functionality **//
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        let filtered = data.filter{$0.name!.lowercased().contains(searchText.lowercased())}
        self.filtered = filtered.isEmpty ? data : filtered
        tableView.reloadData()
        
//        let vc = searchController.searchResultsController as? ResultsVC
//                vc?.view.backgroundColor = UIColor(red: 177, green: 226, blue: 252, alpha: 0)
    }
    
//    func filterCurrentDataSource(searchTerm: String){
//        if searchTerm.count > 0 {
//            
//            currentDataSource = 
//            
//            let filteredResults = currentDataSource.filter {  $0.replacingOccurrences(of: " ", with: "").lowercased().contains(searchTerm.replacingOccurrences(of: " ", with: "").lowercased())  }
//            
//            currentDataSource = filteredResults
//            tableview.reloadData()
//            
//        }
//    }
//    
//    func restoreCurrentDataSource (){
//        currentDataSoruce = orginalDataSource
//        tableview.reloadData()
//    }
    
    //Required TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filtered.isEmpty{
            return data.count
        } else {
            return filtered.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let restaurants = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        var restaurant = data [indexPath.row]
        if filtered.isEmpty == false {
            restaurant = filtered [indexPath.row]
        }
        restaurants.delegate = self
        restaurants.myLabel?.text = restaurant.name
        restaurants.priceLabel?.text = restaurant.price
//        let converted = String(restaurant.distance).converted(to: UnitLength.miles)
//        restaurants.distanceLabel?.text = String(round(100 * restaurant.distance! * 0.000621371) / 100) + " mi"
//        restaurants.addressLabel?.text = restaurant.short_loc
        
        //** Needs improvement : print ADDRESS (2 , 3, city, state) if busniness misses address 1 **//
        if ((restaurant.short_loc?.isEmpty) == nil){
            restaurants.statusLabel?.text = "(" + String(restaurant.review_count ?? 0) + ")" + " · " +  String(round(100 * restaurant.distance! * 0.000621371) / 100) + " mi"
        } else {
            restaurants.statusLabel?.text = "(" + String(restaurant.review_count ?? 0) + ") · " + String(round(100 * restaurant.distance! * 0.000621371) / 100) + " mi" + " · " + restaurant.short_loc!
        }
//        restaurants.statusLabel?.text = "(" + String(restaurant.review_count ?? 0) + ") · " + round (restaurant.distance) + " · " + restaurant.short_loc!
//      print ("WHAT", restaurant.distance)
//        print ("HOW", restaurant.title)
        
        //** STATUS **//
//        if restaurant.is_closed! {
//            restaurants.statusLabel?.text = "closed"
//            restaurants.statusLabel?.textColor = .systemRed
//        }
//        else {
//            restaurants.statusLabel?.text = "open"
//            restaurants.statusLabel?.textColor = .systemGreen
//        }
        
        //** RATING **//
        if 0 == restaurant.rating! {
            restaurants.ratingLabel?.text = "☆☆☆☆☆"
            restaurants.ratingLabel?.textColor = .systemYellow
        }
        else if 0...1 ~= restaurant.rating! {
            restaurants.ratingLabel?.text = "★☆☆☆☆"
            restaurants.ratingLabel?.textColor = .systemYellow
        }
        else if 1...2 ~= restaurant.rating! {
            restaurants.ratingLabel?.text = "★★☆☆☆"
            restaurants.ratingLabel?.textColor = .systemYellow
        }
        else if 2...3 ~= restaurant.rating! {
            restaurants.ratingLabel?.text = "★★★☆☆"
            restaurants.ratingLabel?.textColor = .systemYellow
        }
        else if 3...4 ~= restaurant.rating! {
            restaurants.ratingLabel?.text = "★★★★☆"
            restaurants.ratingLabel?.textColor = .systemOrange
        }
        else if 4...5 ~= restaurant.rating! {
            restaurants.ratingLabel?.text = "★★★★★"
            restaurants.ratingLabel?.textColor = .systemRed
        }
        
        //        restaurants.myButton?.isSelected = restaurant.selected ?? false
        restaurants.selectionStyle = .none
        //        print(restaurant)
        restaurants.accessoryType = .none
        if restaurant.selected {
            restaurants.accessoryType = .checkmark
        }
        return restaurants
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "Ignore"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        if editingStyle == UITableViewCell.EditingStyle.delete {
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
//            nt("fuckers af",data)
        }
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor(red: 0, green: 252, blue: 0, alpha: 0.1)
        tableView.cellForRow(at: indexPath)?.backgroundColor = .systemGray3
        UIView.animate(withDuration: 0.4, animations: {
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
//        if let cell = tableView.cellForRow(at: indexPath) {
//            if cell.accessoryType == .checkmark{
//                cell.accessoryType = .none
//            }
//            else{
//                cell.accessoryType = .checkmark
//            }
//        }
    }
    
    //*switch auxiliary*//
    //    @objc func didChangeSwitch(_ sender: UISwitch){
    //        if sender.isOn {
    //            print ("Turned On")
    //        }
    //        else {
    //            print ("Turned Off")
    //        }
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
        
        if tableView.indexPathForSelectedRow != nil {
            celldata = data
        }
//        print("FUCKERs", celldata)
        model?.finishedSelectionTapped(newVenues: data)
        coordinator?.didSave()
        let generator = UIImpactFeedbackGenerator(style: .heavy)
                    generator.impactOccurred()
        
    }
    
    //** Enable Load Screen **//
    
    //    func createSpinnerView() {
    //
    //        let child = SpinnerViewController()
    //
    //        // add the spinner view controller
    //        addChild(child)
    //        child.view.frame = view.frame
    //        view.addSubview(child.view)
    //        child.didMove(toParent: self)
    //
    //        // wait two seconds to simulate some work happening
    //        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    //            // then remove the spinner view controller
    //            child.willMove(toParent: nil)
    //            child.view.removeFromSuperview()
    //            child.removeFromParent()
    //        }
    //    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "RestaurantTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RestaurantTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        data = coordinator?.venues ?? []
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
//        searchController.obscuresBackgroundDuringPresentation = false
        //        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("text"), object: nil)
    }
    
    func sortBasedOnSegmentPressed() {
        switch sortSegmentedControl.selectedSegmentIndex{
        case 0: //closest
            if filtered.isEmpty {
                data.sort(by: {$0.distance! < $1.distance!})
            }
            else {
                filtered.sort(by: {$0.distance! < $1.distance!})
            }
        case 1: //A-Z
            if filtered.isEmpty {
                data.sort(by: {$0.name! < $1.name!})
            } else {
                filtered.sort(by: {$0.name! < $1.name!})
            }
        case 2: //cheap
            if filtered.isEmpty {
                data.sort(by: {$0.price ?? "a" < $1.price ?? "z"})
            } else {
                filtered.sort(by: {$0.price ?? "a" < $1.price ?? "z"})
            }
        case 3: //rating
            if filtered.isEmpty {
                data.sort(by: {$0.rating! > $1.rating!})
            } else{
                filtered.sort(by: {$0.rating! > $1.rating!})
            }
        default:
            print ("⛔️ SORT ERROR")
        }
        tableView.reloadData()
    }
    
    
    @IBAction func sortSegementPressed(_ sender: UISegmentedControl) {
        sortBasedOnSegmentPressed()
        let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
    }
    
}

//    filtered = data.filter{$0.name!.lowercased().contains(searchText.lowercased())

