//
//  TableViewCell.swift
//  RPG Maps
//
//  Created by USER on 07.07.21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.frame.width/2
        nameLabel.textColor = .white
        positionLabel.textColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
