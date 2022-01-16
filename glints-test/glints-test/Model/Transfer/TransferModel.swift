//
//  TransferModel.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 04/01/22.
//

import Foundation

enum TransferModel {
    struct Request {
        var receipientAccountNo: String?
        var amount: Decimal?
        var description: String?
        
        func toJSON() -> [String: Any] {
            return [
                "receipientAccountNo" : receipientAccountNo ?? "",
                "amount": amount ?? 0,
                "description": description ?? ""
            ]
        }
        init() {}
    }
    
    struct Response: Codable {
        var status: String?
        var transactionId: String?
        var amount: Decimal?
        var description: String?
        var recipientAccount: String?
        
        init() {}
    }
}
