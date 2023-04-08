//
//  LoginViewController.swift
//  GoalManager
//
//  Created by Amin Saedi on 2023-04-08.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var txtUsernameSignin: UITextField!
    @IBOutlet weak var txtPasswordSignin: UITextField!
    
    @IBOutlet weak var txtUsernameSignup: UITextField!
    @IBOutlet weak var txtPasswordSignup: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func displayAlert(withTitle: String, message: String) {
        
        let alertController = UIAlertController(title:withTitle, message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            
        }
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func signin(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: self.txtUsernameSignin.text!, password: self.txtPasswordSignin.text!) {
            (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                //self.displayAlert(withTitle: "Login Successful", message: "")
                self.performSegue(withIdentifier: "toMainViewController", sender: nil)
            } else {
                self.displayAlert(withTitle: "Error", message: error!.localizedDescription)
            }
        }
    }
    
    @IBAction func signup(_ sender: Any) {
        let user = PFUser()
        user.username = self.txtUsernameSignup.text
        user.password = self.txtPasswordSignup.text
        
        user.signUpInBackground {(succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                self.displayAlert(withTitle: "Error", message: error.localizedDescription)
            } else {
                //self.displayAlert(withTitle: "Success", message: "Account has been successfully created")
                self.performSegue(withIdentifier: "toMainViewController", sender: nil)
            }
        }
    }
    
    
}
