//
//  RegisterViewController.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 05/01/22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet var usernameTextField: FloatingLabelField!
    @IBOutlet var passwordTextField: FloatingLabelField!
    @IBOutlet var confirmPassTextField: FloatingLabelField!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.errorLabel.isHidden = true
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        if confirmPassTextField.text != passwordTextField.text {
            errorLabel.isHidden = false
        }
        
        
    }
    
}
