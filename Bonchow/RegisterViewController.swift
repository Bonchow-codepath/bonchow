//
//  RegisterViewController.swift
//  Bonchow
//
//  Created by Anagh Kanungo on 02/04/22.
//

import UIKit
import Parse

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordField.delegate = self
        passwordField.returnKeyType = .done


        // Do any additional setup after loading the view.
    }
    
    @IBAction func onRegister(_ sender: Any) {
        let user = PFUser()
        //user.username = nameField.text
        //user.password = passwordField.text
        //user.email = emailField.text
        user["pseudonym"] = nameField.text
        user.username = emailField.text
        user.password = passwordField.text
        user["food"] = "anything"
        
        user.signUpInBackground{ (success, error) in
            if success{
                self.performSegue(withIdentifier: "registerSegue", sender: nil)
            } else {
                print("error register")
                print("Error: \(error?.localizedDescription)")
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    

}
