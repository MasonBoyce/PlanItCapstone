//
//  RestaurantTableViewCell.swift
//  PlanIt
//
//  Created by Michael on 3/16/23.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
//    @IBOutlet var myImageView: UIImageView!
    @IBOutlet var mySwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
