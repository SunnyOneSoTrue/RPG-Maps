//
//  SignUpViewController.swift
//  RPG Maps
//
//  Created by USER on 25.07.21.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Registration"
        errorLable.alpha=0
        
    }
    
    //MARK: If this method returns nil it means that everything is valid, otherwise it returns the error string
   
    
    @IBAction func onRegister(_ sender: UIButton) {
        
        //MARK: This validates the fields (if the info is put in correctly)
        let error = validateFields()
        
        if error == nil {
            //MARK: This creates the user for firebase
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { result, error in
                if let error = error {
                    self.showError(on: self.errorLable, error: error.localizedDescription)
                }
                //MARK: Later add firestore database and add info there
            }
            //MARK: This transitions to the home screen
            transitionToHomeVC()
        }
        else{
            showError(on: errorLable, error: error!)
        }
    }
    
    
    func showError(on label: UILabel, error: String){
        label.text = error
        label.textColor = .red
        label.alpha = 1
    }
    
    func transitionToHomeVC (){
        let accountVC = storyboard?.instantiateViewController(identifier: "AccountViewController") as! AccountViewController
        accountVC.loggedInUser.name = usernameField.text!
        
        let tabbar = storyboard?.instantiateViewController(identifier: "TabbarController") as! UITabBarController
        view.window?.rootViewController = tabbar
        view.window?.makeKeyAndVisible()
    }
    func validateFields() -> String? {
        
        if usernameField.text == "" || emailField.text == "" || passwordField.text == "" {
            return "Please Fill In all the fields. "
        }
        else if passwordField.text?.count ?? 0 < 6{
            return "Password needs to be at least 6 characters long"
        }
        
        return nil
    }
    

}
