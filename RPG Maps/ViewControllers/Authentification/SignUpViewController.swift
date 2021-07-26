//
//  SignUpViewController.swift
//  RPG Maps
//
//  Created by USER on 25.07.21.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Registration"
        
    }
    
    @IBAction func onRegister(_ sender: UIButton) {
    }
    

}
