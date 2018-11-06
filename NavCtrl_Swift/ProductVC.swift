//
//  ProductVC.swift
//  NavCtrl_Swift
//
//  Created by Jesse Sahli on 2/22/17.
//  Copyright © 2017 turntotech. All rights reserved.
//

import UIKit

//don't forget - if you aren't going to be deriving subclasses from a class, mark it final
final class ProductVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!

    
<<<<<<< HEAD
    var products: [Product]?
    // var products: [String]?
    
=======
    var products: [String]?
>>>>>>> 8bbe0ef0ab3a964b54068ab060e4310b64041f8b
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let editBarButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditMode))
        self.navigationItem.rightBarButtonItem = editBarButton
        
<<<<<<< HEAD
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
    
    
    @IBOutlet weak var addProductButton: UIBarButtonItem!
    
    
=======
        if self.title == "Apple Mobile Devices" {
            self.products = ["Apple iPad Pro", "Apple iPod Touch", "Apple iPhone"]
        } else if self.title == "Samsung Mobile Devices" {
            self.products = ["Samsung Galaxy S9", "Samsung Galaxy Note", "Samsung Galaxy Tab"]
        } else if self.title == "Amazon Mobile Devices" {
            self.products = ["Amazon Echo Dot", "Amazon Echo", "Amazon Fire HD"]
        } else if self.title == "Microsoft Mobile Devices" {
            self.products = ["Windows Phone 8", "Microsoft Nokia Lumia", "Windows Surface"]
        }
        
        self.tableView.reloadData()
    }
>>>>>>> 8bbe0ef0ab3a964b54068ab060e4310b64041f8b
            
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
<<<<<<< HEAD
        let webView = WebView()
        guard let products = products else { return }
        let currentProduct = products[indexPath.row]
        webView.urlStr = currentProduct.productURL
        webView.title = currentProduct.name
        self.navigationController?.pushViewController(webView, animated: true)
        
=======
        //get your title
        if let productTitle = products?[indexPath.row] {
            let webView = WebView(withTitle: productTitle)
            //only use 'self.' syntax inside of a closure. it is taboo otherwise in swift
            navigationController?.pushViewController(webView, animated: true)
        }
>>>>>>> 8bbe0ef0ab3a964b54068ab060e4310b64041f8b
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //swift is smart enough to know that if you are using == on a UITableViewCellEditingStyle object, you don't need to use the whole name, just the part of the enum you are checking
        if editingStyle == .delete {
            // Delete the row from the data source
            products?.remove(at: indexPath.row)
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
