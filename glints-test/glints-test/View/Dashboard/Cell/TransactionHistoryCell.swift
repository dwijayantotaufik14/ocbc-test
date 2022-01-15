//
//  TransactionHistoryCell.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 15/01/22.
//

import UIKit

class TransactionHistoryCell: UITableViewCell {
    
    @IBOutlet var accountNameLabel: UILabel!
    @IBOutlet var accountNoLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    static var identifier : String{
        return String(describing: self)
    }
    
    static var nib : UINib{
        return UINib(nibName: identifier, bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
