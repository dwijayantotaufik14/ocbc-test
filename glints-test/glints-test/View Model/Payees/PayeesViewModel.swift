//
//  PayeesViewModel.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 04/01/22.
//

import Foundation
import SwiftyJSON

class PayeesViewModel {
    let apiWorker = APIWorker()
    let urlManager = URLManager()
    let decoder = JSONDecoder()
    
    func getPayeeList(_ token: String?, completion: @escaping([PayeesModel.PayeesData]?, String?, String?) -> ()) {
        if let urlRequest = urlManager.getPayeeApi() {
            apiWorker.getHttpRequest(urlRequest, token: token,callBack: { response in
                let statusCode = response.response?.statusCode
                
                if let data = response.data {
                    let json = try! JSON(data: data)
                    let jsonData = json["data"]
                    let jsonStatus = json["status"].stringValue
                    let jsonError = json["error"].stringValue
                    print("JSON : \(json) || \(jsonStatus) - \(jsonError)")
                    
                    if statusCode == 200 {
                        do {
                            let payeeResponse = try self.decoder.decode([PayeesModel.PayeesData].self, from: jsonData.rawData())
                            completion(payeeResponse, jsonStatus, nil)
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
