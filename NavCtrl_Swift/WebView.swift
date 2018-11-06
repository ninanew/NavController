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
    
<<<<<<< HEAD
@IBOutlet weak var webView: WKWebView!

    
    
// @IBAction weak var backButton: UIButton!
    
// maybe switch statement between products and urls
    
    var urlStr = String()
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
=======
    //always have space before a 'prop' (property) declaration
    let webView = WKWebView() //no reason for an IBOutlet here, so just initialize you're webview with the view
//    var urlStr = String() //this doesn't need to be a class var, a local one will do just fine
    
    init(withTitle title: String) {
        //call a super init - i use this one. why? I have no idea, I just do
        super.init(nibName: nil, bundle: nil)
        //and use self in initializers
        self.title = title
        self.view = webView
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
>>>>>>> 8bbe0ef0ab3a964b54068ab060e4310b64041f8b
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
<<<<<<< HEAD
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear( animated )
        
        guard let url: URL = URL(string: urlStr) else  {
            print("ERROR: Not correct link!")
            return
        }
        
        let urlRequest: URLRequest = URLRequest(url: url)
=======
    private func setup() {
        var urlString = "" //give it some value, avoid the optional hassle, and use the full 'urlString', this ain't 1998, no reason to be appreviating variable names
        
        switch self.title {
        case "Apple iPad Pro":
            urlString = "https://www.apple.com/ipad-pro/"
            
        case "Apple iPod Touch":
            urlString = "https://www.apple.com/ipod-touch/"
            
        case "Apple iPhone":
            urlString = "https://www.apple.com/iphone/"
            
        case "Samsung Galaxy S9":
            urlString = "https://www.samsung.com/global/galaxy/galaxy-s9/"
            
        case "Samsung Galaxy Note":
            urlString = "https://www.samsung.com/us/mobile/galaxy-note9/"
            
        case "Samsung Galaxy Tab":
            urlString = "https://www.samsung.com/us/explore/tab-s4/?sem-mktg-pfs-tab-80118-22217"
            
        case "Amazon Echo Dot":
            urlString = "https://www.amazon.com/gp/product/B01DFKC2SO?ref=ODS_HA_B_surl&tag=googhydr-20&hvadid=243971412886&hvpos=1t1&hvnetw=g&hvrand=11251785959057900677&hvpone=&hvptwo=&hvqmt=b&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9067609&hvtargid=kwd-330765436234&ref=pd_sl_5dhcl9gqwz_e"
            
        case "Amazon Echo":
            urlString = "https://www.amazon.com/dp/B07456BG8N?tag=googhydr-20&hvadid=%7Bcreative%7D&hvpos=%7Badposition%7D&hvnetw=%7Bnetwork%7D&hvrand=%7Brandom%7D&hvpone=%7Bparam1%7D&hvptwo=%7Bparam2%7D&hvqmt=%7Bmatchtype%7D&hvdev=%7Bdevice%7D&hvdvcmdl=%7Bdevicemodel%7D&hvlocint=%7Bloc_interest_ms%7D&hvlocphy=%7Bloc_physical_ms%7D&hvtargid=%7Btargetid%7D&ref=pd_sl_3g07419rwu_e"
            
        case "Amazon Fire HD":
            urlString = "https://www.amazon.com/dp/B01J6RPGKG"
            
        case "Windows Phone 8":
            urlString = "https://www.microsoft.com/en-us/store/b/mobile"
            
        case "Microsoft Nokia Lumia":
            urlString = "https://www.microsoft.com/en-ww/mobile/phones/lumia"
            
        case "Windows Surface":
            urlString = "https://www.microsoft.com/en-us/store/b/surface?invsrc=search&cl_vend=google&cl_ch=sem&cl_camp=907269320&cl_adg=47974157511&cl_crtv=284450611193&cl_kw=+surface&cl_pub=google.com&cl_place=&cl_dvt=c&cl_pos=1t1&cl_mt=b&cl_gtid=kwd-488544306872&cl_pltr=&cl_dim0=W5brhAAAAYkj87pa:20180910220908:s&OCID=AID695933_SEM_W5brhAAAAYkj87pa:20180910220908:s&s_kwcid=AL!4249!3!284450611193!b!!g!!%2Bsurface&ef_id=W5brhAAAAYkj87pa:20180910220908:s"
            
        default:
            return
        }
        
        //don't need the url: URL = sytax - swift will figure it out. we really only use those for literals, e.g. let cgFloat: CGFloat = 10.0
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
>>>>>>> 8bbe0ef0ab3a964b54068ab060e4310b64041f8b
        webView.load(urlRequest)
    }
}
