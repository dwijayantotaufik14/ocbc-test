//
//  PayeeListCell.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 16/01/22.
//

import UIKit

class PayeeListCell: UITableViewCell {
    
    var accountId: String?
    @IBOutlet var accountNoLabel: UILabel!
    @IBOutlet var accountNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var identifier : String{
        return String(describing: self)
    }
    
    static var nib : UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
