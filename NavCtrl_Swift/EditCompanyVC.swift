//
//  EditCompanyVC.swift
//  NavCtrl_Swift
//
//  Created by Kristina Neuwirth on 11/28/18.
//  Copyright © 2018 turntotech. All rights reserved.
//

import UIKit
import SnapKit

class EditCompanyVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var editCompanyText: UITextField!
    @IBOutlet weak var editImageUrlText: UITextField!
    @IBOutlet weak var editStockTickerText: UITextField!
    @IBOutlet weak var delButBottomConstraint: NSLayoutConstraint!
    
    @IBAction func deleteCompany(_ sender: Any) {
        
      //  DAO.share.deleteElementsAt(index: currentCompanyIndex!)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
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
        
        view.addSubview(editCompanyText)
        editCompanyText.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(20)
            make.edges.equalToSuperview()
            make.center.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        
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
        DAO.share.editCompany(name: oldName, imageUrl: imageUrl, stockTicker: companyName, stockPrice: <#Stock?#>)
        self.navigationController?.popToRootViewController(animated: true)
        
        return
        
        }
    
    
    
    
    
    @objc func toggleCancelMode() {
        self.navigationController?.popToRootViewController(animated: true)
        
        
    }
    


}



