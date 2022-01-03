//
//  APIManager.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 03/01/22.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol ApiResult {
    var data : Data? {get}
    var error: Error? {get}
    var headers: [AnyHashable : Any]? {get}
}

struct Result: ApiResult {
    public var data: Data?
    public var error: Error?
    public var headers: [AnyHashable : Any]?
    public var response: HTTPURLResponse?
}

struct DecodableType: Decodable { let url: String }

typealias apiCallback = (Result) -> Void

class APIManager {
    static let sharedInstance = APIManager()
    
    init() {}
    
    func getHttpRequest(_ request: URLRequest, callback: @escaping apiCallback) {
        AF.request(request)
            .validate()
            .responseDecodable(of: DecodableType.self) { response in
                switch response.result {
                case .success(_):
                    if let result = response.data {
                        if let fields = response.response?.allHeaderFields as? [String:String] {
                            let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: (response.request?.url!)!)
                            HTTPCookieStorage.shared.setCookies(cookies, for: (response.request?.url!)!, mainDocumentURL: nil)
                        }
                        callback( Result(data: result, error: nil, headers: nil, response: response.response))
                    }
                case .failure(let error):
                    if let result = response.data {
                        if let fields = response.response?.allHeaderFields as? [String:String] {
                            let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: (response.request?.url!)!)
                            HTTPCookieStorage.shared.setCookies(cookies, for: (response.request?.url!)!, mainDocumentURL: nil)
                        }
                        callback( Result(data: result, error: error, headers: nil, response: response.response))
                    }
                }
            }
    }
    
    func postHttpRequest(_ request: URLRequest, _ token: String?="", ignoreToken: Bool, callback: @escaping apiCallback) {
        AF.request(request)
            .validate()
            .responseDecodable(of: DecodableType.self) { response in
                switch response.result {
                case .success(_):
                    if let result = response.data {
                        if let fields = response.response?.allHeaderFields as? [String:String] {
                            let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: (response.request?.url!)!)
                            HTTPCookieStorage.shared.setCookies(cookies, for: (response.request?.url!)!, mainDocumentURL: nil)
                        }
                        callback( Result(data: result, error: nil, headers: nil, response: response.response))
                    }
                case .failure(let error):
                    if let result = response.data {
                        if let fields = response.response?.allHeaderFields as? [String:String] {
                            let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: (response.request?.url!)!)
                            HTTPCookieStorage.shared.setCookies(cookies, for: (response.request?.url!)!, mainDocumentURL: nil)
                        }
                        callback( Result(data: result, error: error, headers: nil, response: response.response))
                    }
                }
            }
    }
}
