//
//  Stocks.swift
//  NavCtrl_Swift
//
//  Created by Kristina Neuwirth on 1/16/19.
//  Copyright © 2019 turntotech. All rights reserved.
//

import Foundation


class Stock {
    
  //  var companyAddOn : CompanyAddOn
//    var delegate: StockDelegate?
    
    let symbol: String
    let price: String
    
    enum SerializationError:Error {
        case missing (String)
        case invalid (String, Any)
    }
    
    init(json:[String:Any]) throws {
        guard let symbol = json["01. symbol"] as? String else {throw SerializationError.missing("Symbol is missing")}
        guard let price = json["05. price"] as? String else {throw SerializationError.missing("Price is missing")}
            
            self.symbol = symbol
            self.price = price
        
        }
    
    
    
   // static let basePath = "https://www.alphavantage.co/queryfunction=TIME_SERIES_DAILY&symbol=MSFT&apikey=9TGRNY2XC629OP3Q"
    
   // let url = basePath
   // let request = URLRequest(url:URL(string:url)!)

}
