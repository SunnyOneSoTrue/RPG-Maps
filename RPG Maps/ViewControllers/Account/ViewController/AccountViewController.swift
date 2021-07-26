//
//  AccountViewController.swift
//  RPG Maps
//
//  Created by USER on 27.06.21.
//

import UIKit
import Kingfisher

class AccountViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var usersManager: UsersManagerProtocol?
    
    var loggedInUser = (name: "SunnySideUp", points: 0, image: "", coverImage: "", achievements: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountTableViewCell")
        tableView.register(UINib(nibName: "AccountHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountHeaderTableViewCell")

        usersManager = UsersManager()
        getUsers()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(onLogOut))
    }
    
    func getUsers(){ // MARK: This gets and sets the user info into the users array
        usersManager?.fetchData(completion: { [self] Data in
            //MARK: this part adds the content to the users array
            for i in 0..<Data.users.count{
                if self.loggedInUser.name == Data.users[i].username{
                    self.loggedInUser.name = Data.users[i].username
                    self.loggedInUser.points = Data.users[i].adventurerPoints
                    self.loggedInUser.image = Data.users[i].profilePicture
                    self.loggedInUser.coverImage = Data.users[i].backgroundPicture
                    self.loggedInUser.achievements = Data.users[i].badges
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
               
            }
        })
    }
    
    @objc func onLogOut() {
        
        self.loggedInUser.name = ""
        transitionToSignInVC()
        
    }
    
    func transitionToSignInVC (){
        let signInVC = storyboard?.instantiateViewController(identifier: "SignInViewController") as! SignInViewController
        
        view.window?.rootViewController = signInVC
        view.window?.makeKeyAndVisible()
    }
    
}

extension AccountViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loggedInUser.achievements.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountHeaderTableViewCell", for: indexPath) as? AccountHeaderTableViewCell else { return UITableViewCell() }
            
            cell.NameLabel.text = loggedInUser.name
            cell.coverPhotoImageView.kf.setImage(with: URL(string: loggedInUser.image))
            cell.coverPhotoImageView.kf.setImage(with: URL(string: loggedInUser.coverImage))
            cell.pointsLabel.text = "\(loggedInUser.points) points"
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath) as? AccountTableViewCell else { return UITableViewCell() }
            
            cell.achievementLabel.text = loggedInUser.achievements[indexPath.row-1] as? String
            cell.imageField.image = UIImage(named: "\(loggedInUser.achievements[indexPath.row-1])Badge")
            cell.numberOfPeopleLabel.text = "\(Int.random(in: 3000...50000000)) People have unlocked this achievement so far"
            
            
            return cell
        }
        
    }
}
