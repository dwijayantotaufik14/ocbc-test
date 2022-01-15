//
//  BalanceViewModel.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 04/01/22.
//

import Foundation
import SwiftyJSON

class BalanceViewModel {
    let apiWorker = APIWorker()
    let urlManager = URLManager()
    let decoder = JSONDecoder()
    
    func getBalanceAccount(_ token: String?, completion: @escaping(BalanceModel.Response?, String?, String?) -> ()) {
        if let urlRequest = urlManager.getBalanceApi() {
            apiWorker.getHttpRequest(urlRequest, token: token,callBack: { response in
                let statusCode = response.response?.statusCode
                
                if let data = response.data {
                    let json = try! JSON(data: data)
                    let jsonStatus = json["status"].stringValue
                    let jsonError = json["error"].stringValue
                    print("JSON : \(json) || \(jsonStatus) - \(jsonError)")
                    
                    if statusCode == 200 {
                        do {
                            let balanceResponse = try self.decoder.decode(BalanceModel.Response.self, from: json.rawData())
                            completion(balanceResponse, jsonStatus, nil)
                        } catch {
                            completion(nil, jsonStatus, jsonError)
                        }
                    }else{
                        completion(nil, jsonStatus, jsonError)
                    }
                    
                }
                
            })
        }
    }
}
