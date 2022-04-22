//
//  RestaurantTableViewCell.swift
//  Bonchow
//
//  Created by Yvonne511 on 2022/4/20.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var resImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
