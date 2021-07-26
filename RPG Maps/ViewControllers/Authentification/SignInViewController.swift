//
//  SignInViewController.swift
//  RPG Maps
//
//  Created by USER on 25.07.21.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Sign In"
//        errorLabel.alpha=0
        errorLabel.text = "Welcome To Your Adventure"
       
        signInButton.layer.cornerRadius = 27
        signInButton.layer.borderWidth = 3
        signInButton.layer.borderColor = UIColor.white.cgColor
        signInButton.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        signInButton.setTitleColor(UIColor(red: 0.82, green: 0.82, blue: 0.82, alpha: 1.00), for: .normal)
        
        registerButton.layer.cornerRadius = 27
        registerButton.layer.borderWidth = 3
        registerButton.layer.borderColor = UIColor.white.cgColor
        registerButton.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        registerButton.setTitleColor(UIColor(red: 0.82, green: 0.82, blue: 0.82, alpha: 1.00), for: .normal)
    }
    
    @IBAction func onSignIn(_ sender: UIButton) {
        
        let error = validateFields()
        
        if error == nil {
            Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { result, error in
                if error != nil{
                    self.errorLabel.text = error?.localizedDescription
                    self.errorLabel.alpha = 1
                }
                else{
                    self.transitionToHomeVC()
                }
            }
            //MARK: This transitions to the home screen
            
        }
        else{
            showError(on: errorLabel, error: error!)
        }
        
       
    }
    
    @IBAction func onRegister(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func transitionToHomeVC (){
        let accountVC = storyboard?.instantiateViewController(identifier: "AccountViewController") as! AccountViewController
        accountVC.loggedInUser.name = usernameField.text!
        
        let tabbar = storyboard?.instantiateViewController(identifier: "TabbarController") as! UITabBarController
        view.window?.rootViewController = tabbar
        view.window?.makeKeyAndVisible()
    }
    
    func showError(on label: UILabel, error: String){
        label.text = error
        label.textColor = .red
        label.alpha = 1
    }
    
    func validateFields() -> String? {
        
        if usernameField.text == "" || emailField.text == "" || passwordField.text == "" {
            return "Please Fill In all the fields. "
        }
        
        return nil
    }
    
}
