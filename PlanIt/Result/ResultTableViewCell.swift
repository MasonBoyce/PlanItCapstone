//
//  ResultTableViewCell.swift
//  PlanIt
//
//  Created by Michael on 4/21/23.
//

import UIKit

protocol ResultTableViewCellDelegate: AnyObject {
    //    func didTapButton(sender: RestaurantTableViewCell)
}

class ResultTableViewCell: UITableViewCell {
    
    weak var delegate: ResultTableViewCellDelegate?

    @IBOutlet weak var TravelLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
