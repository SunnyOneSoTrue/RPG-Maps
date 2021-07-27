//
//  LeaderboardViewController.swift
//  RPG Maps
//
//  Created by USER on 27.06.21.
//

import UIKit
import Kingfisher

class LeaderboardViewController: UIViewController {
    
    private var usersManager: UsersManagerProtocol?
    
    var users: [(name: String, points:Int, image: String, coverImage: String, achievements: [String])] = [
//        (name: "თემურ ლენგი", points: 900000, image: "https://shemecneba.ge/wp-content/uploads/2015/03/593dccde790c5fde3582af2d49c13821.jpg"),
//                                                (name: "Lebron James", points: 150000,image: "https://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/1966.png"),
//                                               (name: "Spongebob Squarepants", points: 140000, image: "https://i2.wp.com/bloody-disgusting.com/wp-content/uploads/2017/06/spopng8.jpg?resize=677%2C846"),
//                                               (name: "Patrick Star", points: 130500, image: "https://i.pinimg.com/originals/c8/fa/fd/c8fafd2d923c81cdf6aef413f24e77f0.jpg"),
//                                               (name: "Mi Hoi Minoi", points: 120000, image: "https://i.kym-cdn.com/entries/icons/facebook/000/020/981/CvllgCSUIAAvycY.jpg"),
//                                               (name: "აღამაჰმად ხანი", points: 90000, image: "https://zero-world.clan.su/2915_4b5ae447171cb.jpg"),
//                                               (name: "პორტუგალია", points: 90000, image: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Flag_of_Portugal.svg/1200px-Flag_of_Portugal.svg.png")
    ]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor(red: 0.25, green: 0.00, blue: 0.40, alpha: 1.00)
//        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        // Do any additional setup after loading the view.
        
        usersManager = UsersManager()
        getUsers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func getUsers(){ // MARK: This gets and sets the user info into the users array
        usersManager?.fetchData(completion: { Data in
            //MARK: this part adds the content to the users array
            for i in 0..<Data.users.count{
                let user = Data.users[i]
                self.users.append((name: user.username, points: user.adventurerPoints, image:user.profilePicture, coverImage: user.backgroundPicture, achievements: user.badges))
                
            }
            //this part sorts the users by order of descent by points and reloads the tableview
            self.users = self.users.sorted(by: {$0.points > $1.points})
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
}

extension LeaderboardViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count - 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: //creates and configures the header for the tableview
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as? HeaderTableViewCell else { return UITableViewCell() }
            
            cell.firstImageView.kf.setImage(with: URL(string: users[indexPath.row].image))
            cell.firstNameLabel.text = users[indexPath.row].name
            cell.firstPointsLabel.text = "\(users[indexPath.row].points) points"
            
            
            cell.secondImageView.kf.setImage(with: URL(string: users[indexPath.row+1].image))
            cell.secondNameLabel.text = users[indexPath.row+1].name
            cell.secondPointsLabel.text = "\(users[indexPath.row+1].points) points"
            
            cell.thirdImageView.kf.setImage(with: URL(string: users[indexPath.row+2].image))
            cell.thirdNameLabel.text = users[indexPath.row+2].name
            cell.thirdPointsLabel.text = "\(users[indexPath.row+2].points) points"
            
            return cell
            
        default: // this is the rest of the tableview
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
            
            cell.nameLabel.text = users[indexPath.row + 2].name
            cell.pointsLabel.text = "\(users[indexPath.row + 2].points) points"
            cell.profilePhotoImageView.kf.setImage(with: URL(string: users[indexPath.row + 2].image))
            cell.positionLabel.text = String(indexPath.row + 1 + 2)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = (storyboard?.instantiateViewController(identifier: "checkOutAccountViewController"))! as checkOutAccountViewController
        
//        vc.user = (name: users[indexPath.row + 2].name, points: users[indexPath.row + 2].points, image: users[indexPath.row + 2].image, coverImage: users[indexPath.row + 2].coverImage, achievements: users[indexPath.row + 2].achievements)
        
        vc.user.name = users[indexPath.row + 2].name
        vc.user.points = users[indexPath.row + 2].points
        vc.user.image = users[indexPath.row + 2].image
        vc.user.coverImage = users[indexPath.row + 2].coverImage
        vc.user.achievements = users[indexPath.row + 2].achievements
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
