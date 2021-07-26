//
//  SignInViewController.swift
//  RPG Maps
//
//  Created by USER on 25.07.21.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Sign In"
    }
    
    @IBAction func onSignIn(_ sender: UIButton) {
    }
    
    @IBAction func onRegister(_ sender: UIButton) {
    }
    
}
