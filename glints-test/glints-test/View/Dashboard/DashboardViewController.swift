//
//  DashboardViewController.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 15/01/22.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet var balanceLabel: UILabel!
    @IBOutlet var accountNoLabel: UILabel!
    @IBOutlet var accountNameLabel: UILabel!
    @IBOutlet var headerView: UIView!
    
    @IBOutlet var transactionHistoryTableView: UITableView!
    
    @IBOutlet var makeTransferButton: UIButton!
    
    
    var loginResponse : LoginModel.Response?
    
    var balanceViewModel = BalanceViewModel()
    var transactionViewModel = TransactionsViewModel()
    
    var groupedTransaction = TransactionsModel.GroupedTransactions()
    var sections = Dictionary<String, Array<TransactionsModel.Response>>()
    var sortedSections = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBalanceAccount()
        getTransactionHistory()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.headerView.roundCorners(corners: [.topRight, .bottomRight], radius: 8)
        
        makeTransferButton.layer.cornerRadius = makeTransferButton.frame.height / 2
    }
    
    func getBalanceAccount() {
        balanceViewModel.getBalanceAccount(self.loginResponse!.token!, completion: { response, status, error  in
            DispatchQueue.main.async {
                self.accountNameLabel.text = self.loginResponse?.username
                self.accountNoLabel.text = response?.accountNo
                self.balanceLabel.text = "SGD \(response!.balance!.formattedWithSeparator)"
            }
            
        })
    }
    
    func getTransactionHistory() {
        transactionViewModel.getTransactionsHistory(self.loginResponse!.token!, completion: { response, status, error  in
            self.groupedTransaction = response!
            self.sections = self.groupedTransaction.transactions ?? ["" : [TransactionsModel.Response]()]
            let sortedDate = self.sortDate(arrayOfDateString: self.groupedTransaction.transactionDate ?? [""], order: .orderedDescending)
            self.sortedSections = sortedDate
            
            self.transactionHistoryTableView.register(TransactionHistoryCell.nib, forCellReuseIdentifier: TransactionHistoryCell.identifier)
            
            self.transactionHistoryTableView.delegate = self
            self.transactionHistoryTableView.dataSource = self
            
            self.transactionHistoryTableView.reloadData()
        })
    }
    
    func sortDate(arrayOfDateString:[String], order: ComparisonResult)->[String]{
        var convertedArray: [Date] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        for dat in arrayOfDateString {
            let date = dateFormatter.date(from: dat)
            
            if let xDate = date {
                convertedArray.append(xDate)
            }
        }
        
        let sortedDate = convertedArray.sorted(by: { $0.compare($1) == order })
        let arrayOfSortedString = sortedDate.map{ dateFormatter.string(from: $0) }
        
        return arrayOfSortedString
    }

    @IBAction func logoutButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func gotoTransferPage(_ sender: Any) {
        let vc = TransferViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.loginResponse = self.loginResponse
        
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[sortedSections[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionHistoryCell.identifier) as! TransactionHistoryCell
        
        let tableSection = sections[sortedSections[indexPath.section]]?[indexPath.row]
        
        
        let transType = tableSection?.transactionType
        
        if transType == "transfer" {
            cell.accountNoLabel.text = tableSection?.receipient?.accountNo
            cell.accountNameLabel.text = tableSection?.receipient?.accountHolder
            cell.amountLabel.textColor = UIColor.init(red: 97.0/255.0, green: 97.0/255.0, blue: 97.0/255.0, alpha: 1.0)
            cell.amountLabel.text = "- \(tableSection!.amount!.formattedWithSeparator)"
        }else{
            cell.accountNoLabel.text = tableSection?.sender?.accountNo
            cell.accountNameLabel.text = tableSection?.sender?.accountHolder
            cell.amountLabel.textColor = UIColor.init(red: 59.0/255.0, green: 198.0/255.0, blue: 52.0/255.0, alpha: 1.0)
            cell.amountLabel.text = tableSection!.amount!.formattedWithSeparator
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.init(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)
    
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont(name: "Roboto-Bold", size: 12)
        headerLabel.textColor = UIColor.init(red: 157.0/255.0, green: 157.0/255.0, blue: 157.0/255.0, alpha: 1.0)
        headerLabel.text = sortedSections[section]
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 0).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 24).isActive = true
        
        return headerView
    }
    
}
