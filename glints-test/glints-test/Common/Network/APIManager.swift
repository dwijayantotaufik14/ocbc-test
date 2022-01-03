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

typealias apiCallback = (Result) -> Void

class APIManager {
    static let sharedInstance = APIManager()
    
    init() {}
    
    func getHttpRequest()
}
