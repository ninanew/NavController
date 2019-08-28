//
//  AddProductVC.swift
//  NavCtrl_Swift
//
//  Created by Kristina Neuwirth on 10/16/18.
//  Copyright © 2018 turntotech. All rights reserved.
//

import UIKit

class AddProductVC : UIViewController, UITextFieldDelegate {
    
    @IBOutlet var productNameText: UITextField!
    @IBOutlet var imageUrlText: UITextField!
    @IBOutlet var productURLText: UITextField!
    
    
    
    var companyName: String?
    
    func getProductName() -> String {
        
        guard let productName = productNameText.text, productName.isEmpty else { return "" }
        
        let imageUrl = imageUrlText.text ?? ""
        let product = Product(name: productName, imageUrl: imageUrl, productURL: "")
        
        return productName
        
        
    }
    
    override func viewDidLoad() {
        
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(toggleCancel))
        self.navigationItem.leftBarButtonItem = cancelBarButton
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(toggleSave))
        self.navigationItem.rightBarButtonItem = saveButton
        
        self.navigationController?.navigationBar.backgroundColor = .green
        self.navigationController?.navigationBar.tintColor = .white
        
    }
    
    @objc func toggleSave() {
        guard let productName = productNameText.text else {
            //error handling if is empty or somthing else
            //error message for a user
            return
        }
        guard let imageUrl = imageUrlText.text,
            let productURL = productURLText.text
         //   let companyName = companyName
            else { return }
        
         DAO.share.saveProductToCoreData(name: productName, imageUrl: imageUrl, productURL: productURL)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func toggleCancel() {

        self.navigationController?.popViewController(animated: true)
    }
}








