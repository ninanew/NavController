//
//  ProductVC.swift
//  NavCtrl_Swift
//
//  Created by Jesse Sahli on 2/22/17.
//  Copyright © 2017 turntotech. All rights reserved.
//

import UIKit

//don't forget - if you aren't going to be deriving subclasses from a class, mark it final

class ProductVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var currentCompanyIndex: Int?
    
    var products: [Product]?
    var productView: ProductVC?
    var editedProductView : EditProductVC?
    
    let dao = DAO.share
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toggleAdd))
        self.navigationItem.rightBarButtonItem = addBarButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let companyList = dao.companies
        guard let currentCompanyIndex = currentCompanyIndex else { return }
        let currentCompany = companyList[currentCompanyIndex]
        products = currentCompany.products
        
        if products!.isEmpty {
            let nib = Bundle.main.loadNibNamed("CompanyAddOn", owner: self, options: nil)?.first as! CompanyAddOn
            
            nib.frame = view.bounds
            nib.companyList = currentCompany
            nib.mainSet()
            view.addSubview(nib)
            
        } else  {
            tableView.reloadData()
        }
    }
    
    
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: editing)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @objc private func toggleEditMode() {
        if navigationItem.rightBarButtonItem?.title == "Edit" {
            self.tableView.setEditing(true, animated: true)
            self.navigationItem.rightBarButtonItem?.title = "Done"
            isEditing = true
        } else {
            self.tableView.setEditing(false, animated: true)
            self.navigationItem.rightBarButtonItem?.title = "Edit"
            isEditing = false 
        }
        
    }
    
    @objc private func toggleAdd() {
        let addVC = AddProductVC()
        guard let title = self.title else { return }
        addVC.companyName = title
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
}


extension ProductVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //no need for an if/else here, we can just use nil-coalescing
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: CellIdentifier)
        
        //configure the cell
        if let product = products?[indexPath.row] {
            cell.textLabel?.text = product.name
            cell.imageView?.image = UIImage(named: product.name)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.editedProductView = EditProductVC()
        
        guard let currentProduct = products?[indexPath.row] else { return }
        
//        if isEditing {
//            self.editedProductView = EditProductVC()
//            self.editedProductView?.title = currentProduct.name
//            editedProductView?.currentProduct = currentProduct
//            self.navigationController?.pushViewController(self.editedProductView!, animated: true)
//
//        } else {
            guard let companyName = title else { return }
            let webView = WebView(with: currentProduct.productURL)
            webView.title = currentProduct.name
            webView.currentProduct = currentProduct
            webView.companyName = companyName
            self.navigationController?.pushViewController(webView, animated: true)
//        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //swift is smart enough to know that if you are using == on a UITableViewCellEditingStyle object, you don't need to use the whole name, just the part of the enum you are checking
        if editingStyle == .delete {
            // Delete the row from the data source
            products?.remove(at: indexPath.row)
            //            dao.deleteProductsAt(index: indexPath.row, productName: <#String#>)
            tableView.reloadData()
            
        } //no need for an else-if here, cuz you don't care if it's not 'delete'
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true  
    }
    
    // Override to support rearranging the table view.
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedProduct = self.products![sourceIndexPath.row]
        products?.remove(at: sourceIndexPath.row)
        products?.insert(movedProduct, at: destinationIndexPath.row)
        
        
    }
    
    // Override to support conditional rearranging of the table view.
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
        
    }
    
}


