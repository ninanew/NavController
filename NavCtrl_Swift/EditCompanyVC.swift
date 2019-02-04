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
    @IBOutlet weak var delButBottomConstraint: NSLayoutConstraint!
    
    @IBAction func deleteCompany(_ sender: Any) {
        
        DAO.share.deleteElementsAt(index: currentCompanyIndex!)
        navigationController?.popViewController(animated: true)
    
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        
        UIView.animate(withDuration: 0.5) {
            self.delButBottomConstraint.constant = keyboardFrame.size.height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        UIView.animate(withDuration: 0.5) {
            self.delButBottomConstraint.constant = 209
            self.view.layoutIfNeeded()
        }
    }
    
    
    var currentCompany: Company?
    var currentCompanyIndex: Int?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        
        
        guard let currentCompany = currentCompany else { return }
        editCompanyText.text = currentCompany.name
        editImageUrlText.text = currentCompany.imageUrl
        editStockTickerText.text = currentCompany.stockTicker
        
    
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(toggleCancelMode))
        self.navigationItem.leftBarButtonItem = cancelBarButton
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(toggleSave))
        self.navigationItem.rightBarButtonItem = saveButton
        
        self.navigationController?.navigationBar.backgroundColor = .green
        self.navigationController?.navigationBar.tintColor = .white
        
        
    }
    
    
    
    @objc func toggleSave() {
        
        guard let companyName = editCompanyText.text else {
            //error handling if is empty or something else
            //error message for a user
            return
            
        }
        
        guard let imageUrl = editImageUrlText.text,
            let ticker = editStockTickerText.text
            else { return }
        guard let oldName = title else { return }
        DAO.share.editCompany(name: oldName, newName: companyName, ticker: ticker, imageUrl: imageUrl)
        self.navigationController?.popToRootViewController(animated: true)
        
        return
        
        }
    
    
    
    
    
    @objc func toggleCancelMode() {
        self.navigationController?.popToRootViewController(animated: true)
        
        
    }
    


}



