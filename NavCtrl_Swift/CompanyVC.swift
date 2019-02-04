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
    @IBOutlet weak var placeHolder: UIView!
    @IBOutlet weak var placeHolderImage: UIImageView!
    @IBOutlet weak var addCompanyButton: UIButton!
    
    
    
    var companyList : [Company]?
    var productViewController : ProductVC?
    var editedCompanyView : EditCompanyVC?
    
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
        
        dao.createCompany()
        
        networkPrice = Network()
    
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (_) in
            self.start()
            
            
        })
        
    }
    
   func start() {
        networkPrice.start()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        companyList = dao.companies
        tableView.reloadData()
        
        isPlaceHolderHidden()
        
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
            tableView.setEditing(editing, animated: editing)
    }
    
    
    
    func isPlaceHolderHidden() {
        if companyList?.count == nil || companyList?.count == 0
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let companyCount = self.companyList?.count {
            return companyCount

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
            
            isPlaceHolderHidden()
        
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
            dao.insert(index: indexPath.row)
            
            companyList!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedCompany = self.companyList![sourceIndexPath.row]
        companyList!.remove(at: sourceIndexPath.row)
        companyList!.insert(movedCompany, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: CellIdentifier)
        
        
        if let currentCompany = self.companyList?[indexPath.row] {
            cell.textLabel?.text = currentCompany.name
            cell.detailTextLabel?.text = currentCompany.stockPrice?.price
            cell.imageView?.image = UIImage(named: currentCompany.imageUrl)

        } else {
            cell.textLabel?.text = "?"
        }
       
        return cell
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
        
    }
    
}




