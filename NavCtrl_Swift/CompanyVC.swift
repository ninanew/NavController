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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var apple = Company(name: "Apple Mobile Devices", imageUrl: "Apple Mobile Devices", stockTicker: "", products: [Product]())
        
        let appleIPhone = Product(name: "Apple iPhone", imageUrl: "Apple iPhone")
        let appleIPadPro = Product(name: "Apple iPad Pro", imageUrl: "Apple iPad Pro")
        let appleIPadTouch = Product(name: "Apple iPad Touch", imageUrl: "Apple iPad Touch")
        
        
        var samsung = Company(name: "Samsung Mobile Devices", imageUrl: "Samsung Mobile Devices", stockTicker: "", products: [Product]())
        
        let samsungGalaxyS = Product(name: "Samsung Galaxy S9", imageUrl: "Samsung Galaxy S9")
        let samsungGalaxyTab = Product(name: "Samsung Galaxy Tab", imageUrl: "Samsung Galaxy Tab")
        let samsungGalaxyNote = Product(name: "Samsung Galaxy Note", imageUrl: "Samsung Galaxy Note")
        
        
        var amazon = Company(name: "Amazon Mobile Devices", imageUrl: "Amazon Mobile Devices", stockTicker: "", products: [Product]())
        
        let amazonEcho = Product(name: "Amazon Echo", imageUrl: "Amazon Echo")
        let amazonFireHD = Product(name: "Amazon Fire HD", imageUrl: "Amazon Fire HD")
        let amazonEchoDot = Product(name: "Amazon Echo Dot", imageUrl: "Amazon Echo Dot")
        
        
        var microsoft = Company(name: "Microsoft Mobile Devices", imageUrl: "Microsoft Mobile Devices", stockTicker: "", products: [Product]())
        
        let microsoftNokiaLumia = Product(name: "Microsoft Nokia Lumia", imageUrl: "Microsoft Nokia Lumia")
        let windowsPhone = Product(name: "Windows Phone 8", imageUrl: "Windows Phone 8")
        let windowsSurface = Product(name: "Windows Surface", imageUrl: "Windows Surface")
        

        apple.products.append(appleIPhone)
        apple.products.append(appleIPadPro)
        apple.products.append(appleIPadTouch)
        
        samsung.products.append(samsungGalaxyS)
        samsung.products.append(samsungGalaxyTab)
        samsung.products.append(samsungGalaxyNote)
        
        amazon.products.append(amazonEcho)
        amazon.products.append(amazonFireHD)
        amazon.products.append(amazonEchoDot)
        
        microsoft.products.append(microsoftNokiaLumia)
        microsoft.products.append(windowsPhone)
        microsoft.products.append(windowsSurface)
        
        //create edit button
        let editBarButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditMode))
        self.navigationItem.rightBarButtonItem = editBarButton
        
        self.title = "Mobile Device Makers"
        // Do any additional setup after loading the view.
        
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

            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
        
        
        
        if let currentCompanyName = self.companyList?[indexPath.row] {
            cell.textLabel?.text = currentCompanyName.name
            cell.imageView?.image = UIImage(named: currentCompanyName.imageUrl)
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
//        self.productViewController?.title = cell?.textLabel?.text
        
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
    


