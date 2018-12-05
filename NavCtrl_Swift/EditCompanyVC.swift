//
//  EditCompanyVC.swift
//  NavCtrl_Swift
//
//  Created by Kristina Neuwirth on 11/28/18.
//  Copyright © 2018 turntotech. All rights reserved.
//

import UIKit

class EditCompanyVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var editCompanyText: UITextField!
    @IBOutlet weak var editImageUrlText: UITextField!
    @IBOutlet weak var editStockTickerText: UITextField!
    
    var currentCompany: Company?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentCompany = currentCompany else { return }
        editCompanyText.text = currentCompany.name
        editImageUrlText.text = currentCompany.imageUrl
        editStockTickerText.text = currentCompany.stockTicker

    }
    
//    func editCompany() -> String {
//
//        guard let companyName = editCompanyText.text, companyName.isEmpty else {return ""}
//
//        let imageUrl = editImageUrlText.text ?? ""
//        let company = Company(name: companyName, imageUrl: editImageUrlText.text!, stockTicker: editStockTickerText.text!, products: [Product]())
//
//        return companyName
//
//    }
//
//    @objc func toggleSave() {
//
//        guard let companyName = editCompanyText.text else {
//            //error handling if is empty or somthing else
//            //error message for a user
//            return
//
//        }
//        guard let imageUrl = editImageUrlText.text,
//            let ticker = editStockTickerText.text
//            else { return }
//
//        DAO.share.addCompany(name: companyName, ticker: ticker, imageUrl: imageUrl)
//        self.navigationController?.popToRootViewController(animated: true)
//
//    }
//
//    @objc func toggleEditMode() {
//        self.navigationController?.popToRootViewController(animated: true)
//
//
//    }
//
//
//}
}


