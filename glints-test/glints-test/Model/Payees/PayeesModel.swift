//
//  PayeesModel.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 04/01/22.
//

import Foundation

enum PayeesModel {
    struct Response: Codable {
        var status: String?
        var data: [PayeesData]?
        
        init(){}
    }
    
    struct PayeesData: Codable {
        var id: String?
        var name: String?
        var accountNo: String?
        
        init(){}
    }
}
