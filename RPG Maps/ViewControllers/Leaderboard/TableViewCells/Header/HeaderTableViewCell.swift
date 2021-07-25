//
//  HeaderTableViewCell.swift
//  RPG Maps
//
//  Created by USER on 21.07.21.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var thirdNameLabel: UILabel!
    
    @IBOutlet weak var firstPointsLabel: UILabel!
    @IBOutlet weak var secondPointsLabel: UILabel!
    @IBOutlet weak var thirdPointsLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        firstImageView.layer.cornerRadius = firstImageView.frame.width/2
        secondImageView.layer.cornerRadius = secondImageView.frame.width/2
        thirdImageView.layer.cornerRadius = thirdImageView.frame.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
