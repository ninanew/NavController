//
//  EditProductVC.swift
//  NavCtrl_Swift
//
//  Created by Kristina Neuwirth on 11/28/18.
//  Copyright © 2018 turntotech. All rights reserved.
//


import UIKit

class EditProductVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var editProductText: UITextField!
    @IBOutlet weak var editProductUrlText: UITextField!
    @IBOutlet weak var editProductImageText: UITextField!
    
    @IBOutlet weak var delButBottomConstraint: NSLayoutConstraint!
    
    @IBAction func deleteProduct(_ sender: Any) {
        
        guard let companyName = companyName, let productOldName = title else { return }
        DAO.share.deleteProductsAt(companyName: companyName, productName: productOldName)
//
//
//        reloadInputViews()
        
        navigationController?.popToViewController((navigationController?.viewControllers[1])! , animated: true)
    
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
    
    var currentProduct : Product?
    var companyName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(toggleCancel))
        self.navigationItem.leftBarButtonItem = cancelBarButton
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(toggleSave))
        self.navigationItem.rightBarButtonItem = saveButton
        
        self.navigationController?.navigationBar.backgroundColor = .green
        self.navigationController?.navigationBar.tintColor = .white
        
        guard let currentProduct = currentProduct else {
            print("ERROR: No DATA about product!")
            return }
        
        title = currentProduct.name
        
        editProductText.text = currentProduct.name
        editProductUrlText.text = currentProduct.productURL
        editProductImageText.text = currentProduct.imageUrl
        
        
        
        //    let webView = WebView(with: currentProduct.productURL)
        //        webView.title = currentProduct.name
        //        self.navigationController?.pushViewController(webView, animated: true)
        
    }
    
    @objc func toggleSave() {
        
        guard let newProductName = editProductText.text else {
            //error handling if is empty or somthing else
            //error message for a user
            return
            
        }
        guard let imageUrl = editProductImageText.text,
            let productUrl = editProductUrlText .text
            else { return }
        guard let companyName = companyName, let productOldName = title else { return }
        DAO.share.editProduct(companyName: companyName, productName: productOldName, newProductName: newProductName, imageUrl: imageUrl, productURL: productUrl)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func toggleCancel() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
