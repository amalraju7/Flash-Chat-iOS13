//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        let email : String? = emailTextfield.text
        let password : String? = passwordTextfield.text
        if let email = email,let password = password {
        Auth.auth().createUser(withEmail: email ,   password: password) { authResult, error in
            if let error = error{
                print(error)
            }
            else{
                self.performSegue(withIdentifier: K.registerSegue, sender: self)
            }
        }
        }
    }
    
}
