//
//  TransferViewController.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 06/01/22.
//

import UIKit

class TransferViewController: UIViewController {

    @IBOutlet var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        descriptionTextView.layer.cornerRadius = 8
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
    }

}
