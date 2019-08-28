//
//  ProductVC.swift
//  NavCtrl_Swift
//
//  Created by Jesse Sahli on 2/22/17.
//  Copyright © 2017 turntotech. All rights reserved.
//

import UIKit
import CoreData

//don't forget - if you aren't going to be deriving subclasses from a class, mark it final

class ProductVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var currentCompanyIndex: Int?
    var productsManaged : [CoreProduct]!
    var productView: ProductVC?
    var editedProductView : EditProductVC?
    
    let dao = DAO.share

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toggleAdd))
        self.navigationItem.rightBarButtonItem = addBarButton
    
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
       // return products?.count ?? 0
        return productsManaged?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: CellIdentifier)
        
        //configure the cell
        if let product = productsManaged?[indexPath.row] {
            cell.textLabel?.text = product.name
         //   let imgname = product.name
            cell.imageView?.image = UIImage(named: product.imageUrl!)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.editedProductView = EditProductVC()
        
        let currentProduct = productsManaged?[indexPath.row]
        
            guard let companyName = title else { return }
            let webView = WebView(with: currentProduct!.productURL!)
            webView.title = currentProduct!.name
            webView.currentCoreProduct = currentProduct
            webView.companyName = companyName
            self.navigationController?.pushViewController(webView, animated: true)
        }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true  
    }
    
    // Override to support rearranging the table view.
    // Override to support conditional rearranging of the table view.
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
        
        }
    
    }


