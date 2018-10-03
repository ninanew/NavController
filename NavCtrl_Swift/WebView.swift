//
//  ViewController.swift
//  NavCtrl_Swift
//
//  Created by Kristina Neuwirth on 9/4/18.
//  Copyright © 2018 turntotech. All rights reserved.
//

import Foundation
import WebKit


class WebView: UIViewController, WKNavigationDelegate {
    
@IBOutlet weak var webView: WKWebView!

    
    
// @IBAction weak var backButton: UIButton!
    
// maybe switch statement between products and urls
    
    var urlStr = String()
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear( animated )
        
        guard let url: URL = URL(string: urlStr) else  {
            print("ERROR: Not correct link!")
            return
        }
        
        let urlRequest: URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
   
    
    }
    
    
}
