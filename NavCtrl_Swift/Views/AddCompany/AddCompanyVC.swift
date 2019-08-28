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
            //TODO: error handling if is empty or somthing else
            //error message for a user
            //UIAlertController <- google this
            return 
        }
        
        DAO.share.saveCompanyToCoreData(name: companyName, imageUrl: nil, stockTicker: nil, stockPrice: nil)
        self.navigationController?.popToRootViewController(animated: true)

    }
    
    @objc func toggleEditMode() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

