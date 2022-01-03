//
//  RegisterModel.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 04/01/22.
//

import Foundation

enum RegisterModel {
    struct Request {
        var username: String?
        var password: String?
        
        func toJSON() -> [String:Any] {
            return [
                "username" : username ?? "",
                "password" : password ?? ""
            ]
        }
    }
    
    struct Response: Codable {
        var status: String?
        var token: String?
        
        init() {}
    }
}
