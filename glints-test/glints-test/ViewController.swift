//
//  ViewController.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 03/01/22.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    let apiWorker = APIWorker()
    let urlManager = URLManager()
    let decoder = JSONDecoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MWQzNTNhNDM0NGFhMjhlOGViMjcyYzkiLCJ1c2VybmFtZSI6InRlc3RQb3N0IiwiYWNjb3VudE5vIjoiNzU4MS00ODQtNDE4NSIsImlhdCI6MTY0MTI0MDUxNSwiZXhwIjoxNjQxMjUxMzE1fQ._VNZ2A-DoO4JNqtN8h_xnYggaUpfk5-TaHdzhzaAk1A"
        
        if let urlRequest = urlManager.getBalanceApi() {
            apiWorker.getHttpRequest(urlRequest, token: token, callBack: { response in
                let statusCode = response.response!.statusCode
                if statusCode == 200 {
                    if let data = response.data {
                        let json = try! JSON(data: data)
                        
                        do {
                            let goodsReceiptResponse = try self.decoder.decode(BalanceModel.Response.self, from: json.rawData())
                            print(goodsReceiptResponse)
                        } catch {
                            print("ERROR")
                            
                        }
                    }
                }else{
                    print("ERROR")
                }
            })
        }
    }


}
