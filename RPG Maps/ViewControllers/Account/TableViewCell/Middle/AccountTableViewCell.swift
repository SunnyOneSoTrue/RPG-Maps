//
//  AccountTableViewCell.swift
//  RPG Maps
//
//  Created by USER on 07.07.21.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    @IBOutlet weak var achievementLabel: UILabel!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    @IBOutlet weak var imageField: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
