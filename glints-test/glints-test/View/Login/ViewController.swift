//
//  ViewController.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 03/01/22.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    let apiWorker = APIWorker()
    let urlManager = URLManager()
    let decoder = JSONDecoder()
    
    @IBOutlet var usernameTextField: FloatingLabelField!
    @IBOutlet var usernameErrorLabel: UILabel!
    
    @IBOutlet var passwordTextField: FloatingLabelField!
    @IBOutlet var passwordErrorLabel: UILabel!
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    
    let loginViewModel = LoginViewModel()
    var loginRequest = LoginModel.Request()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        usernameTextField.delegate = self
        usernameErrorLabel.isHidden = true
        
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        passwordErrorLabel.isHidden = true
        
        self.hideKeyboardWhenTappedAround()
        
        /*let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MWQzNTNhNDM0NGFhMjhlOGViMjcyYzkiLCJ1c2VybmFtZSI6InRlc3RQb3N0IiwiYWNjb3VudE5vIjoiNzU4MS00ODQtNDE4NSIsImlhdCI6MTY0MTI0MDUxNSwiZXhwIjoxNjQxMjUxMzE1fQ._VNZ2A-DoO4JNqtN8h_xnYggaUpfk5-TaHdzhzaAk1A"
        
        if let urlRequest = urlManager.getBalanceApi() {
            apiWorker.getHttpRequest(urlRequest, token: token, callBack: { response in
                let statusCode = response.response!.statusCode
                if statusCode == 200 {
                    if let data = response.data {
                        let json = try! JSON(data: data)
                        
                        do {
                            let goodsReceiptResponse = try self.decoder.decode(BalanceModel.Response.self, from: json.rawData())
                            print(goodsReceiptResponse)
                        } catch {
                            print("ERROR")
                            
                        }
                    }
                }else{
                    print("ERROR")
                }
            })
        }*/
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        registerButton.layer.borderWidth = 1.5
        
        [registerButton, loginButton].forEach({
            $0?.layer.cornerRadius = $0!.frame.height / 2
        })
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        if usernameTextField.text!.isEmpty && passwordTextField.text!.isEmpty {
            usernameErrorLabel.isHidden = false
            passwordErrorLabel.isHidden = false
        } else if usernameTextField.text!.isEmpty {
            usernameErrorLabel.isHidden = false
        }else if passwordTextField.text!.isEmpty {
            passwordErrorLabel.isHidden = false
        } else {
            loginRequest.username = self.usernameTextField.text
            loginRequest.password = self.passwordTextField.text
            
            loginViewModel.userLogin(request: loginRequest, completion: { response, status, error  in
                if status == "success" {
                    DispatchQueue.main.async {
                        let dashboard = DashboardViewController()
                        dashboard.loginResponse = response!
                        dashboard.modalPresentationStyle = .fullScreen
                        self.present(dashboard, animated: true, completion: nil)
                        
                        self.usernameTextField.text = ""
                        self.passwordTextField.text = ""
                        self.view.endEditing(true)
                    }
                }else{
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: status, message: error, preferredStyle: .actionSheet)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            })
        }
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
}


extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    
}
