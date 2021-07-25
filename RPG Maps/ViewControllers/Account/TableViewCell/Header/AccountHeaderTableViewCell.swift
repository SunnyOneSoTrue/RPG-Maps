//
//  HeaderTableViewCell.swift
//  RPG Maps
//
//  Created by USER on 22.07.21.
//

import UIKit

class AccountHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var coverPhotoImageView: UIImageView!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.height/2
    }
    
}
