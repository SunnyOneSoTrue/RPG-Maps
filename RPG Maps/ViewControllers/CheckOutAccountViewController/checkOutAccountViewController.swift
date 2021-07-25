//
//  checkOutAccountViewController.swift
//  RPG Maps
//
//  Created by USER on 22.07.21.
//

import UIKit

class checkOutAccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

   var user = (name: "SunnySideUp", points: 0, image: "", coverImage: "", achievements: [])
    
    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UINib(nibName: "AccountTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountTableViewCell")
        tableView?.register(UINib(nibName: "AccountHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountHeaderTableViewCell")
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.achievements.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountHeaderTableViewCell", for: indexPath) as? AccountHeaderTableViewCell else { return UITableViewCell() }
            
            cell.NameLabel.text = user.name
            cell.coverPhotoImageView.kf.setImage(with: URL(string: user.image))
            cell.coverPhotoImageView.kf.setImage(with: URL(string: user.coverImage))
            cell.pointsLabel.text = "\(user.points) points"
            
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath) as? AccountTableViewCell else { return UITableViewCell() }
            
            cell.achievementLabel.text = user.achievements[indexPath.row-1] as? String
            cell.imageField.image = UIImage(named: "\(user.achievements[indexPath.row-1])Badge")
            cell.numberOfPeopleLabel.text = "\(Int.random(in: 3000...50000000)) People have unlocked this achievement so far"
            
            return cell
        }
    }
}
