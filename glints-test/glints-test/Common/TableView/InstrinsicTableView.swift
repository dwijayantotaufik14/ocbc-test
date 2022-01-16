//
//  InstrinsicTableView.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 16/01/22.
//

import UIKit

class InstrinsicTableView: UITableView {
    override public var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }
    
    override public var contentSize: CGSize {
        didSet{
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override public func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
}

