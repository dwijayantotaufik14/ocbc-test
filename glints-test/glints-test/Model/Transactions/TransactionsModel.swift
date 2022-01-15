//
//  TransactionsModel.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 04/01/22.
//

import Foundation

enum TransactionsModel {
    
    struct Response: Codable {
        var transactionId: String?
        var amount: Decimal?
        var transactionDate: String?
        var description: String?
        var transactionType: String?
        var receipient: Receipient?
        var sender: Sender?
        
        init(){}
    }
    
    struct Receipient: Codable {
        var accountNo: String?
        var accountHolder: String?
        
        init(){}
    }
    
    struct Sender: Codable {
        var accountNo: String?
        var accountHolder: String?
        
        init(){}
    }
    
    struct GroupedTransactions {
        var transactions: [String: [Response]]?
        var transactionDate: [String]?
    }
}
