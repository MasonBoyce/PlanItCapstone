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
    var selecteddata : [Venue] = []
    var currentDataSource : [Venue] = []
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
        guard let text = searchController.searchBar.text else {
            return
        }
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
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let restaurants = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        let restaurant = data [indexPath.row]
        restaurants.delegate = self
        restaurants.myLabel?.text = restaurant.name
        restaurants.priceLabel?.text = restaurant.price
//        restaurants.addressLabel?.text = String(restaurant.distance! * 0.000621) + " mi"
//        restaurants.addressLabel?.text = restaurant.short_loc
        restaurants.statusLabel?.text = "(" + String(restaurant.review_count ?? 0) + ") · " + restaurant.short_loc!
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
            restaurants.ratingLabel?.textColor = .systemBrown
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
        }
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            //            cell.backgroundColor = UIColor(red: 0, green: 252, blue: 0, alpha: 0.1)
            cell.backgroundColor = .systemGray3
            UIView.animate(withDuration: 0.2, animations: {
                tableView.cellForRow(at: indexPath)?.backgroundColor = .secondarySystemGroupedBackground
            })
            if cell.isSelected {
                data[indexPath.row].selected = !(data [indexPath.row].selected ?? false)
            }
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        //        tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor(red: 252, green: 0, blue: 0, alpha: 0.1)
        tableView.cellForRow(at: indexPath)?.backgroundColor = .systemGray3
        UIView.animate(withDuration: 0.2, animations: {
            tableView.cellForRow(at: indexPath)?.backgroundColor = .secondarySystemGroupedBackground
        })
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
            selecteddata = data
        }
        model?.finishedSelectionTapped(venues: selecteddata)
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
            data.sort(by: {$0.distance! < $1.distance!})
        case 1: //A-Z
            data.sort(by: {$0.name! < $1.name!})
        case 2: //cheap
            data.sort(by: {$0.price ?? "a" < $1.price ?? "z"})
        case 3: //rating
            data.sort(by: {$0.rating! > $1.rating!})
        default:
            print ("sort error")
        }
        tableView.reloadData()
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "No Venues", message: "Please select at least one venue to calculate", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func sortSegementPressed(_ sender: UISegmentedControl) {
        sortBasedOnSegmentPressed()
        let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
    }
    
}

