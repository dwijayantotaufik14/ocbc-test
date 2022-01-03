//
//  URLManager.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 03/01/22.
//

import Foundation

class URLManager {
    init() {}
    
    private func parseStringToURL(urlString: String) -> URLRequest? {
        if let url = URL(string: urlString) {
            return URLRequest(url: url)
        }
        return nil
    }
    
    func loginApi() -> URLRequest? {
        let urlString = URLConstant.loginApi
        return parseStringToURL(urlString: urlString)
    }
    
    func registerApi() -> URLRequest? {
        let urlString = URLConstant.registerApi
        return parseStringToURL(urlString: urlString)
    }
    
    func getBalanceApi() -> URLRequest? {
        let urlString = URLConstant.getBalanceApi
        return parseStringToURL(urlString: urlString)
    }
    
    func getPayeeApi() -> URLRequest? {
        let urlString = URLConstant.getPayeeApi
        return parseStringToURL(urlString: urlString)
    }
    
    func getTransactionApi() -> URLRequest? {
        let urlString = URLConstant.getTransactionApi
        return parseStringToURL(urlString: urlString)
    }
    
    func transferApi() -> URLRequest? {
        let urlString = URLConstant.transferApi
        return parseStringToURL(urlString: urlString)
    }
}
