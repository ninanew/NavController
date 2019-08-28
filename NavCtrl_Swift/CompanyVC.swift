//
//  CompanyVC.swift
//  NavCtrl_Swift
//
//  Created by Jesse Sahli on 2/22/17.
//  Copyright © 2017 turntotech. All rights reserved.
//

import UIKit
import CoreData

final class CompanyVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var placeHolder: UIView!
    @IBOutlet weak var placeHolderImage: UIImageView!
    @IBOutlet weak var addCompanyButton: UIButton!
    
    //    Joel's code
    //    var onCompanyTapped: ((Company) -> Void)?
    
    
  //  var companyList : [Company]?
    var productViewController: ProductVC?
    var editedCompanyView: EditCompanyVC?
    
    var tableData: [Company]?
    
//    var timer = Timer()
//    var networkPrice: Network!
    
    let dao = DAO.share
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toggleAdd))
        addCompanyButton.addTarget(self,  action: #selector(toggleAdd), for: .touchUpInside)

        self.navigationItem.rightBarButtonItem = addButton

        self.title = "Mobile Device Makers"
        tableView.register(CompanyTableViewCell.self)
        
        self.tableData = DAO.readCompanies()

//        // Do any additional setup after loading the view.
//        let network = Network()
//        network.start()
//
//        network.stockUpdated = { [weak self] stock in
//            //self?.tableView.updateDate()
//            print(stock)
//        }
        
//        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { [weak self] _ in
////            self?.start()
//        })
        
        if let data = tableData, data.count > 0 {
            placeHolder.isHidden = true
            tableView.reloadData()
        } else {
            placeHolder.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableData = DAO.readCompanies()
        tableView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
            tableView.setEditing(editing, animated: editing)
    }
    
   @objc func toggleAdd() {
        let addCompanyVC = AddCompanyVC()
        self.navigationController?.pushViewController(addCompanyVC, animated: true)
    }

    @objc func toggleEditMode() {
        if self.navigationItem.leftBarButtonItem?.title == "Edit" {
            self.tableView.setEditing(true, animated: true)
            self.navigationItem.leftBarButtonItem?.title = "Done"
            tableView.isEditing = true
        } else {
            self.tableView.setEditing(false, animated: true)
            self.navigationItem.leftBarButtonItem?.title = "Edit"
            tableView.isEditing = false
        }
    }
}

extension CompanyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        
        return tableData?.count ?? 0
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let company = tableData?[indexPath.row] else { return }
            DAO.delete(company: company)
            tableData = DAO.readCompanies()
            self.tableView.reloadData()
        } else {
            //
        }
    }
    
    // Override to support editing the table view.
//    private func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        print("hi")
//        if editingStyle == .delete {
//            guard let company = tableData?[indexPath.row] else { return }
//            DAO.delete(company: company)
//            tableData = DAO.readCompanies()
//            self.tableView.reloadData()
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//            dao.insert(index: indexPath.row)
//         //   companyList!.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CompanyTableViewCell
        if let data = tableData?[indexPath.row] {
            cell.setup(with: data)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
  
        
        if let currentCompany = tableData?[indexPath.row] {
            
            if(isEditing){
                let vc = EditCompanyVC()
                vc.title = currentCompany.name
                vc.currentCompany = currentCompany
                navigationController?.pushViewController(vc, animated: true)
            }
            else {
                let productVc = ProductVC()
                productVc.title = currentCompany.name
                navigationController?.pushViewController(productVc, animated: true)
            }
            
        }
        
       
    }
}
