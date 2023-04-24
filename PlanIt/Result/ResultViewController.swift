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
    
    var mapMod : MapModel!
    
    @IBOutlet weak var screenshot: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var model: ResultModel?
    var coordinator: ResultCoordinator?
    //retrive Veneus
    var resultdata = [Venue]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
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
    
    @IBOutlet weak var routetime: UILabel!
    
    override func viewDidLoad() {
//        view.backgroundColor = .link
        super.viewDidLoad()
        let nib = UINib(nibName: "ResultTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ResultTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0);
        routetime.text = mapMod.optimal_route?.first?.name
    }
    
    @IBAction func screenshot(_ sender: Any) {
            //Create the UIImage
            self.screenshot.isHidden = true
            self.navigationController?.navigationBar.isHidden = true
            guard let layer = UIApplication.shared.keyWindow?.layer else { return }
            let renderer = UIGraphicsImageRenderer(size: layer.frame.size)
            let image = renderer.image(actions: { context in
                layer.render(in: context.cgContext)
            })
            
            //Save it to the camera roll
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            self.screenshot.isHidden = false
            self.navigationController?.navigationBar.isHidden = false
    }
}
