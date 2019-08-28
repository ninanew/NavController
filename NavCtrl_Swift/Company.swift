//
//  CompanyModel.swift
//  NavCtrl_Swift
//
//  Created by Kristina Neuwirth on 10/1/18.
//  Copyright © 2018 turntotech. All rights reserved.
//

import Foundation

struct Company {
    
    let name: String
    let imageUrl: String
    let stockTicker: String
    var products: [Product]?
    let stockPrice: Stock?
    let core: CoreCompany?
    
    init(withCore company: CoreCompany) {
        self.name = company.name ?? ""
        self.imageUrl = company.imageUrl ?? ""
        self.stockTicker = company.stockTicker ?? ""
        self.products = nil
        self.stockPrice = nil
        self.core = company
    }
    
    init(name: String, imageUrl: String, stockTicker: String, products: [Product]?=nil, stockPrice: Stock?=nil) {
        self.name = name
        self.imageUrl = imageUrl
        self.stockTicker = stockTicker
        self.products = products
        self.stockPrice = stockPrice
        self.core = nil
    }
    
}
