//
//  LoginViewModel.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 04/01/22.
//

import Foundation
import SwiftyJSON

class LoginViewModel {
    let apiWorker = APIWorker()
    let urlManager = URLManager()
    let decoder = JSONDecoder()
    
    func userLogin(request: LoginModel.Request, completion: @escaping(LoginModel.Response?) -> ()) {
        if var urlRequest = urlManager.loginApi() {
            urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: request.toJSON(), options: [])
            apiWorker.postHttpRequest(urlRequest, callBack: { response in
                let statusCode = response.response?.statusCode
                if statusCode == 200 {
                    if let data = response.data {
                        let json = try! JSON(data: data)
                        do {
                            let loginResponse = try self.decoder.decode(LoginModel.Response.self, from: json.rawData())
                            completion(loginResponse)
                        } catch {
                            completion(nil)
                        }
                    }else{
                        completion(nil)
                    }
                }
            })
        }
    }
}
