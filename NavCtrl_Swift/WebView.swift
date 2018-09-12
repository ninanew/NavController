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
        
        
        switch self.title {
        case "Apple iPad Pro":
            urlStr = "https://www.apple.com/ipad-pro/"
        
        case "Apple iPod Touch":
            urlStr = "https://www.apple.com/ipod-touch/"
    
        case "Apple iPhone":
            urlStr = "https://www.apple.com/iphone/"

        case "Samsung Galaxy S9":
            urlStr = "https://www.samsung.com/global/galaxy/galaxy-s9/"
        
        case "Samsung Galaxy Note":
            urlStr = "https://www.samsung.com/us/mobile/galaxy-note9/"
            
        case "Samsung Galaxy Tab":
            urlStr = "https://www.samsung.com/us/explore/tab-s4/?sem-mktg-pfs-tab-80118-22217"
            
        case "Amazon Echo Dot":
            urlStr = "https://www.amazon.com/gp/product/B01DFKC2SO?ref=ODS_HA_B_surl&tag=googhydr-20&hvadid=243971412886&hvpos=1t1&hvnetw=g&hvrand=11251785959057900677&hvpone=&hvptwo=&hvqmt=b&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9067609&hvtargid=kwd-330765436234&ref=pd_sl_5dhcl9gqwz_e"
        
        case "Amazon Echo":
            urlStr = "https://www.amazon.com/dp/B07456BG8N?tag=googhydr-20&hvadid=%7Bcreative%7D&hvpos=%7Badposition%7D&hvnetw=%7Bnetwork%7D&hvrand=%7Brandom%7D&hvpone=%7Bparam1%7D&hvptwo=%7Bparam2%7D&hvqmt=%7Bmatchtype%7D&hvdev=%7Bdevice%7D&hvdvcmdl=%7Bdevicemodel%7D&hvlocint=%7Bloc_interest_ms%7D&hvlocphy=%7Bloc_physical_ms%7D&hvtargid=%7Btargetid%7D&ref=pd_sl_3g07419rwu_e"
            
        case "Amazon Fire HD":
            urlStr = "https://www.amazon.com/dp/B01J6RPGKG"
            
        case "Windows Phone 8":
            urlStr = "https://www.microsoft.com/en-us/store/b/mobile"
            
        case "Microsoft Nokia Lumia":
            urlStr = "https://www.microsoft.com/en-ww/mobile/phones/lumia"
            
        case "Windows Surface":
            urlStr = "https://www.microsoft.com/en-us/store/b/surface?invsrc=search&cl_vend=google&cl_ch=sem&cl_camp=907269320&cl_adg=47974157511&cl_crtv=284450611193&cl_kw=+surface&cl_pub=google.com&cl_place=&cl_dvt=c&cl_pos=1t1&cl_mt=b&cl_gtid=kwd-488544306872&cl_pltr=&cl_dim0=W5brhAAAAYkj87pa:20180910220908:s&OCID=AID695933_SEM_W5brhAAAAYkj87pa:20180910220908:s&s_kwcid=AL!4249!3!284450611193!b!!g!!%2Bsurface&ef_id=W5brhAAAAYkj87pa:20180910220908:s"
        
        
        
        default:
            return
        }
        
        let url: URL = URL(string: urlStr)!
        let urlRequest: URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
   
    
    }
    
    
}
