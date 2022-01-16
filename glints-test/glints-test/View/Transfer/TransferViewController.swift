//
//  TransferViewController.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 06/01/22.
//

import UIKit

class TransferViewController: UIViewController {

    @IBOutlet var payeeTextfield: FloatingLabelField!
    @IBOutlet var amountTextfield: FloatingLabelField!
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var descriptionTextView: UITextView!
    
    @IBOutlet var transferButton: UIButton!
    
    
    var loginResponse : LoginModel.Response?
    var transferRequest = TransferModel.Request()
    
    var viewModel = TransferViewModel()
    
    let rightViewPayee = UIButton(type: .custom)
    
    var activeTextfield = UITextField()
    
    var accountNo: String = ""
    var accountName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTextfield()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        descriptionView.layer.cornerRadius = 8
        descriptionView.layer.borderWidth = 1
        descriptionView.layer.borderColor = UIColor.black.cgColor
        
        transferButton.layer.cornerRadius = transferButton.frame.height / 2
    }
    
    func setupTextfield() {
        rightViewPayee.setImage(UIImage(named: "ic-dropdown"), for: .normal)
        rightViewPayee.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        
        payeeTextfield.delegate = self
        payeeTextfield.rightView = rightViewPayee
        payeeTextfield.rightViewMode = .always
    }

    @IBAction func transferButtonAction(_ sender: Any) {
        transferRequest.receipientAccountNo = self.accountNo
        transferRequest.amount = Decimal(string: amountTextfield.text!)
        transferRequest.description = descriptionTextView.text
        
        viewModel.postTransferToBackend(loginResponse?.token, request: transferRequest, completion: { status in
            
            if status == "success" {
                self.dismiss(animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: nil, message: "System Error", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        })
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension TransferViewController: UITextFieldDelegate, PayeeListDelegate {
    func selectedPayee(id: String, name: String, accountNo: String) {
        self.accountNo = accountNo
        self.accountName = name
        
        self.payeeTextfield.text = "\(accountNo) - \(name)"
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        let vc = PayeeListViewController()
        vc.delegate = self
        vc.loginToken = loginResponse!.token!
        self.present(vc, animated: true, completion: nil)
        
        return false
    }
    
    
}
