//
//  RestaurantTableViewCell.swift
//  PlanIt
//
//  Created by Michael on 3/16/23.
//

import UIKit

protocol RestaurantTableViewCellDelegate: AnyObject {
    func didTapButton(sender: RestaurantTableViewCell)
}

class RestaurantTableViewCell: UITableViewCell {
    
    weak var delegate: RestaurantTableViewCellDelegate?
    
    @IBOutlet var myButton: UIButton!
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
//    @IBOutlet var myImageView: UIImageView!
    
    
    
//** Switch && Label **//
//    @IBOutlet var mySwitch: UISwitch!
//    private var title: String = ""
//
    @IBAction func buttonTapped(_sender: UIButton){
        delegate?.didTapButton(sender: self)
    }
//
//    func configure(with title: String) {
//        self.title = title
//        myLabel.setTitle(title, for: .normal)
//    }
    
    
    //** PORPERTY OBSERVER **//
//    var selectedItem : Venue! {
//        didSet{
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
