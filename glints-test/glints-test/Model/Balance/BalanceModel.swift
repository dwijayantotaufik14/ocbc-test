//
//  BalanceModel.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 04/01/22.
//

import Foundation

enum BalanceModel {
    struct Response: Codable {
        var status: String?
        var accountNo: String?
        var balance: Decimal?
        
        init(){}
    }
}
