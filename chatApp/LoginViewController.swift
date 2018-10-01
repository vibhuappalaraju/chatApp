//
//  LoginViewController.swift
//  chatApp
//
//  Created by Vibhu Appalaraju on 9/30/18.
//  Copyright © 2018 Vibhu Appalaraju. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onSignUp(_ sender: Any) {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameField.text
       // newUser.email = emailField.text
        newUser.password = passwordField.text
        
        if (passwordField.text?.isEmpty)! || (usernameField.text?.isEmpty)! {
            let alertController = UIAlertController(title: "Empty Username or Password", message: "Please Enter Username or password", preferredStyle: .alert)
            // create a cancel action
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                // handle cancel response here. Doing nothing will dismiss the view.
            }
            // add the cancel action to the alertController
            alertController.addAction(cancelAction)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
            print("Please Enter Username or password")
            
        }
        
        else{
            // call sign up function on the object
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("User Registered successfully")
                    // manually segue to logged in view
                }
            }
            
        }
        
        
     
        
    }
    
    @IBAction func OnLogin(_ sender: Any) {
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
       
        if (username.isEmpty) || (password.isEmpty) {
            let alertController = UIAlertController(title: "Empty Username or Password", message: "Please Enter Username or password", preferredStyle: .alert)
            // create a cancel action
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                // handle cancel response here. Doing nothing will dismiss the view.
            }
            // add the cancel action to the alertController
            alertController.addAction(cancelAction)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
            print("Please Enter Username or password")
            
        }
        else{
            PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
                if let error = error {let alertController = UIAlertController(title: "Problem with logging in", message: "Login was unsuccessful", preferredStyle: .alert)
                    // create a cancel action
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                        // handle cancel response here. Doing nothing will dismiss the view.
                    }
                    // add the cancel action to the alertController
                    alertController.addAction(cancelAction)
                    
                    // create an OK action
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        // handle response here.
                    }
                    // add the OK action to the alert controller
                    alertController.addAction(OKAction)
                    
                    print("User log in failed: \(error.localizedDescription)")
                } else {
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                    print("User logged in successfully")
                    // display view controller that needs to shown after successful login
                }
            }
        }
        
    }

}
