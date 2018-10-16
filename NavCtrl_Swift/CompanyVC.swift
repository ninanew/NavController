//
//  CompanyVC.swift
//  NavCtrl_Swift
//
//  Created by Jesse Sahli on 2/22/17.
//  Copyright © 2017 turntotech. All rights reserved.
//

import UIKit

class CompanyVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var companyList : [Company]?
    var productViewController : ProductVC?

    
    let dao = DAO.share
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
        //create edit button
        let editBarButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditMode))
        self.navigationItem.rightBarButtonItem = editBarButton
        
        self.title = "Mobile Device Makers"
        // Do any additional setup after loading the view.
        
//        let dao = DAO.share
        
        dao.createCompany()
        companyList = dao.companies
    }
    
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == UITableViewCellEditingStyle.delete {
//            // Delete the row from the data source
//            companyList?.remove(at: indexPath.row)
//
//        } else if editingStyle == .insert {}
//
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    @objc func toggleEditMode() {
        if self.navigationItem.rightBarButtonItem?.title == "Edit" {
            self.tableView.setEditing(true, animated: true)
            self.navigationItem.rightBarButtonItem?.title = "Done"
        } else {
            self.tableView.setEditing(false, animated: true)
            self.navigationItem.rightBarButtonItem?.title = "Edit"
        }
    
    }

}

// MARK: delegate & datasource methods

extension CompanyVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let companyCount = self.companyList?.count {
            return companyCount
//            return dao.companies.count
        } else {
            print("unknown number of rows... companyList is nil!")
            return 0
        }
        
    }
        
        
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            companyList?.remove(at: indexPath.row)
            
            dao.deleteElementsAt(index: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        
        
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
            dao.insert(index: indexPath.row)
            
        }
    }
 
    
    
  
    // Override to support rearranging the table view
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
     
        let movedCompany = self.companyList![sourceIndexPath.row]
        companyList?.remove(at: sourceIndexPath.row)
        companyList?.insert(movedCompany, at: destinationIndexPath.row)
        
        
     }
 
    // Override to support conditional rearranging of the table view.
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier) ??
        UITableViewCell(style: .subtitle, reuseIdentifier: CellIdentifier)
        
        
        
        if let currentCompany = self.companyList?[indexPath.row] {
            cell.textLabel?.text = currentCompany.name
            cell.imageView?.image = UIImage(named: currentCompany.imageUrl)
//            cell.textLabel?.text = currentCompanyName
//            cell.imageView?.image = UIImage(named: currentCompanyName)
        } else {
            cell.textLabel?.text = "?"
        }
       return cell
    }
    
    
    // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.productViewController = ProductVC()
        
//        let cell = tableView.cellForRow(at: indexPath)
        guard let currentCompany = companyList?[indexPath.row] else { return }
        productViewController?.products = currentCompany.products
        self.productViewController?.title = currentCompany.name
        
//        if indexPath.row == 0 {
//            self.productViewController?.title = "Apple Mobile Devices"
//        } else if indexPath.row == 1  {
//            self.productViewController?.title = "Samsung Mobile Devices"
//        }  else if indexPath.row == 2 {
//            self.productViewController?.title = "Amazon Mobile Devices"
//        }  else if indexPath.row == 3 {
//            self.productViewController?.title = "Microsoft Mobile Devices"
//        }
        self.navigationController?.pushViewController(self.productViewController!, animated: true)
        
        }

    }
    


