//
//  APIWorker.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 04/01/22.
//

import Foundation
import SwiftyJSON
import Alamofire

class APIWorker {
    static let sharedInstance = APIWorker()
    init() {}
    
    var apiManager : APIManager = APIManager.sharedInstance
    
    func getHttpRequest(_ withRequest: URLRequest, token: String? = "", callBack callback: @escaping apiCallback) {
        var request: URLRequest = withRequest
        var headerConstant = HeaderConstant.headerConstant
        let headersBuilder = HeadersBuilder.sharedInstance
        
        request.httpMethod = "GET"
        if token != "" {
            request.setValue(token!, forHTTPHeaderField: "Authorization")
        }
        
        request = headersBuilder.buildHeader(url: &request, headerConstants: &headerConstant)
        
        apiManager.getHttpRequest(request, callback: callback)
    }
    
    func postHttpRequest(_ withRequest: URLRequest, token: String? = "", callBack callback: @escaping apiCallback) {
        var request: URLRequest = withRequest
        var headerConstant = HeaderConstant.headerConstant
        let headersBuilder = HeadersBuilder.sharedInstance
        
        request.httpMethod = "POST"
        if token != "" {
            request.setValue(token!, forHTTPHeaderField: "Authorization")
        }
        
        request = headersBuilder.buildHeader(url: &request, headerConstants: &headerConstant)
        
        apiManager.postHttpRequest(request, callback: callback)
    }
}
