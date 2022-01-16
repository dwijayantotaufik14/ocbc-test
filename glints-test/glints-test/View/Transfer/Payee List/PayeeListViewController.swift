//
//  PayeeListViewController.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 16/01/22.
//

import UIKit

protocol PayeeListDelegate {
    func selectedPayee(id: String, name: String, accountNo: String)
}

class PayeeListViewController: UIViewController {
    
    @IBOutlet var payeeTableView: InstrinsicTableView!
    @IBOutlet var contentView: UIView!
    
    var viewModel: PayeesViewModel?
    var payeeList = [PayeesModel.PayeesData]()
    var loginToken: String = ""
    
    var delegate: PayeeListDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = PayeesViewModel()
        
        getPayeeList()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.roundCorners(corners: [.topRight, .topLeft], radius: 8)
    }
    
    func getPayeeList() {
        viewModel?.getPayeeList(loginToken, completion: { response, status, error  in
            
            DispatchQueue.main.async {
                if response != nil {
                    self.payeeList = response!
                    
                    DispatchQueue.main.async {
                        self.payeeTableView.register(PayeeListCell.nib, forCellReuseIdentifier: PayeeListCell.identifier)
                        self.payeeTableView.delegate = self
                        self.payeeTableView.dataSource = self
                        
                        self.payeeTableView.reloadData()
                    }
                }
            }
            
        })
    }

    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PayeeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payeeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PayeeListCell.identifier) as! PayeeListCell
        
        cell.accountId = payeeList[indexPath.row].id
        cell.accountNameLabel.text = payeeList[indexPath.row].name
        cell.accountNoLabel.text = payeeList[indexPath.row].accountNo
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
        
        let id = payeeList[indexPath.row].id!
        let accName = payeeList[indexPath.row].name!
        let accNo = payeeList[indexPath.row].accountNo!
        
        self.delegate?.selectedPayee(id: id, name: accName, accountNo: accNo)
    }
}
