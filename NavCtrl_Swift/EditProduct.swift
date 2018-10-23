//
//  EditProduct.swift
//  NavCtrl_Swift
//
//  Created by Kristina Neuwirth on 10/16/18.
//  Copyright © 2018 turntotech. All rights reserved.
//

import Foundation
import UIKit

class EditProductVC : UIViewController, UITextFieldDelegate {

    @IBOutlet weak var editProductVC: UIViewController!
    @IBOutlet weak var companyNameText : UITextField!
    @IBOutlet weak var imageUrlText : UITextField!
    @IBOutlet weak var tickerLblText : UITextField!
    @IBOutlet weak var cancelButton : UIButton!
    @IBOutlet weak var saveButton : UIButton!
    
    
    @IBAction func textFieldDidBeginEditing(_ textField: UITextField) {
        
        insertNewProductName()
        
        
        guard let companyName = companyNameText.text, companyName.isEmpty else { return }
        guard let imageUrl = imageUrlText.text, imageUrl.isEmpty else { return }
        guard let tickerLbl = tickerLblText.text, tickerLbl.isEmpty else { return }
        //do somthing with companyName

        let company = Company(name: companyName, imageUrl: <#T##String#>, stockTicker: <#T##String#>, products: [Product]())
    }
    
}


func insertNewProductName() {
    
  //  products.append(textField1.text!)
    
    
}

        
        
        
        
        
        
