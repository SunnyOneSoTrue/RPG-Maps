//
//  Achievement.swift
//  RPG Maps
//
//  Created by USER on 07.07.21.
//

import UIKit

class Achievement{
    var title: String
    var numberOfPeople:Int
    var image: UIImage
    
    init(title: String, NumberOfPeople: Int, image: String = "") {
        self.title = title
        self.image = UIImage(named: image)!
        self.numberOfPeople = NumberOfPeople
    }
}
