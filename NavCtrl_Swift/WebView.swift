//
//  ViewController.swift
//  NavCtrl_Swift
//
//  Created by Kristina Neuwirth on 9/4/18.
//  Copyright © 2018 turntotech. All rights reserved.
//

import UIKit
import WebKit


class WebView: UIViewController, WKNavigationDelegate {
    
    var webView = WKWebView()
    
    var companyName: String?
    var currentProduct: Product?
    
    init(with stringUrl: String) {
        super.init(nibName: "WebView", bundle: nil)
        guard let url = URL(string: stringUrl) else { return }
        view = webView
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
        
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditMode))
        self.navigationItem.rightBarButtonItem = editButton
        self.navigationItem.leftBarButtonItem?.title = "Back"
        
        self.navigationController?.navigationBar.backgroundColor = .green
        self.navigationController?.navigationBar.tintColor = .white
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggleEditMode() {
        let editVC = EditProductVC()
        guard let companyName = companyName, let currentProduct = currentProduct else { return }
        editVC.currentProduct = currentProduct
        editVC.companyName = companyName
        self.navigationController?.pushViewController(editVC, animated: true)
        
    }

}


