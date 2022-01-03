//
//  Settings.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 03/01/22.
//

import Foundation

struct Settings {
    static var shared = Settings()
    let baseUrl: String
    
    private init() {
        let path = Bundle.main.path(forResource: "Info", ofType: "plist")
        let plist = NSDictionary(contentsOfFile: path!) as! [AnyHashable: Any]
        let settings = plist["AppSettings"] as! [AnyHashable: Any]
        
        baseUrl = settings["BaseApiUrl"] as! String
    }
}
