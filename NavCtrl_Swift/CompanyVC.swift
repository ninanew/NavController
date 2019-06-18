//
//  CompanyVC.swift
//  NavCtrl_Swift
//
//  Created by Jesse Sahli on 2/22/17.
//  Copyright © 2017 turntotech. All rights reserved.
//

import UIKit
import CoreData

class CompanyVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var placeHolder: UIView!
    @IBOutlet weak var placeHolderImage: UIImageView!
    @IBOutlet weak var addCompanyButton: UIButton!
    
    var onCompanyTapped: ((Company) -> Void)?
    
    
    var companyList : [Company]?
    
    
    var productViewController : ProductVC?
    var editedCompanyView : EditCompanyVC?
    var tableData : [NSManagedObject]?
  //  let productViewManaged = ProductVC.share
    
    var timer = Timer()

    var networkPrice: Network!
    
    let dao = DAO.share
    
    override func viewDidLoad() {
        
        
        //letPrice(symbol: "AAPL")
        
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = editButtonItem
        
        self.navigationController?.navigationBar.backgroundColor = .green
        self.navigationController?.navigationBar.tintColor = .white

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toggleAdd))
        addCompanyButton.addTarget(self,  action: #selector(toggleAdd), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = addButton
        
        self.title = "Mobile Device Makers"
        
      
    
        // Do any additional setup after loading the view.
        
       // dao.createCompany()
        
//        networkPrice = Network(companyVC: self)
        networkPrice = Network()
        networkPrice.delegate = self
    
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { (_) in
            
            self.start()
            
            
        })
        
    }
    
   func start() {
        networkPrice.start()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableData = DAO.share.companiesObject
        
        
        
        companyList = dao.companies
        
        tableView.reloadData()
        
        isPlaceHolderHidden()
        
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
            tableView.setEditing(editing, animated: editing)
    }
    
    
    
    func isPlaceHolderHidden() {
//        if companyList?.count == nil || companyList?.count == 0
//        {
//            placeHolder.isHidden = false
//        } else {
//            placeHolder.isHidden = true
//        }
        if dao.companiesObject.count == 0
        {
            placeHolder.isHidden = false
        } else {
            placeHolder.isHidden = true
        }

    }
    
   @objc func toggleAdd() {
   
    let addCompanyVC = AddCompanyVC()
    self.navigationController?.pushViewController(addCompanyVC, animated: true)
    
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    @objc func toggleEditMode() {
        if self.navigationItem.leftBarButtonItem?.title == "Edit" {
            self.tableView.setEditing(true, animated: true)
            self.navigationItem.leftBarButtonItem?.title = "Done"
            isEditing = true
        } else {
            self.tableView.setEditing(false, animated: true)
            self.navigationItem.leftBarButtonItem?.title = "Edit"
            isEditing = false
        }
        
        isPlaceHolderHidden()
    }
}

extension CompanyVC: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        /*
        if let companyCount = self.companyList?.count {
            return companyCount

        } else {
            print("unknown number of rows... companyList is nil!")
            return 0
        }
         */

        return dao.companiesObject.count
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    private func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
         /*   companyList?.remove(at: indexPath.row)
            
            dao.deleteElementsAt(index: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade) */
            
            DAO.share.deleteCompanyFromCoreData(index: indexPath.row)
            self.tableData = DAO.share.companiesObject
            self.tableView.reloadData()
            self.isPlaceHolderHidden()
            
            
            
        //   isPlaceHolderHidden()
            
            
        
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
            dao.insert(index: indexPath.row)
            
            companyList!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
 //   func undoDeleteCompany(tableView: UITableView) {
        
   //     let oldCompany = self.companyList.
        
 //   }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedCompany = self.companyList![sourceIndexPath.row]
        companyList!.remove(at: sourceIndexPath.row)
        companyList!.insert(movedCompany, at: destinationIndexPath.row)
    
        
    }
    
    
//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        // Return NO if you do not want the item to be re-orderable.
//        return true
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier) as? CompanyTableViewCell else { return UITableViewCell(frame: .zero) }
        
        
        /*
        if let currentCompany = self.companyList?[indexPath.row] {
            cell.textLabel?.text = currentCompany.name
            print("here i show the price of \(currentCompany.name)")
            cell.detailTextLabel?.text = currentCompany.stockPrice?.price
            cell.imageView?.image = UIImage(named: currentCompany.imageUrl)

        } else {
            cell.textLabel?.text = "?"
        }
        */
        
           cell.onTap = { [weak self] in
            self?.onCompanyTapped?(<#Company#>)
        }
        
       let currentCompany = dao.companiesObject[indexPath.row]
        
        
        
        cell.textLabel?.text = currentCompany.value(forKey: "name") as? String
        cell.imageView?.image =  UIImage(named: currentCompany.imageUrl!)
        
        cell.detailTextLabel?.text = currentCompany.value(forKey: "stockPrice") as? String
        
        //
        
        return cell
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCompany = dao.companiesObject[indexPath.row]

       // currentCompany.products?.allObjects
//        productViewController?.title = productViewManaged.value(forKey: "name") as? String
//        productViewController?.image = productViewManaged.value(forKey: "imageUrl") as? String
//        productViewController?.image = productViewManaged.value(forKey: "productURL") as? String
        
        
        
        dao.selectedCoreCompany = currentCompany
        
        let productVC = ProductVC()
        
        productVC.title = currentCompany.name
        productVC.productsManaged = currentCompany.products?.allObjects as? [CoreProduct]
        
        self.navigationController?.pushViewController(productVC, animated: true)
        
        
        
    }
        
        /*
        
        guard let currentCompany = companyList?[indexPath.row] else { return }
        if isEditing {
            self.editedCompanyView = EditCompanyVC()
            self.editedCompanyView?.title = currentCompany.name
            editedCompanyView?.currentCompany = currentCompany
            editedCompanyView?.currentCompanyIndex = indexPath.row
            self.navigationController?.pushViewController(self.editedCompanyView!, animated: true)
        } else {
//            if currentCompany.products.isEmpty {
//                let companyAddOn = CompanyAddOn()
//                companyAddOn.companyList = currentCompany
//                companyAddOn.na
//                    .title = currentCompany.name
//                self.navigationController?.pushViewController(self.productViewController!, animated: true)
//
//            } else {
                self.productViewController = ProductVC()
                self.productViewController?.currentCompanyIndex = indexPath.row
                self.productViewController?.title = currentCompany.name
                productViewController?.products = currentCompany.products
                self.navigationController?.pushViewController(self.productViewController!, animated: true)
//            }
            
        }
 */
        
    
    
//    func updateTableView() {
//        self.companyList = DAO.share.companies
//        //Main Thread Checker: UI API called on a background thread:
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
    
}


extension CompanyVC: StockDelegate {
    func updated() {
        //companyList = dao.companies
        tableView.reloadData()
    }
}



