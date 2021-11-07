//
//  LoginSignUpViewController.swift
//  College MarketPlace
//
//  Created by Jason Mai on 11/1/21.
//

import UIKit
import Parse

class LoginSignUpViewController: UIViewController {
    

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var correctPassword: UIImageView!
    @IBOutlet weak var wrongPassword: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wrongPassword.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    // Sign in function (button)
    @IBAction func onSign(_ sender: Any) {
        // username <- usernameField (input)
        let username = usernameField.text!
        // password <- passwordField (input)
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password)
        { (user, error) in
            // if user exists perform segue
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            // else perform error
            else{
                print("Error: \(String(describing: error?.localizedDescription))")
                self.wrongPassword.isHidden = false
                self.correctPassword.isHidden = true
                print("wrong password")
            }
        }
        
    }
    
    
    // Sign Up function (button)
    @IBAction func onSignup(_ sender: Any) {
        
        let user = PFUser()
        // username <- usernameField (input)
        user.username = usernameField.text
        // password <- passwordField (input)
        user.password = passwordField.text
        
        user.signUpInBackground { (success, error) in
            // if sign up succeeds
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            // if sign up fails
            else{
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
        
        
        // EXTRA'S
    
        // user.email = "email@example.com"
        // other fields can be set just like with PFObject
        // user["phone"] = "716-445-3281"
        
    }
    
    
    
    
    
    
    
    
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("Loading Up Colleges")
    }
    

}
