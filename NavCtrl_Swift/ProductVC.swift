//
//  ProductVC.swift
//  NavCtrl_Swift
//
//  Created by Jesse Sahli on 2/22/17.
//  Copyright © 2017 turntotech. All rights reserved.
//

import UIKit

class ProductVC: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
    
    var products: [Product]?
    
//    var products: [String]?
    var webView: WebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let editBarButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditMode))
        self.navigationItem.rightBarButtonItem = editBarButton
        // Do any additional setup after loading the view.
        
        
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        if self.title == "Apple Mobile Devices" {
//            self.products = ["Apple iPad Pro", "Apple iPod Touch", "Apple iPhone"]
//        } else if self.title == "Samsung Mobile Devices" {
//            self.products = ["Samsung Galaxy S9", "Samsung Galaxy Note", "Samsung Galaxy Tab"]
//        } else if self.title == "Amazon Mobile Devices" {
//            self.products = ["Amazon Echo Dot", "Amazon Echo", "Amazon Fire HD"]
//        } else if self.title == "Microsoft Mobile Devices" {
//            self.products = ["Windows Phone 8", "Microsoft Nokia Lumia", "Windows Surface"]
//        }
//
//        self.tableView.reloadData()
//
//
    }
    

    
    
    
    
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
        
        // Dispose of any resources that can be recreated.
    }
    
 


}



extension ProductVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // Return the number of rows in the section.
        if let productCount = self.products?.count {
            return productCount
        } else {
            print("unknown number of rows... \"products\" property is nil!")
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: CellIdentifier)
        
        //configure the cell
        if let product = products?[indexPath.row] {
//            cell.textLabel?.text = product
//            cell.imageView?.image = UIImage(named: product)
        }
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        webView = WebView()
        
 //       webView?.title = products?[indexPath.row]
        self.navigationController?.pushViewController(self.webView!, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            // Delete the row from the data source
            products?.remove(at: indexPath.row)
            tableView.reloadData()
            
        } else if editingStyle == .insert {}

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
    
    /*
    // In a xib-based application, navigation from a table can be handled in didSelectRowAt..
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Navigation logic may go here, for example:
        // Create the next view controller.
        let detailViewController = DetailVC()
        // Pass the selected object to the new view controller.
        
        // Push the view controller.
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
*/
    
}

