//
//  TransferViewModel.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 04/01/22.
//

import Foundation
import SwiftyJSON

class TransferViewModel {
    let apiWorker = APIWorker()
    let urlManager = URLManager()
    let decoder = JSONDecoder()
    
    func postTransferToBackend(_ token: String?, request: TransferModel.Request, completion: @escaping(String?) -> ()) {
        
        if var urlRequest = urlManager.transferApi() {
            urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: request.toJSON(), options: [])
            apiWorker.postHttpRequest(urlRequest, token: token, callBack: { response in
                let statusCode = response.response?.statusCode
                
                if let data = response.data {
                    let json = try! JSON(data: data)
                    let jsonStatus = json["status"].stringValue
                    
                    if statusCode == 200 {
                        completion(jsonStatus)
                    }else{
                        completion(nil)
                    }
                }
            })
        }
    }
}
