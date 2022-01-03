//
//  HeaderBuilder.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 04/01/22.
//

import Foundation

class HeadersBuilder {
    static let sharedInstance = HeadersBuilder()

    func buildHeader(url: inout URLRequest, headerConstants: inout [String: String]) -> URLRequest {
        
        for (key, value) in headerConstants {
            if value != "" {
                url.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return url
    }
}
