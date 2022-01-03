//
//  URLConstant.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 03/01/22.
//

import Foundation

struct URLConstant {
    static let baseApiUrl: String = Settings.shared.baseUrl
    
    static let loginApi: String = baseApiUrl + "/login" ///POST
    static let registerApi: String = baseApiUrl + "/register" ///POST
    static let getBalanceApi: String = baseApiUrl + "/balance" ///GET
    static let getPayeeApi: String = baseApiUrl + "/payees" ///POST
    static let getTransactionApi: String = baseApiUrl + "/transactions" ///POST
    static let transferApi: String = baseApiUrl + "/transfer" ///GET
}
