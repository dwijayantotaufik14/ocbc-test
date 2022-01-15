//
//  TransactionsViewModel.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 04/01/22.
//

import Foundation
import SwiftyJSON

class TransactionsViewModel {
    let apiWorker = APIWorker()
    let urlManager = URLManager()
    let decoder = JSONDecoder()
    
    func getTransactionsHistory(_ token: String?, completion: @escaping(TransactionsModel.GroupedTransactions?, String?, String?) -> ()) {
        if let urlRequest = urlManager.getTransactionApi() {
            apiWorker.getHttpRequest(urlRequest, token: token, callBack: { response in
                
                var detailTransaction = [TransactionsModel.Response]()
                
                let statusCode = response.response!.statusCode
                if let data = response.data {
                    let json = try! JSON(data: data)
                    let jsonData = json["data"]
                    print("RESPONSE : \(jsonData)")
                    let jsonStatus = json["status"].stringValue
                    let jsonError = json["error"].stringValue
                    
                    if statusCode == 200 {
                        do {
                            let transactionResponse = try self.decoder.decode([TransactionsModel.Response].self, from: jsonData.rawData())
                            var groupedTransaction = TransactionsModel.GroupedTransactions.init(transactions: ["": transactionResponse], transactionDate: [""])
                            groupedTransaction.transactions?.removeAll()
                            groupedTransaction.transactionDate?.removeAll()
                            
                            transactionResponse.forEach({ transaction in
                                let transactionDate = transaction.transactionDate
                                if let convertedDate = self.convertStringToFormattedDateInString(transactionDate!) {
                                    if !(groupedTransaction.transactionDate?.contains(convertedDate) ?? true) {
                                        groupedTransaction.transactionDate?.append(convertedDate)
                                    }else{
                                        print("Array of notif date already have \(convertedDate)")
                                    }

                                }
                            })
                            
                            for uniqueDate in groupedTransaction.transactionDate ?? [""] {
                                let filteredTransactions = transactionResponse.filter({self.convertStringToFormattedDateInString($0.transactionDate!) == uniqueDate})
                                for trans in filteredTransactions {
                                    var transDetail = TransactionsModel.Response.init()
                                    transDetail.transactionId = trans.transactionId
                                    transDetail.amount = trans.amount
                                    transDetail.transactionType = trans.transactionType
                                    transDetail.receipient = trans.receipient
                                    transDetail.sender = trans.sender
                                    transDetail.description = trans.description
                                    
                                    detailTransaction.append(transDetail)
                                }
                                groupedTransaction.transactions?[uniqueDate] = detailTransaction
                                detailTransaction.removeAll()
                            }
                            
                            completion(groupedTransaction, jsonStatus, jsonError)
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
    
    func convertStringToFormattedDateInString(_ dateFull:String)->String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        if let dateInDate = dateFormatter.date(from: dateFull){
            dateFormatter.dateFormat = "dd MMM yyyy"
            let dateFormattedInString = dateFormatter.string(from: dateInDate)
            return dateFormattedInString
        }else{
            return nil
        }
    }
}
