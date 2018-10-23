//
//  EditCompany.swift
//  NavCtrl_Swift
//
//  Created by Kristina Neuwirth on 10/22/18.
//  Copyright © 2018 turntotech. All rights reserved.
//

import UIKit


class EditCompanyVC : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var editCompanyVC: UIViewController!
    @IBOutlet weak var companyNameText : UITextField!
    @IBOutlet weak var imageUrlText : UITextField!
    @IBOutlet weak var tickerText : UITextField!
    @IBOutlet weak var cancelButton : UIButton!
    @IBOutlet weak var saveButton : UIButton!
    
    
    @IBAction func textFieldDidBeginEditing(_ textField: UITextField) {
//        insertNewCompanyName()
//        guard let companyName = companyNameText.text, companyName.isEmpty else { return }
        //        guard imageUrl =
        //do somthing with companyName
        let companyName = getCompanyName()
        let imageUrl = imageUrlText.text ?? ""
        let company = Company(name: companyName, imageUrl: imageUrl, stockTicker: tickerText.text!, products: [Product]())
    }
    
    func getCompanyName() -> String {
        guard let companyName = companyNameText.text, companyName.isEmpty else { return "" }
        return companyName
    }
    
}


//func insertNewCompanyName() {
//
//    //  products.append(textField1.text!)
//
//
//}
