//
//  AddCompanyVC.swift
//  NavCtrl_Swift
//
//  Created by Kristina Neuwirth on 10/22/18.
//  Copyright © 2018 turntotech. All rights reserved.
//

import UIKit


class AddCompanyVC : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var companyNameText : UITextField!
    @IBOutlet weak var imageUrlText : UITextField!
    @IBOutlet weak var tickerText : UITextField!
    
    var isAdding = false
    
    func getCompanyName() -> String {
        guard let companyName = companyNameText.text, companyName.isEmpty else { return "" }
        
        
        let imageUrl = imageUrlText.text ?? ""
//        let company = Company(name: companyName, imageUrl: imageUrl, stockTicker: tickerText.text!, products: [Product](), stockPrice: nil)
        
        return companyName
        
    }
    
    override func viewDidLoad() {
        
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(toggleEditMode))
        self.navigationItem.leftBarButtonItem = cancelBarButton
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(toggleSave))
        self.navigationItem.rightBarButtonItem = saveButton
        
        self.navigationController?.navigationBar.backgroundColor = .green
        self.navigationController?.navigationBar.tintColor = .white
        
    }
    
    @objc func toggleSave() {
        guard let companyName = companyNameText.text else {
            //error handling if is empty or somthing else
            //error message for a user
            return 
        }
        guard let imageUrl = imageUrlText.text,
            let ticker = tickerText.text
            else { return }
        
        //DAO.share.addCompany(name: companyName, ticker: ticker, imageUrl: imageUrl)
        DAO.share.saveCompanyToCoreData(name: companyName, imageUrl: imageUrl, stockTicker: ticker, stockPrice: nil)
        self.navigationController?.popToRootViewController(animated: true)

    }
    
    @objc func toggleEditMode() {
        self.navigationController?.popToRootViewController(animated: true)
//        if self.navigationItem.rightBarButtonItem?.title == "Save" {
//            self.editCompanyVC.setEditing(true, animated: true)
//            self.navigationItem.rightBarButtonItem?.title = "Cancel"
//        } else {
//            self.editCompanyVC.setEditing(false, animated: true)
//            self.navigationItem.rightBarButtonItem?.title = "Save"
//        }
    
    }

}

